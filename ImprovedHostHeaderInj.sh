#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Display author name
echo -e "Author: ${RED}Security Bong${NC}"
echo ""

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

payloads=(
  "example.com"
  "127.0.0.1"
  "localhost"
  "malicious.com"
  "evil.com"
)

headers=(
  "X-Forwarded-Host: malicious.com"
  "Referer: malicious.com"
  "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537"
)

for url in $urls; do
  echo "Testing: $url"

  # Check if the URL is alive
  if ! curl -s --head --connect-timeout 5 "$url" > /dev/null; then
    echo -e "${RED}The URL is not alive${NC}"
    echo ""
    if [ -f "$1" ]; then
      continue
    else
      exit 1
    fi
  fi

  vulnerable=false

  # Test host header injection
  for payload in "${payloads[@]}"; do
    response=$(curl -s -I -H "Host: $payload" "$url")

    if [[ "$response" =~ "$payload" ]]; then
      echo -e "${RED}Host Header: Host: $payload - Vulnerable${NC}"
      vulnerable=true
      break
    fi
  done

  # Test additional headers injection
  for header in "${headers[@]}"; do
    response=$(curl -s -I -H "$header" "$url")

    if [[ "$response" =~ "malicious.com" ]]; then
      echo -e "${RED}Additional Header: $header - Vulnerable${NC}"
      vulnerable=true
      break
    fi
  done

  if [ "$vulnerable" = false ]; then
    echo -e "${GREEN}Not Vulnerable${NC}"
  fi

  echo ""
done
