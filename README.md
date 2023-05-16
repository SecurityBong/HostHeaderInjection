# HostHeaderInjection

**Description**
The HTTP host header is a request header that specifies the domain that a client (browser) wants to access. This header is necessary because it is pretty standard for servers to host websites and applications at the same IP address. However, they don’t automatically know where to direct the request. 

When the server receives a request, it checks the host header parameter to determine which domain needs to process the request and then dispatches it. Sometimes the header may be amended in being routed to the appropriate domain. That is where the host header injection may occur.
It is a automated host header injection scanning tool in a basic manner. It is based on python.

**Important**
Note: It is only applicable to HTTPS. It is still in developement phase.

To run the script do use this command:
```
  python3 hostheaderinj.py
```
