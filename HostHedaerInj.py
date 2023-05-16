import requests

def check_redirect(url, headers):
    response = requests.get(url, headers=headers, allow_redirects=False)
    
    if response.status_code == 301 or response.status_code == 302:
        print(f"URL {url} is redirecting to {response.headers['Location']}")
    else:
        print(f"URL {url} is not redirecting.")

# Prompt the user for the URL
url = input("Enter the URL: ")

# Define a list of headers to test with example.com changed to evil.com
payloads = [
    {'Host': 'evil.com'},
    {'X-Forwarded-Host': 'evil.com'},
    {'X-Forwarded-For': '127.0.0.1', 'Host': 'evil.com'},
    {'X-Client-IP': '127.0.0.1', 'Host': 'evil.com'},
    {'X-Remote-IP': '127.0.0.1', 'Host': 'evil.com'},
    {'X-Remote-Addr': '127.0.0.1', 'Host': 'evil.com'},
    {'X-Host': 'evil.com'}
]

# Call the function to check redirection for each payload
for payload in payloads:
    check_redirect(url, payload)

# Print author name in big format
print("""
Author: Rahul
""")
