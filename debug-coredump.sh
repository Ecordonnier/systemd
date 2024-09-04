#!/bin/zsh
#zsh necessary because bash can't have NULL characters in variables

# Use with:
# sudo bash -c 'echo "|/home/ecordonnier/dev/systemd/debug-coredump.sh %P %u %g %s %t %c %h" > /proc/sys/kernel/core_pattern'

# Restore default:
# sudo bash -c 'echo "|/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h" > /proc/sys/kernel/core_pattern'

echo "start debug-coredump.sh ${@}" > /dev/kmsg

cat - > /tmp/coredump
MYSTDIN=$(</tmp/coredump)
LANG=C LC_ALL=C
echo ${#MYSTDIN} > /tmp/size
printf '%s' "${MYSTDIN}" > /tmp/coredump2
LD_LIBRARY_PATH=/home/ecordonnier/dev/systemd/build/src/shared/ /home/ecordonnier/dev/systemd/build/systemd-coredump $@ <<< ${MYSTDIN} >/dev/kmsg 2>&1
