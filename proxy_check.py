#!/usr/bin/python

import socks
import sys
import shutil


try:
    s = socks.socksocket() # Same API as socket.socket in the standard lib
    s.settimeout(1.0)
    s.connect(("www.baidu.com", 80))
    s.close()
except IOError:
    shutil.copy("/usr/local/www/nginx/index_fail_fail.html", "/usr/local/www/nginx/index.html")
    sys.exit(1)
else:
    s = socks.socksocket() # Same API as socket.socket in the standard lib
    s.settimeout(1.0)
    s.set_proxy(socks.SOCKS5, "192.168.0.165", 1080) # SOCKS4 and SOCKS5 use port 1080 by default
    # Can be treated identical to a regular socket object
    try:
        s.settimeout(1.0)
        s.connect(("www.google.com", 80))
        s.close()
    except IOError:
        shutil.copy("/usr/local/www/nginx/index_ok_fail.html", "/usr/local/www/nginx/index.html")
        sys.exit(1)
    else:
        shutil.copy("/usr/local/www/nginx/index_ok_ok.html", "/usr/local/www/nginx/index.html")
        sys.exit(0)
