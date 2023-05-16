# HostHeaderInjection

**Description:**
The HTTP host header is a request header that specifies the domain that a client (browser) wants to access. This header is necessary because it is pretty standard for servers to host websites and applications at the same IP address. However, they don’t automatically know where to direct the request. 
When the server receives a request, it checks the host header parameter to determine which domain needs to process the request and then dispatches it. Sometimes the header may be amended in being routed to the appropriate domain. That is where the host header injection may occur.

It is an automated host header injection attacking and scanning tool. It is based on bash.

**Important:**
It is only applicable to HTTPS. It is still in developement phase.
The script will go over each URL, send a request with a modified host header ("Host: malicious.com"), and check if the response contains the modified host. If it does, it will print "Vulnerable" in red color; otherwise, it will print "Not Vulnerable" in green color. It will also print the header which it uses for the successfull attacking.

**Note:**
chmod +x HostHeaderInj.sh

**Run:**
To run the script do use this command:
```
  # Test a single URL
./HostHeaderInj.sh http://example.com

# Test multiple URLs from a file
./HostHeaderInj.sh urls.txt

```
