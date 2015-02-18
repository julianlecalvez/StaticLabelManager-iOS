# Advanced Configuration


<a name="manager-delegate"></a>
## Being notified when updates succeed or fail

A delegate can be set to be notified when the library fails or finishes an update. 

You need to set the delegate property of the SLManager class **BEFORE** running the update method: 

	// ...
	[SLManager sharedManager].delegate = self;
	[[SLManager sharedManager] update];
	// ...

If you choose to define the current class to be the StaticLabelManager delegate, you will have to implement the 2 methods prototyped in the *SLManagerDelegate* protocol. 

The following example assumes that the delegate class is the ApplicationDelegate of your application. 

First, you need to set the delegate protocol in your class' .h file. 
	
	// MyAppDelegate.h
	#import <UIKit/UIKit.h>
	#import <StaticLabelManager/SLManagerDelegate.h>

	@interface MyAppDelegate : UIResponder <UIApplicationDelegate, SLManagerDelegate>
	
	@property (strong, nonatomic) UIWindow *window;
	
	@end


Then, you need to implement the two following methods: 

	// MyAppDelegate.m
	
	@implementation MyAppDelegate
	
	// ...
	
	-(void)managerDidFinishUpdate {
		// will be called when the new version of labels had been loaded
		// not called if there is no new version 
	}
	
	-(void)managerDidFailWithError:(NSError *)error {
    	// will be called when an error did occur during the download/update 
	}
	
	// ...
	
	@end



<a name="create-custom-adapter"></a>
## Create a custom Downloader Adapter

**in progress**


## Author

Julian Le Calvez, [www.julianlecalvez.com](http://www.julianlecalvez.com)


## License

StaticLabelManager is available under the MIT license. See the [LICENSE](https://github.com/julianlecalvez/StaticLabelManager-iOS/blob/master/LICENSE) file for more info.

Copyright (c) 2015, Julian Le Calvez