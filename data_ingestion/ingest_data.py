import requests
import pandas as pd
import os
from google.cloud import storage


# Extract data from api and convert to dataframe
def extract_data():
    url = "https://fakestoreapi.com/products"
    
    try:
        response = requests.get(url)
        response.raise_for_status()  
        print("Successful retrevial !")
        data = response.json()  # Convert response to JSON
        df = pd.json_normalize(data)  #  Convert JSON to dataframe pandas
        return df
    except requests.exceptions.RequestException as e:
        print(f"Data retrevial error : {e}")
        raise  
    except Exception as e:
        print(f"General error : {e}")
        raise

# Function for saving data in CSV format and uploading them to GCS
def save_and_upload_to_gcs(df, bucket_name, destination_blob_name, local_filename='product_data.csv'):
    try:
        df.to_csv(local_filename, index=False)
        print(f"The data has been saved in {local_filename}")
        
        # Uploading to GCS
        storage_client = storage.Client()
        bucket = storage_client.get_bucket(bucket_name)
        blob = bucket.blob(destination_blob_name)
        blob.upload_from_filename(local_filename)
        print(f"The file {local_filename} has been uploaded to the {bucket_name} under the name {destination_blob_name}")
    except Exception as e:
        print(f"Error when uploading to GCS : {e}")
        raise  


def main():
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "C://Users//jonat//Downloads//use-case-eyfabernovel-7101aa4ad578.json"
    bucket_name = 'bucket_data_eyfab' 
    destination_blob_name = 'product_data.csv' 
    
    try:
        # Step 1 : Data retrevial 
        df = extract_data()
        # Step 2 : Data Storage
        save_and_upload_to_gcs(df, bucket_name, destination_blob_name)
    except Exception as e:
        print("An error occurred during the data extraction and upload process.")

if __name__ == "__main__":
    main()
