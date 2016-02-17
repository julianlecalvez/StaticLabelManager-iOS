# StaticLabelManager

[![CI Status](http://img.shields.io/travis/julianlecalvez/StaticLabelManager-iOS.svg?style=flat)](https://travis-ci.org/julianlecalvez/StaticLabelManager-iOS)
<!--[![Version](https://img.shields.io/cocoapods/v/StaticLabelManager.svg?style=flat)](http://cocoadocs.org/docsets/StaticLabelManager)
[![License](https://img.shields.io/cocoapods/l/StaticLabelManager.svg?style=flat)](http://cocoadocs.org/docsets/StaticLabelManager)
[![Platform](https://img.shields.io/cocoapods/p/StaticLabelManager.svg?style=flat)](http://cocoadocs.org/docsets/StaticLabelManager)-->

StaticLabelManager is a simple library to help you manage the static labels in your application without submitting you app. 

All you need is to create a strings file which will be online. You provide the URL to the library and it will manage all the checks and updates. The labels file is a simple Apple strings file, like the example below: 

	"key" = "label value";
	"cart_title" = "My Cart";

Then, you have to use the library's getter to retrieve the actual label: 

	[[SLManager sharedManager] get:@"cart_title"];

Simple, right? 

Let's go with the configuration. I tried to make it easy! 

## Requirements

1. This library has been build for iOS 7.0 and above, but probably works before 

2. You will need a server to host two text files (version file and the strings file). Dropbox could work as well. 



## Installation with CocoaPods

StaticLabelManager is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

    pod "StaticLabelManager"


## Basic Configuration

Once the pod is included in your project, you have 3 steps of configuration before using StaticLabelManager in your application.

### 1. Prepare your 2 remote files

You need to prepare two remote files to be able to use properly StaticLabelManager. 

**The first file** is the labels file, which is an Apple strings file. This file contains a list of pairs of strings key/value. Here is an example:

	"key" = "label value";
	"cart_title" = "My Cart";
	"main_title" = "My Awesome App !!"
	"FILE_VERSION" = "12"
	
Look at the last entry FILE_VERSION. This is a mandatory entry which will be used to check if the remote file is older than the file locally installed. This value has to be incremented each time you publish a new version of this file. 

**The second file** is called the version file, and will be downloaded each time that the library will run a check for update (usually once per launch). This file only contains the version number (an integer) and **must** match the FILE_VERSION entry in the strings file. Here is an example of version file content: 

	12
	

### 2. Set the URLs to the library and run updates

Once your files are online and reachable through a URL, you will be able to tell the library where to find them. Them , you will have to define the location in your application from where the updates will be done. 

Our recommendation is to run the update at launch, from the *application:didFinishLaunchingWithOptions:* method (update will be done asynchronously), like the following:

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{
	    // ...
	    
		// Setup SLM configuration
    	[SLManager sharedManager].versionFileUrl = 
    		[NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/version.txt"];
    	[SLManager sharedManager].labelsFileUrl = 
    		[NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/labels.strings"];
    	
    	// Run the update 
    	[manager update];
    	
    	// ...
    	
    	return YES;
	}
	
If it makes sense for your application, you can put it in another method of the AppDelegate, or in another part of your application. 

Remember that the updates are done asynchronously, so you may have a delay before getting the labels update, but the previous version of the labels file will be used until the new file is installed. 

### 3. Embbed a default version of your labels  

When you pack and sunmit your application, a strong recommendation is to embbed a version of your label file inside the application bundle. 

You can include it like a normal strings file by adding it from Xcode, but it has to have the following name: *slm.strings*. 

![image](https://raw.githubusercontent.com/julianlecalvez/StaticLabelManager-iOS/master/assets/default-file-screenshot.png)


### 4. Use the labels in your application

Right now, you don't need anything else to do! 

Just use the getter to retrieve the labels. The manager will automatically retrieve the most recent version of the requested label. Here is an example: 

	[[SLManager sharedManager] get:@"main_title"]; 
	// will return: My Awesome App !!


## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

The Example project is a simple use of the library. It provides a default label file embedded, and we run 2 consecutive updates with two different file versions. 

During those updates, we run a loop to display a label value every seconds (by the time, the label changes after each update). 


## Advanced Configuration

StaticLabelManager provides an advanced configuration that can be use for specific needs. You can click on the following links to know more about it:

- [Use the delegate to be notified when updates succeed or fail](https://github.com/julianlecalvez/StaticLabelManager-iOS/blob/master/AdvancedConfiguration.md#manager-delegate)
- [Create a custom Downloader Adapter *(in progress)*](https://github.com/julianlecalvez/StaticLabelManager-iOS/blob/master/AdvancedConfiguration.md#create-custom-adapter)

If you have another need, let me know, I may have am easy solution :) 


## Author

Julian Le Calvez, [www.julianlecalvez.com](http://www.julianlecalvez.com)


## License

StaticLabelManager is available under the MIT license. See the [LICENSE](https://github.com/julianlecalvez/StaticLabelManager-iOS/blob/master/LICENSE) file for more info.

Copyright (c) 2015, Julian Le Calvez