# SHButton

[![CI Status](http://img.shields.io/travis/@harushuu/SHButton.svg?style=flat)](https://travis-ci.org/@harushuu/SHButton)
[![Version](https://img.shields.io/cocoapods/v/SHButton.svg?style=flat)](http://cocoapods.org/pods/SHButton)
[![License](https://img.shields.io/cocoapods/l/SHButton.svg?style=flat)](http://cocoapods.org/pods/SHButton)
[![Platform](https://img.shields.io/cocoapods/p/SHButton.svg?style=flat)](http://cocoapods.org/pods/SHButton)

## Screenshots
![image](https://github.com/harushuu/SHButton/raw/master/Screenshots.gif)

## Installation
 
With [CocoaPods](http://cocoapods.org/), add this line to your `Podfile`.

```
pod 'SHButton'
```

and run `pod install`, then you're all done!

## How to use

```objc
SHButton *button = [[SHButton alloc] init];
```

## Summary

A simple custom button inspired by iTunes for iOS 10.
 
Will add more custom option in next version.

custom

```objc
// default shadowColor is lightGrayColor and alpha = 0.6;
@property (nonatomic, strong) UIColor *shadowColor;

// default scale is 0.9;
@property (nonatomic, assign) CGFloat scaleValue;

// default is 0.25;
@property (nonatomic, assign) CGFloat showAnimationDuration;

// default is 0.4;
@property (nonatomic, assign) CGFloat cancelAnimationDuration;
```

 
## Requirements

* iOS 8.0+ 
* ARC

## Author

@harushuu, hunter4n@gmail.com

## License

English: SHButton is available under the MIT license, see the LICENSE file for more information.     

