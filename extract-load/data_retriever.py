import requests
import os
import json
import sys
from datetime import datetime

def retrieve_data(api_url, base_file_name):
    all_data = []

    # Initialize a counter for the number of items retrieved
    items_retrieved = 0

    # Loop until all pages have been retrieved
    while api_url is not None:
        try:
            # Request data from the API
            print(f"Sending request to {api_url}...")
            response = requests.get(api_url, timeout=10)

            # Raise an exception if the request was unsuccessful
            response.raise_for_status()

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

    # Get the current date and format it as a string
    date_string = datetime.now().strftime('%Y%m%d')

    # Create a filename with the date
    filename = f'{base_file_name}_{date_string}'

    # Get the directory that this script is in
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Go up one level and then into the 'data' directory
    data_dir = os.path.join(script_dir, '..', 'data')

    # Get the full path to the file
    file_path = os.path.join(data_dir, filename)

    # Check if directory exists, create it if it doesn't
    os.makedirs(os.path.dirname(file_path), exist_ok=True)

    try:
        # Save the data to a file
        with open(file_path, 'w') as file:
            json.dump(all_data, file)

        print(f"Data saved to {file_path}")

    except IOError as e:
        print(f"I/O error({e.errno}): {e.strerror}")
    except: # handle other exceptions such as attribute errors
        print("Unexpected error:", sys.exc_info()[0])


file_name = 'Afstemning'
api_url = f'https://oda.ft.dk/api/{file_name}?$inlinecount=allpages'


retrieve_data(api_url, file_name)
