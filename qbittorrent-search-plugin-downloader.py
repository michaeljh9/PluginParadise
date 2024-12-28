import os
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin

def download_py_files(github_url, output_folder=None):
    # Create the default output folder on the desktop if not specified
    if output_folder is None:
        desktop_path = os.path.expanduser("~/Desktop")
        output_folder = os.path.join(desktop_path, "engines")
    
    # Ensure the output folder exists
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
    
    # Send a request to fetch the page content
    response = requests.get(github_url)
    if response.status_code != 200:
        print(f"Error: Unable to fetch page (status code {response.status_code})")
        return
    
    # Parse the HTML content with BeautifulSoup
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Find the table element (you can adjust this if there are specific attributes or ids)
    table = soup.find('table')
    if not table:
        print("Error: No table found on the page.")
        return
    
    # Find all the links (<a>) within the table and check if they point to *.py files
    links = table.find_all('a', href=True)
    
    # Filter out the links that end with .py
    py_files = [urljoin(github_url, link['href']) for link in links if link['href'].endswith('.py')]
    
    if not py_files:
        print("No Python files found in the table.")
        return
    
    # Download each .py file
    for py_file_url in py_files:
        # Get the file name from the URL
        file_name = py_file_url.split('/')[-1]
        file_path = os.path.join(output_folder, file_name)
        
        # Check if the file already exists
        if os.path.exists(file_path):
            print(f"Skipping {file_name}, already exists.")
            continue
        
        # Download the file
        print(f"Downloading {file_name}...")
        file_response = requests.get(py_file_url)
        
        # Save the content to a local file
        if file_response.status_code == 200:
            with open(file_path, 'wb') as f:
                f.write(file_response.content)
            print(f"Downloaded: {file_name}")
        else:
            print(f"Failed to download {file_name} (status code {file_response.status_code}).")
    
    # Print completion message
    print(f"\nFiles have been downloaded to {output_folder}\nFrom inside of qBittorrent, use the 'Search Plugins...' button to import them. Do not copy-paste into the qBittorrent's .local subfolder. Use qBittorrent to import them.\n")

if __name__ == "__main__":
    # Example usage:
    github_url = "https://github.com/qbittorrent/search-plugins/wiki/Unofficial-search-plugins"
    download_py_files(github_url)
