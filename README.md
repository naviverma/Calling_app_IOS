# Calling_app_IOS
# Calling_app_IOS
This is a training project for my IOS summer internship in paytm india.

## Calling app

### Overview

This is Ios application in which we can organize the contact list in a very precise and easy way and can also call them by integrated ios calling feature. In which you can save contacts by filling all the info u need u save and with a image too that you can capture from the camera from inside the app only with integrated ios camera app. App also picks the favourite contacts for you that u called the most so thats its handy to call them again.

### Key Features:

- You can save new contacts, edit them and delete them very easily.
- You can save a contact with image caputured by integrated camera.
- App gives ur favourites in diff section above so that u can call them handily.
- Implemented Calling feature.
- Implemented Camera feature.
- Implemented Firebase analytics in case we add the google ads feature or any other analysis capture we want.
- Sleek and easy to use and appealing UI.

### Technologies & Architecture:

- Coredata is used as a database where all the contacts are saved.
- Adopted the MVC architectural pattern for code reuse and maintainability.
- Analytics powered by Firebase.

### Contribution:

Your contributions are always welcome! Here's how you can contribute:
- Fork the Repository: Head over to the GitHub Viewer repository and click on the 'Fork' button.
- Clone the Project: Use the "Clone from Version Control" feature in Xcode to clone the project.
- Install Dependencies: Ensure you have CocoaPods installed and then run the required pod installation commands.
- Setup the iOS Environment: Use an iOS simulator or connect your physical iOS device to your computer.
- Run the Application: Adjust the configuration settings if using a simulator and launch the app.

### Dependency Setup with CocoaPods


### Install CocoaPods (if not installed)
bash
sudo gem install cocoapods


### Navigate to Project & Initialize CocoaPods
bash
cd path/to/your/project

### Initialise the podfile
bash
pod init


### Add Dependencies to your Podfile
bash
pod 'Firebase/Analytics'


### Install the pod
bash
pod install

### Open the workspace
bash
open YourProjectName.xcworkspace
