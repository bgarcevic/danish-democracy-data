import requests
import os
import json
import sys
from datetime import datetime

import requests
import os
import json
import sys
from datetime import datetime

def retrieve_data(api_url, folder_path, base_file_name):
    all_data = []

    # Loop until all pages have been retrieved
    while api_url is not None:
        try:
            # Request data from the API
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
            all_data.extend(response.json()["value"])

            # Update the API URL for the next iteration
            api_url = response.json().get('odata.nextLink', None)

    # Get the current date and format it as a string
    date_string = datetime.now().strftime('%Y_%m_%d')

    # Create a filename with the date
    filename = f'{base_file_name}_{date_string}'

    # Get the full path to the file
    file_path = os.path.join(folder_path, filename)

    try:
        # Save the data to a file
        with open(file_path, 'w') as file:
            json.dump(all_data, file)

        print(f"Data saved to {file_path}")

    except IOError as e:
        print(f"I/O error({e.errno}): {e.strerror}")
    except: # handle other exceptions such as attribute errors
        print("Unexpected error:", sys.exc_info()[0])

# Call the function
retrieve_data('API_URL', 'YOUR_FOLDER_PATH', 'YOUR_FILE_NAME')

api_url = 'https://api.example.com/v1/data?$skip=0'
folder_path = '../data/'
file_name = 'afstemning'
retrieve_data(api_url, folder_path, file_name)
