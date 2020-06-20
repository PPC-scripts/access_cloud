# access_cloud
 This is a script that serves as GUI for rclone.
It can be configured with many existing cloud storage services (like Google Drive and Ms OneDrive, etc), mouting those "remote" drives so they can be used just like they were regular network drives, on Linux

 The script was made using antiX Linux, and is originaly meant to be used on that OS (tested in antiX 19.x 64 bits).

 Main Dependencies ( please install it using your package manager):
- "rclone", 
- "yad" and "desktop-defaults-run" (already provided out of the box in antiX full version)
- "xdg-open" (if you are not running antiX and you want the cloud storage drive to automatically pop up in your default file manager - for this to happen uncomment line 102 and comment line 103)
