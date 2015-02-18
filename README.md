# StaticLabelManager

[![CI Status](http://img.shields.io/travis/Julian/StaticLabelManager.svg?style=flat)](https://travis-ci.org/Julian/StaticLabelManager)
[![Version](https://img.shields.io/cocoapods/v/StaticLabelManager.svg?style=flat)](http://cocoadocs.org/docsets/StaticLabelManager)
[![License](https://img.shields.io/cocoapods/l/StaticLabelManager.svg?style=flat)](http://cocoadocs.org/docsets/StaticLabelManager)
[![Platform](https://img.shields.io/cocoapods/p/StaticLabelManager.svg?style=flat)](http://cocoadocs.org/docsets/StaticLabelManager)

StaticLabelManager is a simple library to help you manage the static labels in your application without submitting you app. 

All you need is to create a strings file which will be online. You provide the URL to the library and it will manage all the checks and updates. The labels file is a simple Apple strings file, like the example below: 

	"code" = "label value";
	"cart_title" = "My Cart";

Then, you have to use the library's getter to retrieve the actual label: 

	[[SLManager sharedManager] get:@"cart_title"];

Simple, right? 

Let's go with the configuration. I tried to make it easy! 

## Requirements

1. This library has been build for iOS 7.0 and above, but probably works before 

2. You will need a server to host two text files (version file and the strings file). Dropbox could work as well. 



## Installation

StaticLabelManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "StaticLabelManager"

**documentation in progress... **

## Configuration

**documentation in progress... **

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

The Example project is a simple use of the library. It provides a default label file embedded, and we run 2 consecutive updates with two different file versions. 

During those updates, we run a loop to display a label value every seconds (by the time, the label changes after each update). 

## Author

Julian Le Calvez, www.julianlecalvez.com

## License

StaticLabelManager is available under the MIT license. See the LICENSE file for more info.

Copyright (c) 2015, Julian Le Calvez