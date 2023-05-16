#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

if [ -z "$1" ]; then
  echo "Please provide a URL or a file containing URLs."
  exit 1
fi

if [ -f "$1" ]; then
  # Read URLs from a file
  urls=$(cat "$1")
else
  # Use single URL provided as argument
  urls="$1"
fi

# List of payloads to test
payloads=("malicious.com" "localhost" "127.0.0.1" "example.com")

for url in $urls; do
  echo "Testing: $url"

  vulnerable=false

  for payload in "${payloads[@]}"; do
    # Send a request with a modified host header and check the response
    response=$(curl -s -I -H "Host: $payload" "$url")

    if [[ "$response" =~ "$payload" ]]; then
      echo -e "${RED}Payload: $payload - Vulnerable${NC}"
      vulnerable=true
      break
    fi
  done

  if [ "$vulnerable" = false ]; then
    echo -e "${GREEN}Not Vulnerable${NC}"
  fi

  echo ""
done
