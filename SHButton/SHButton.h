//
//  SHButton.h
//  Pods
//
//  Created by shuu on 7/16/16.
//
//

#import <UIKit/UIKit.h>

@interface SHButton : UIButton

// default shadowColor is lightGrayColor and alpha = 0.6;
@property (nonatomic, strong) UIColor *shadowColor;

// default scale is 0.9;
@property (nonatomic, assign) CGFloat scaleValue;

// default is 0.25;
@property (nonatomic, assign) CGFloat showAnimationDuration;

// default is 0.4;
@property (nonatomic, assign) CGFloat cancelAnimationDuration;

@end
