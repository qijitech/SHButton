//
//  SHButton.m
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


#import "SHButton.h"

static UIColor *kDefaultShadowColor;

@interface SHButton () <UIGestureRecognizerDelegate>
@property (nonatomic, assign) CGRect bigShadowRect;
@property (nonatomic, assign) CGRect smallShadowRect;
@property (nonatomic, assign) BOOL showAnimation;
@property (nonatomic, strong) CAShapeLayer *shadowCircel;

@end

@implementation SHButton

#pragma mark - Initializers

+ (void)initialize {
    kDefaultShadowColor = [UIColor colorWithRed:0.667 green:0.667 blue:0.667 alpha:0.6];
}

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

#pragma mark - Setup

- (void)setup {
    self.smartColor = YES;
    self.showShadowAnimation = YES;
    self.scaleValue = 0.9;
    self.showAnimationDuration = 0.25;
    self.cancelAnimationDuration = 0.4;
    self.minShadowCircleValue = 1.3;
    self.maxShadowCircleValue = 1.5;
    self.shadowColorAlpha = 0.6;
    self.adjustsImageWhenHighlighted = NO;
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
    [self.layer setNeedsDisplayOnBoundsChange:YES];
    [self setContentMode:UIViewContentModeRedraw];
    [self addTarget:self action:@selector(shouldTouch:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(didTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(didTouch:) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(cancelTouch:) forControlEvents:UIControlEventTouchCancel];
}

#pragma mark - Super Overrides

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bigShadowRect = CGRectMake(self.bounds.origin.x - self.bounds.size.width * (self.maxShadowCircleValue - 1) * 0.5,
                                    self.bounds.origin.y - self.bounds.size.height * (self.maxShadowCircleValue - 1) * 0.5,
                                    self.bounds.size.width * self.maxShadowCircleValue,
                                    self.bounds.size.height * self.maxShadowCircleValue);
    self.smallShadowRect = CGRectMake(self.bounds.origin.x - self.bounds.size.width * (self.minShadowCircleValue - 1) * 0.5,
                                      self.bounds.origin.y - self.bounds.size.height * (self.minShadowCircleValue - 1) * 0.5,
                                      self.bounds.size.width * self.minShadowCircleValue,
                                      self.bounds.size.height * self.minShadowCircleValue);
    [self setNeedsDisplay];
    [self.layer setNeedsDisplay];
}

#pragma mark - Setup Custom Property

- (void)setMinShadowCircleValue:(CGFloat)minShadowCircleValue {
    _minShadowCircleValue = minShadowCircleValue;
    self.smallShadowRect = CGRectMake(self.bounds.origin.x - self.bounds.size.width * (self.minShadowCircleValue - 1) * 0.5,
                                      self.bounds.origin.y - self.bounds.size.height * (self.minShadowCircleValue - 1) * 0.5,
                                      self.bounds.size.width * self.minShadowCircleValue,
                                      self.bounds.size.height * self.minShadowCircleValue);
}

- (void)setMaxShadowCircleValue:(CGFloat)maxShadowCircleValue {
    _maxShadowCircleValue = maxShadowCircleValue;
    self.bigShadowRect = CGRectMake(self.bounds.origin.x - self.bounds.size.width * (self.maxShadowCircleValue - 1) * 0.5,
                                    self.bounds.origin.y - self.bounds.size.height * (self.maxShadowCircleValue - 1) * 0.5,
                                    self.bounds.size.width * self.maxShadowCircleValue,
                                    self.bounds.size.height * self.maxShadowCircleValue);
}

- (void)setOriginScale:(BOOL)originScale {
    _originScale = originScale;
    self.minShadowCircleValue = 1.1f;
    self.maxShadowCircleValue = 1.1f;
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return NO;
}

#pragma mark - IBAction

- (void)shouldTouch:(UITapGestureRecognizer *)tap {
    self.showAnimation = YES;
    [self showScaleAnimations];
    if (self.showShadowAnimation) {
        [self showShadowAnimations];
    }
}

- (void)didTouch:(UITapGestureRecognizer *)tap {
    self.showAnimation = NO;
    [self cancelScaleAnimations];
    if (self.showShadowAnimation) {
        [self cancelShadowAnimations];
    }
}

- (void)cancelTouch:(UITapGestureRecognizer *)tap {
    if (!self.showAnimation) {
        return;
    }
    self.showAnimation = NO;
    [self cancelScaleAnimations];
    if (self.showShadowAnimation) {
        [self cancelShadowAnimations];
    }
}

#pragma mark - Animation

- (UIColor *)calculateCurrentShadowColor {
    if (self.shadowColor == [UIColor clearColor]) {
        return [UIColor clearColor];
    }
    if (self.shadowColor) {
        return [self.shadowColor colorWithAlphaComponent:self.shadowColorAlpha];
    }
    if (!self.smartColor) {
        return kDefaultShadowColor;
    }
    if (self.backgroundColor) {
        return [self.backgroundColor colorWithAlphaComponent:self.shadowColorAlpha];
    }
    if (self.currentTitleColor && self.currentTitleColor != [UIColor clearColor] && self.currentTitleColor != [UIColor whiteColor] && self.currentTitle.length) {
        return [self.currentTitleColor colorWithAlphaComponent:self.shadowColorAlpha * 0.5];
    }
    return kDefaultShadowColor;
}

- (void)showShadowAnimations {
    CGFloat startingCornerRadius = self.bigShadowRect.size.width > self.bigShadowRect.size.height ? : self.bigShadowRect.size.height;
    UIView *startingRectSizerView = [[UIView alloc] initWithFrame:self.bigShadowRect];
    UIBezierPath *startingCirclePath = [UIBezierPath bezierPathWithRoundedRect:startingRectSizerView.frame cornerRadius:startingCornerRadius];
    CGFloat endingCornerRadius = self.smallShadowRect.size.width > self.smallShadowRect.size.height ? : self.smallShadowRect.size.height;
    UIView *endingRectSizerView = [[UIView alloc] initWithFrame:self.smallShadowRect];
    UIBezierPath *endingCirclePath = [UIBezierPath bezierPathWithRoundedRect:endingRectSizerView.frame cornerRadius:endingCornerRadius];
    
    CAShapeLayer *shadowCircel;
    if (!self.shadowCircel) {
        shadowCircel = [CAShapeLayer layer];
        shadowCircel.fillColor = [self calculateCurrentShadowColor].CGColor;
        shadowCircel.strokeColor = [UIColor clearColor].CGColor;
        shadowCircel.borderColor = [UIColor clearColor].CGColor;
        shadowCircel.borderWidth = 0;
        shadowCircel.path = startingCirclePath.CGPath;
        [self.layer insertSublayer:shadowCircel atIndex:0];
        self.shadowCircel = shadowCircel;
    } else {
        shadowCircel = self.shadowCircel;
    }
    
    CABasicAnimation *shadowCircleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    shadowCircleAnimation.duration = self.showAnimationDuration;
    shadowCircleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    shadowCircleAnimation.fromValue = (__bridge id)startingCirclePath.CGPath;
    shadowCircleAnimation.toValue = (__bridge id)endingCirclePath.CGPath;
    shadowCircleAnimation.fillMode = kCAFillModeForwards;
    shadowCircleAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *shadowOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    shadowOpacityAnimation.duration = self.showAnimationDuration;
    shadowOpacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    shadowOpacityAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    shadowOpacityAnimation.toValue = [NSNumber numberWithFloat:1.f];
    shadowOpacityAnimation.fillMode = kCAFillModeForwards;
    shadowOpacityAnimation.removedOnCompletion = NO;
    
    [shadowCircel addAnimation:shadowCircleAnimation forKey:@"animatePath"];
    [shadowCircel addAnimation:shadowOpacityAnimation forKey:@"opacityAnimation"];
}

- (void)cancelShadowAnimations {
    CGFloat startingCornerRadius = self.smallShadowRect.size.width > self.smallShadowRect.size.height ? : self.smallShadowRect.size.height;
    UIView *startingRectSizerView = [[UIView alloc] initWithFrame:self.smallShadowRect];
    UIBezierPath *startingCirclePath = [UIBezierPath bezierPathWithRoundedRect:startingRectSizerView.frame cornerRadius:startingCornerRadius];
    
    CGFloat endingCornerRadius = self.bigShadowRect.size.width > self.bigShadowRect.size.height ? : self.bigShadowRect.size.height;
    UIView *endingRectSizerView = [[UIView alloc] initWithFrame:self.bigShadowRect];
    UIBezierPath *endingCirclePath = [UIBezierPath bezierPathWithRoundedRect:endingRectSizerView.frame cornerRadius:endingCornerRadius];
    
    CAShapeLayer *shadowCircel = self.shadowCircel;
    CABasicAnimation *shadowCircleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    shadowCircleAnimation.duration = self.cancelAnimationDuration;
    shadowCircleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    shadowCircleAnimation.fromValue = (__bridge id)startingCirclePath.CGPath;
    shadowCircleAnimation.toValue = (__bridge id)endingCirclePath.CGPath;
    shadowCircleAnimation.fillMode = kCAFillModeForwards;
    shadowCircleAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *shadowOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [shadowOpacityAnimation setValue:@"shadowOpacityAnimation" forKey:@"id"];
    shadowOpacityAnimation.delegate = self;
    shadowOpacityAnimation.duration = self.cancelAnimationDuration;
    shadowOpacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    shadowOpacityAnimation.fromValue = [NSNumber numberWithFloat:1.f];
    shadowOpacityAnimation.toValue = [NSNumber numberWithFloat:0.f];
    shadowOpacityAnimation.fillMode = kCAFillModeForwards;
    shadowOpacityAnimation.removedOnCompletion = NO;
    
    [shadowCircel addAnimation:shadowCircleAnimation forKey:@"animatePath"];
    [shadowCircel addAnimation:shadowOpacityAnimation forKey:@"opacityAnimation"];
}

- (void)showScaleAnimations {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 0.08;
    scaleAnimation.toValue = @(self.scaleValue);
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:scaleAnimation forKey:nil];
}

- (void)cancelScaleAnimations {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 0.08;
    scaleAnimation.toValue = @1;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:scaleAnimation forKey:nil];
}

@end
