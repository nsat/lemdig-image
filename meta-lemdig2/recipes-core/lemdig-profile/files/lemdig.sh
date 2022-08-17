# LEMDIG-specific profile settings
# Added by lemdig/bitbake/meta-lemdig2/recipes-core/lemdig-profile/lemdig-profile.bb

# Prefix for on-orbit installed packages
export SPIRE_LOCAL_PREFIX="/usr/local"
# Prefix for on-orbit installed Python packages
export SPIRE_PYTHON_LOCAL_SITEPACKAGES="${SPIRE_LOCAL_PREFIX}/lib/python2.7/site-packages"
# Add local package bin location to path
export PATH="${SPIRE_LOCAL_PREFIX}/bin:${PATH}"

# Apply all profile scripts in /usr/local/etc/profile.d
if [ -d "/usr/local/etc/profile.d" ]; then
  for profile_script in /usr/local/etc/profile.d/* ; do
    . "${profile_script}"
  done
  unset profile_script
fi
