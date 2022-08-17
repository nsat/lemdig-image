# Python 2.7 site-specific configuration file for LEMDIG
import sys
import site

local_site_packages = "/usr/local/lib/python2.7/site-packages"

try:
    path_index = sys.path.index(local_site_packages)
except ValueError:
    initial_sys_path_length = len(sys.path)
    # Add the local site-packages directory to the path.
    # Note that packages installed here will be priortized over base system packages when importing.
    site.addsitedir(local_site_packages)
    # Quite hacky: Move the "local_site_packages" path to the beginning of sys.path so that packages within it
    # will override packages stored in the default site-packages. This is so that we can override Python
    # packages installed on the read-only rootfs with packages installed to a RW partition.
    sys.path = sys.path[initial_sys_path_length:] + sys.path[:initial_sys_path_length]
else:
    if path_index:
        sys.path.insert(0, sys.path.pop(path_index))
