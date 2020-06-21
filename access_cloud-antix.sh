#!/bin/bash
# Rclone "remote" drive mounter script v0.7 , GPL licence, by PPC, 19/6/2020
##############
#### Check for dependencies, clear files, set variables ####
#Check for needed utilities:
## testing for  yad
	if ! [ -x "$(command -v yad)" ]; then
	 yad --title="Access Cloud Storage- Error" --window-icon=/usr/share/icons/papirus-antix/48x48/places/folder-red-meocloud.png --center --text=" Please install yad using your Package Manager! "
		exit 1
	fi
## testing for rclone
	if ! [ -x "$(command -v rclone)" ]; then
	 yad --title="Access Cloud Storage- Error" --window-icon=/usr/share/icons/papirus-antix/48x48/places/folder-red-meocloud.png --center --text=" Please install rclone using your Package Manager! "
		exit 1
	fi
#Clear log file(s), export function(s), set global variables:
rm /tmp/rclone_remote_list.txt
# Generate log file with configured "remote" cloud drives and check if log file is empty, if so,  present user with option to configure a new cloud "remote" drive
rclone listremotes > /tmp/rclone_remote_list.txt
log_file="/tmp/rclone_remote_list.txt"
[ -s $log_file ] || Manage_remotes


Help(){
# show Help screen
yad --title="Access Cloud Storage - Help" --window-icon=/usr/share/icons/papirus-antix/48x48/places/folder-red-meocloud.png --center --width=450 --height=550  --fixed --text="\n What is this: \n This application makes many Cloud storage devices, like Google Drive, Ms One Drive, etc, accessible from your default File Manager, just like they were a network drive or a thumb-drive. \n  This is simply a Graphics User Interface for rclone, that is used to mount those services. \n \n What this is not:\n This is not a way to sync a folder with any cloud service, so, if you don't have access to the Internet, you have no local copy of any file stored on the cloud (unless you previously downloaded it to your computer).\n \n Notes:\n -To view the contents of some cloud drives, like OneDrive, you may need to refresh your File Manager.\n -When the user starts a 'remote' cloud drive, a tray icon is launched, to provide easy access to the main menu. This tray icon only closes when the 'Quit' button is pressed. \n \n How to configure your cloud storage service:\n 1- When you launch this application for the first time you are shown the 'Manage' menu, that allows you to try to automaticaly configure your Google Drive Account. \n If you click the 'Google Drive' Button, your internet browser opens on your cloud account service. You have to log on and autorise 'rclone' access to your account. After the config process is done, if you don't want to configure more services, click the 'Quit' button and the main Window pops up. From there you can double left click your Cloud account name, to access it's contents. \n At any time, in the main window, if you click the 'Manage drives' button, will will be presented with the initial configuration menu. \n 2- Manually configuring cloud storage services: \n if you click the 'Manage' button, a terminal will pop open. You have to use the keyboard to perform your selections. After you finished seting up your cloud service, press 'q' from the main terminal menu to exit. Restart this application to access the 'remote' drives you just configured. \n \n SECURITY WARNING: \n Do not use this application on a shared computer, because this provides access to your cloud accounts without any need of entering a password!!!" --button="On line help":'desktop-defaults-run -b rclone.org/drive/' --button="Close":1	
} # end of 'Help' function

Manage_remotes(){
	export -f Help Main_window
	
	# Manage "remotes" or automaticaly add a Google Drive account- this automaticaly pops up if no "remote" cloud drives are configured
	yad --title="Access Cloud Storage - Configuration" --window-icon=/usr/share/icons/papirus-antix/48x48/places/folder-red-meocloud.png --center --text="\n Use the buttons bellow to configure a 'remote' Cloud account \n You can access an on-line example of how to manually configure a Google Drive account from the Help window. \n  " --button="Manage Cloud Drives":'desktop-defaults-run -t rclone config' --button="Automatically add Google Drive":'desktop-defaults-run -t rclone config create GoogleDrive drive config_is_local false' --button="Tray icon":3 --button="Help":"bash -c Help" --button="Close":4
	
	 foo=$?
		if [[ $foo -eq 3 ]]; then
			tray=$(s) && echo $tray > /tmp/rclone_tray.txt
		fi
		
	Main_window
	
	} #end of 'Manage_remotes' funtion
	
