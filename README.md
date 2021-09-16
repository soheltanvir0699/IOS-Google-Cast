# IOS-Google-Cast
This Google Cast demo app shows how an iOS sender app can cast a Video. For simplicity this app is not fully compliant with the UX Checklist.



#Google Cast module for Connect SDK (iOS) The Google Cast module extends Connect SDK to add Google Cast SDK support. This repository is included as a submodule in the main project, and has some manual setup before the main project will compile.

##General Information For more information about Connect SDK, visit the main repository.

##Setup ###Connect SDK Integration

Go to the Google Cast Developer site and download the iOS sender library
Extract the GoogleCast.framework bundle from the downloaded zip file
Move the framework bundle into your modules/google-cast/ directory
In your project: link GoogleCast.framework with your application target:
either drag it from the ConnectSDK project into your project's Frameworks group and then add it to your target
or go to your project settings, select the application target, "Build Phases" tab, in "Link Binary With Libraries" section click "+", then "Add Other…", and select the framework file
###Connect SDK Lite Integration

Clone this repository into a subfolder of the Connect SDK Lite project
Import the source files into the Connect SDK Lite Xcode project
In build phases, move the Google Cast module header files to the public section of "Copy header files"
Follow the steps above for Connect SDK integration
