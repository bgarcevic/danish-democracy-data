import requests
import os
import json
import sys
import concurrent.futures
from datetime import datetime

def make_api_request(api_url):
    # Request data from the API
    print(f"Sending request to {api_url}...")
    response = requests.get(api_url, timeout=10)

    # Raise an exception if the request was unsuccessful
    response.raise_for_status()

    return response

def extract_api_data(api_url):
    all_data = []

    # Initialize a counter for the number of items retrieved
    items_retrieved = 0

    # Loop until all pages have been retrieved
    while api_url is not None:
        try:
            response = make_api_request(api_url)
        except requests.exceptions.RequestException as err:
            print ("OOps: Something Else Happened",err)
            break
        except requests.exceptions.HTTPError as errh:
            print ("Http Error:",errh)
            break
        except requests.exceptions.ConnectionError as errc:
            print ("Error Connecting:",errc)
            break
        except requests.exceptions.Timeout as errt:
            print ("Timeout Error:",errt)
            break
        else:
            # Add data to all_data list
            data = response.json()["value"]
            all_data.extend(data)

            # Print out the number of items retrieved
            items_retrieved += len(data)
            print(f"Retrieved {items_retrieved} items so far...")

            # Update the API URL for the next iteration
            api_url = response.json().get('odata.nextLink', None)

    return all_data

def construct_file_path(base_file_name, file_type='json', is_timestamp_file=False):
    # Get the current date and format it as a string
    date_string = datetime.now().strftime('%Y%m%d')
    base_file_name_lower = base_file_name.lower()

    # Get the directory that this script is in
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Go up one level and then into the 'data' directory
    data_dir = os.path.join(script_dir, '..', f'data/{base_file_name_lower}') 

    if is_timestamp_file:
        # Create a filename for the timestamp file
        filename = f'last_run_{base_file_name_lower}.json'
    else:
        # Create a filename with the date
        filename = f'{base_file_name_lower}_{date_string}.{file_type}'

    # Get the full path to the file
    file_path = os.path.join(data_dir, filename)

    # Check if directory exists, create it if it doesn't
    os.makedirs(os.path.dirname(file_path), exist_ok=True)

    return file_path


def save_data(data, file_path):
    try:
        # Save the data to a file
        with open(file_path, 'w') as file:
            json.dump(data, file)

        print(f"Data saved to {file_path}")

    except IOError as e:
        print(f"I/O error({e.errno}): {e.strerror}")
    except: # handle other exceptions such as attribute errors
        print("Unexpected error:", sys.exc_info()[0])

def retrieve_data(api_url, base_file_name):
    # Retrieve data from the API
    all_data = extract_api_data(api_url)
    file_path = construct_file_path(base_file_name)
    save_data(all_data, file_path)
    
    # Save the timestamp of the last run
    file_path_last_run = construct_file_path(base_file_name, is_timestamp_file=True)
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    save_data({"last_run": timestamp}, file_path_last_run)

# add python main file check
if __name__ == "__main__":        
    file_names = ['Afstemning', 'Afstemningstype', 'Møde', 'Sagstrin', 'Stemme', "Stemmetype", "Aktør"]
    with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        for file_name in file_names:
            api_url = f'https://oda.ft.dk/api/{file_name}?$inlinecount=allpages'

            # Submit a new task to the executor
            executor.submit(retrieve_data, api_url, file_name)