Main_window(){
### Main Window ####
### export functions, set variables:
export -f Help Manage_remotes Main_window
now=`date +"%Y-%m-%d"`
# Choose an existing "remote" cloud service using yad (or unmount or manage "remotes")
 rclone listremotes > /tmp/rclone_remote_list.txt
 log_file="/tmp/rclone_remote_list.txt"
 selection=$(yad --title="Access Cloud Storage" --window-icon=/usr/share/icons/papirus-antix/48x48/places/folder-red-meocloud.png --width=550 --height=400 --center --separator=" " --list  --column=" Double click the 'remote' Cloud service that you want to access "  --button="Unmount all 'remote' Drives":1 --button="Configuration":2 --button="Help":"bash -c Help" --button=gtk-quit:3 < /tmp/rclone_remote_list.txt)
 foo=$?

if [[ $foo -eq 3 ]]; then
	pkill yad
	exit 1
fi

if [[ $foo -eq 2 ]]; then
	Manage_remotes
fi

if [[ $foo -eq 1 ]]; then
	# unmount all "remote" cloud drives
	pkill rclone
    # Try to delete empty mountpoint directories listed in log file:
file=~/.config/rclone/mountpoint_list.conf
lines=`cat $file`
for line in $lines; do
printf "\n**Trying to remove moint point: ${line} **\n\n"
eval fusermount -u ~/"${line}"
eval rmdir ~/"${line}"
done
	# Delete log file
	rm $file	
	Main_window
fi

####This avoids errors, if no selection was made (example: user closed the window):
if [ -z "$selection" ]; then
		exit 1
fi

#### Mount and show "remote" cloud drive:
# create a mount point using the same name as the remote, without spaces, AND CURRENT DATE to avoid problems:
mount_point=$(echo $selection | sed 's/.$//')
mount_point_no_spaces=$(echo $mount_point | sed -e 's/ //g')
mount_point_no_spaces=$mount_point_no_spaces-${now}
mkdir ~/$mount_point_no_spaces
# add name of directory to a config file, to be able to, when unmounting, also delete the empty mount point folder
( echo $mount_point_no_spaces ; echo "" ) >> ~/.config/rclone/mountpoint_list.conf
# mount the cloud service
comma="'"
and="&"
myVar=$(echo "rclone --vfs-cache-mode writes mount "${comma}""${selection}"${comma}")
myVar2=`echo $myVar | sed -E 's/.(.)$/\1/'`
eval "nohup  $myVar2 ~/$mount_point_no_spaces $and"
echo  Running mount command: $myVar2 ~/$mount_point_no_spaces

#show the cloud service contents on the default file manager: for other distros other than antiX, that have xdg-open installed uncoment the following line and comment the "desktop-defaults" one...
 #xdg-open "~\$mount_point_no_spaces"  
desktop-defaults-run -fm ~/$mount_point_no_spaces
} #end of 'Main_window' funtion

export -f Help Manage_remotes Main_window
#Start Main window:
Main_window

#Show traybar icon (if user checked the Tray checkbox, in the main window, on by default): (the pkill yad garantees that there are no multiple instances of the icon on the toolbar, unfortunatly, also closes any other running yad window (TO-DO: find another way to avoid multiple instances) 
tray="TRUE|"
if grep -Fxq $tray /tmp/rclone_tray.txt ;then
    pkill yad
yad --notification --image="/usr/share/icons/papirus-antix/48x48/places/folder-red-meocloud.png" --command="bash -c Main_window" --text="Left click: Access Cloud Storage (Middle click: exits)"
else
echo  Show Tray icon is set to:
cat /tmp/rclone_tray.txt
Main_window
#    exit 1
fi
