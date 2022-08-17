#! /bin/sh
### BEGIN INIT INFO
# Provides:          initlocal
# Required-Start:    $local_fs
# Required-Stop:     $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Run locally installed init scripts
### END INIT INFO

local_init_dir="/usr/local/etc/init.d"
[ ! -d ${local_init_dir} ] && exit 0

for init_script in $(ls -1 ${local_init_dir} | sort); do
echo "Running local init script ${init_script} ${1}"
    "${local_init_dir}/${init_script}" ${1}
done
