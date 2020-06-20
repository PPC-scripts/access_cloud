# access_cloud
 * This is a script is a simple GUI for rclone.
It can be configured with many existing cloud storage services (like Google Drive and Ms OneDrive, etc), mouting (and unmounting) those "remote" drives so they can be used just like they were regular network drives, on Linux

 The script was made using antiX Linux, and is originaly meant to be used on that OS (tested in antiX 19.x 64 bits).
 
 *How to use this script:
  At first launch, the script checks if rclone has any configured "remote" cloud storage services. If none is found, a configuration window pops up.
  - Configuration Window:
  Configuring Google Drive can be done automaticaly, by pressing a button. All other cloud storage services have to be configured using the keyboard, via a terminal interface, by pressing the "Manage Cloud Drives" button.
  At the configuration window you can also select if you want to use a tray icon (that is launched only after you use the script to access a "remote" drive). Note: if you are not running antiX and you want the cloud storage drive to automatically pop up in your default file manager - for this to happen uncomment line 102 and comment line 103 of the script
 - Main Window:
  All configured "remote" drive names are listed. Double click one from the list and it's mounted and it's contents shown in the default file browser (see below how to set that up if you are not using antiX Linux).
  The "Unmount all..." button does what it says- the closes the connection with any rclone mounted "remote" cloud service.
  The "Config" and "help" button are self exaplanatory.
  The "Quit" button does not only close the application but also closes the application's tray, if it's running.

 Main Dependencies ( that I'm aware of):
- "rclone", 
- "yad" and "desktop-defaults-run" (already provided out of the box in antiX full version)
- "xdg-open" (if you are not running antiX and you want the cloud storage drive to automatically pop up in your default file manager, it's not an essencial dependency)
