# tvSchedules

XCode v8.3.3
Input URL is located under config.plist. It is given without the parameter passed in.  eg. https://www.whatsbeef.net/wabz/guide.php?start=

The app will request AppSettings.showURL every time the table is scrolled to the bottom of the list. The URL is automatically roster from start id 1 to 10(eg. https://www.whatsbeef.net/wabz/guide.php?start=10) .  The table is allowed 50 rows of TV programs before it is cleared and re-populated with the latest information.

To run in the iphone simulator (iOS 8+):
 > Run 'pod install' from the Terminal command-prompt.  This will install cocoalumberjack and restkit pods.
 > Open tvSchedules.xcworkspace with XCode.

The app will report 503 error code when service is unavailable. The app will re-fetch the TV programs from the server after the user taps OK on the error dialog box.
