//
//  SHButton.h
//  SHButton
//
//  Created by shuu on 7/16/16.
//  Copyright (c) 2016 @harushuu. All rights reserved.
//
// The MIT License (MIT)
//
// Copyright (c) 2016 @harushuu
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import <UIKit/UIKit.h>

@interface SHButton : UIButton

// default is YES; If NO, default shadowColor is lightGrayColor with alpha = 0.6;
@property (nonatomic, assign) BOOL smartColor;

// default scale is YES;
@property (nonatomic, assign) BOOL showShadowAnimation;

// If set YES, minShadowCircleValue = 1.1f && maxShadowCircleValue = 1.1f;
@property (nonatomic, assign, getter=isOriginScale) BOOL originScale;

// If smartColor is NO, default shadowColor is lightGrayColor with alpha = 0.6;
@property (nonatomic, strong) UIColor *shadowColor;

// default scale is 0.6;
@property (nonatomic, assign) CGFloat shadowColorAlpha;

// default scale is 0.9;
@property (nonatomic, assign) CGFloat scaleValue;

// default is 0.25;
@property (nonatomic, assign) CGFloat showAnimationDuration;

// default is 0.4;
@property (nonatomic, assign) CGFloat cancelAnimationDuration;

// default is 1.3;
@property (nonatomic, assign) CGFloat minShadowCircleValue;

// default is 1.5;
@property (nonatomic, assign) CGFloat maxShadowCircleValue;

@end
