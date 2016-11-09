import socks
import sys

s = socks.socksocket() # Same API as socket.socket in the standard lib

s.set_proxy(socks.SOCKS5, "192.168.0.165", 1080) # SOCKS4 and SOCKS5 use port 1080 by default
# Can be treated identical to a regular socket object
try:
    s.settimeout(1.0)
    s.connect(("www.google.com", 80))
    s.close()
except IOError:
    print "Connection error! (Check proxy)"
    sys.exit(1)
else:
    print "All was fine"
    sys.exit(0)
