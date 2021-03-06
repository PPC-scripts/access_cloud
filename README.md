# access_cloud
 ## This is a script is a simple GUI for rclone.
It can be configured with many existing cloud storage services (like Google Drive and Ms OneDrive, etc), mouting (and unmounting) those "remote" drives so they can be used just like they were regular network drives, on Linux

 The script was made using antiX Linux, and is originaly meant to be used on that OS (tested in antiX 19.x 64 bits).
 
 ## How to use this script:
  At first launch, the script checks if rclone has any configured "remote" cloud storage services. If none is found, a configuration window pops up.
  - Configuration Window:
  Configuring Google Drive can be done automaticaly, by pressing a button. All other cloud storage services have to be configured using the keyboard, via a terminal interface, by pressing the "Manage Cloud Drives" button.
  At the configuration window you can also select if you want to use a tray icon (that is launched only after you use the script to access a "remote" drive).
 - Main Window:
  All configured "remote" drive names are listed. Double click one from the list and it's mounted and it's contents shown in the default file browser (see below how to set that up if you are not using antiX Linux).
  The "Unmount all..." button does what it says- the closes the connection with any rclone mounted "remote" cloud service.
  The "Config" and "help" button are self exaplanatory.
  The "Quit" button does not only close the application but also closes the application's tray, if it's running.

## How to install this application:
 First make sure you have the required dependencies (Note: in antiX, during the first run, the script allows the user to automaticaly install rclone. For the other versions, see below) then right click the version you want to download:
 https://raw.githubusercontent.com/PPC-scripts/access_cloud/master/access_cloud-antiX-v2.sh , https://raw.githubusercontent.com/PPC-scripts/access_cloud/master/access_cloud-MX-v2.sh
  And save the file. Don't forget to make it executable (select the file in your File Manager and, under it's properties, Choose to make "Executable" or "run as aplication", it dependes on the File Manager you use).
  That's it. The install process is done. Click it and execute it!
 
 ### Notes about the different versions:
   The antiX version is the original, and usually most up to date version of the script and version should also work with any system (that has all the requerired dependencies), but the File Manager does not automaticaly open the cloud drive mount point  (Or try your luck with a untested older "general" version, that you may have to tweak to get working) .
 The Mx Linux version is now virtually identical to the antiX version, using a different icon (that is provided out of the box with MX Linux) and also launching Thunar to automaticaly access the cloud drive's content.
 
 ### Main Dependencies ( that I'm aware of):
- "rclone" (the only dependency you have to install if you run the antiX Linux full version or the MX version), 
- "fusermount" (used to make sure the "remote" cloud drives are really unmounted, already provided out of the box with antiX and MX Linux)
- "yad" and "desktop-defaults-run" (already provided out of the box in antiX full version and Mx Linux)
- "xdg-open" (already included in antiX, MX Linux and most Linux distros)
