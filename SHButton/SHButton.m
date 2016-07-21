//
//  SHButton.m
//  Pods
//
//  Created by shuu on 7/16/16.
//
//

#import "SHButton.h"

@interface SHButton () <UIGestureRecognizerDelegate>
@property (nonatomic, assign) CGRect bigShadowRect;
@property (nonatomic, assign) CGRect smallShadowRect;
@property (nonatomic, assign) BOOL showAnimation;
@property (nonatomic, strong) CAShapeLayer *shadowCircel;

@end

@implementation SHButton

#pragma mark - Initializers

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
    self.shadowColor = [UIColor colorWithRed:0.667 green:0.667 blue:0.667 alpha:0.6];
    self.scaleValue = 0.9;
    self.showAnimationDuration = 0.25;
    self.cancelAnimationDuration = 0.4;
    self.minShadowCircleValue = 1.3;
    self.maxShadowCircleValue = 1.5;
    self.adjustsImageWhenHighlighted = NO;
    self.layer.masksToBounds = NO;
    self.clipsToBounds = NO;
    [self.layer setNeedsDisplayOnBoundsChange:YES];
    [self setContentMode:UIViewContentModeRedraw];
    [self addTarget:self action:@selector(shouldTouch:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(didTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(didTouch:) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(cancelTouch:) forControlEvents:UIControlEventTouchCancel];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:tapGestureRecognizer];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
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

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return NO;
}

#pragma mark - IBAction

- (void)shouldTouch:(UITapGestureRecognizer *)tap {
    self.showAnimation = YES;
    [self showScaleAnimations];
    [self showShadowAnimations];
}

- (void)didTouch:(UITapGestureRecognizer *)tap {
    self.showAnimation = NO;
    [self cancelScaleAnimations];
    [self cancelShadowAnimations];
}

- (void)cancelTouch:(UITapGestureRecognizer *)tap {
    if (!self.showAnimation) {
        return;
    } else {
        self.showAnimation = NO;
    }
    [self cancelScaleAnimations];
    [self cancelShadowAnimations];
}

#pragma mark - Animation

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:@"id"] isEqualToString:@"shadowOpacityAnimation"]) {
        [self.layer removeAllAnimations];
    }
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
        shadowCircel.fillColor = self.shadowColor.CGColor;
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
