#!/bin/bash

source ./backup-params.env

#for the gio to work in ubuntu using crontab
export XDG_DATA_DIRS=/usr/share/xubuntu:/usr/local/share/:/usr/share/:/var/lib/snapd/desktop
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

docker stop $valheim_container

echo "backup time"
if [ ! -z "$smb_backup_server" ];then
        cred_string="$smb_user\nWORKGROUP\n$smb_password\n"
        date_str="$(date +%4Y%m%d%H%M%S)"
        echo -e $cred_string | gio mount smb://$smb_backup_server/$smb_path
        echo -e $cred_string | gio copy --progress "$save_path/worlds_local/$world_name.db" "smb://$smb_backup_server/$smb_path/$backup_path/$world_name.db.$date_str"
        echo -e $cred_string | gio copy --progress "$save_path/worlds_local/$world_name.fwl" "smb://$smb_backup_server/$smb_path/$backup_path/$world_name.fwl.$date_str"

        while [ "$(echo -e $cred_string | gio list smb://$smb_backup_server/$smb_path/$backup_path/|grep '.db.'|wc -l)" -gt "4" ]; do
                db_file=$(echo -e $cred_string | gio list smb://$smb_backup_server/$smb_path/$backup_path/|grep '.db.'|sort|head -n 1)
                date=${db_file: -14}
                echo "bigger than 4, next to delete $world_name.db.$date, $world_name.fwl.$date"
                echo -e $cred_string | gio remove "smb://$smb_backup_server/$smb_path/$backup_path/$world_name.db.$date"
                echo -e $cred_string | gio remove "smb://$smb_backup_server/$smb_path/$backup_path/$world_name.fwl.$date"
        done

        echo -e $cred_string | gio mount -u smb://$smb_backup_server/$smb_path
elif [ ! -z "$backup_path" ];then
        date_str="$(date +%4Y%m%d%H%M%S)"
        cp "$save_path/worlds_local/$world_name.db" "$backup_path/$world_name.db.$date_str"
        cp "$save_path/worlds_local/$world_name.fwl" "$backup_path/$world_name.fwl.$date_str"

        while [ "$(ls $backup_path/|grep '.db.'|wc -l)" -gt "4" ]; do
                db_file=$(ls $backup_path/|grep '.db.'|sort|head -n 1)
                date=${db_file: -14}
                echo "bigger than 4, next to delete $world_name.db.$date, $world_name.fwl.$date"
                rm "$backup_path/$world_name.db.$date"
                rm "$backup_path/$world_name.fwl.$date"
        done
else
        echo "No backup paths, the world won't be copied"
fi

echo "starting container"
docker start $valheim_container
