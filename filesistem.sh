#!/bin/bash
#/etc/init.d/resize_write
### BEGIN INIT INFO
# Provides:          resize_write
# Required-Start:    $syslog
# Required-Stop:     $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: add service resize_write
# Description:
#
### END INIT INFO

case "$1" in
  start)
        echo "Starting resize_write "
        #How to know if /root/dev exists. -h verify if there is a symlink.
        if ! [ -h /dev/root ]; then
        echo "xy-filexpand_error: /dev/root does not exist or is not a symlink. Don't know how to expand" >> /var/log/xy-filexpand.log
        return 0
        fi
        #Which partition has root.
        ROOT_PART=$(readlink /dev/root)
        #Partition number which contents root.
        PART_NUM=${ROOT_PART#mmcblk0p}

        if [ "$PART_NUM" = "$ROOT_PART" ]; then
                echo "xy-filexpand_error: /dev/root is not an SD card. Don't know how to expand" > /var/log/xy-filexpand.log
                return 0
        fi

        # NOTE: the NOOBS partition layout confuses parted. For now, let's only 
        # agree to work with a sufficiently simple partition layout
        if [ "$PART_NUM" -ne 2 ]; then
                echo "partition root must be number 2 and it is not" > /var/log/xy-filexpand.log
                return 0
        fi

        LAST_PART_NUM=$(parted /dev/mmcblk0 -ms unit s p | tail -n 1 | cut -f 1 -d:)

        if [ "$LAST_PART_NUM" != "$PART_NUM" ]; then
                echo "xy-filexpand_error: /dev/root is not the last partition. Don't know how to expand" > /var/log/xy-filexpand.log
                return 0
        fi

        # Get the starting offset of the root partition
        PART_START=$(parted /dev/mmcblk0 -ms unit s p | grep "^${PART_NUM}" | cut -f 2 -d:)
        [ "$PART_START" ] || return 1
        # Return value will likely be error for fdisk as it fails to reload the
        # partition table because the root fs is mounted
        fdisk /dev/mmcblk0 <<EOF
        p
        d
        $PART_NUM
        n
        p
        $PART_NUM
        $PART_START

        p
        w
EOF

         #So far, we have change the partition size table, now we have to create a service to be executed once and then change
        #the partition for real.

        #We must create a service to be executed on boot and then delete it for not being executed anymore.

        echo "#!/bin/bash" > /etc/init.d/resize_execute
        echo "#/etc/init.d/resize_execute" >> /etc/init.d/resize_execute
        echo "### BEGIN INIT INFO" >> /etc/init.d/resize_execute
        echo "# Provides:          resize_execute" >> /etc/init.d/resize_execute
        echo "# Required-Start:     \$syslog" >> /etc/init.d/resize_execute
        echo "# Required-Stop:      \$syslog" >> /etc/init.d/resize_execute
        echo "# Default-Start:    2 3 4 5" >> /etc/init.d/resize_execute
        echo "# Default-Stop:     0 1 6" >> /etc/init.d/resize_execute
        echo "# Short-Description: Resize the root filesystem to fill partition" >> /etc/init.d/resize_execute
        echo "# Description:" >> /etc/init.d/resize_execute
        echo "### END INIT INFO" >> /etc/init.d/resize_execute

        echo "case \"\$1\" in" >> /etc/init.d/resize_execute
        echo "start)" >> /etc/init.d/resize_execute
        echo "Resizing filesystem" >> /etc/init.d/resize_execute
        echo "resize2fs /dev/root" >> /etc/init.d/resize_execute
        echo "update-rc.d resize_execute remove" >> /etc/init.d/resize_execute
        echo "rm /etc/init.d/resize_write" >> /etc/init.d/resize_execute
        echo "rm /etc/init.d/resize_execute" >> /etc/init.d/resize_execute
        echo ";;" >> /etc/init.d/resize_execute
        echo "*)" >> /etc/init.d/resize_execute
        echo "echo \"[Just run on boot]\""
        echo "exit 1" >> /etc/init.d/resize_execute
        echo ";;" >> /etc/init.d/resize_execute
        echo "esac" >> /etc/init.d/resize_execute
        echo "exit 0" >> /etc/init.d/resize_execute
      
        chmod +x /etc/init.d/resize_execute
        update-rc.d resize_execute defaults
        update-rc.d resize_write remove
        reboot
        ;;
        *)
        echo "[RESIZE]Resize on next boot"
        exit 1
        ;;
        esac
exit 0
