//
//  SHViewController.m
//  SHButton
//
//  Created by @harushuu on 07/16/2016.
//  Copyright (c) 2016 @harushuu. All rights reserved.
//

#import "SHViewController.h"
#import <SHButton/SHButton.h>

@interface SHViewController ()
@property (nonatomic, strong) SHButton *textButton;
@property (nonatomic, strong) SHButton *roundButton;
@property (nonatomic, strong) SHButton *imageButton;


@end

@implementation SHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

- (void)setupViews {
    [self.view addSubview:self.textButton];
    [self.view addSubview:self.roundButton];
    [self.view addSubview:self.imageButton];
}

- (SHButton *)textButton {
    if (!_textButton) {
        _textButton = [[SHButton alloc] init];
        [_textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_textButton setTitle:@"SHButton" forState:UIControlStateNormal];
        _textButton.bounds = CGRectMake(0, 0, 100, 40);
        _textButton.center = CGPointMake(self.view.center.x, self.view.center.y - 120);
        _textButton.minShadowCircleValue = 1.5;
        _textButton.maxShadowCircleValue = 2.f;
    }
    return _textButton;
}

- (SHButton *)roundButton {
    if (!_roundButton) {
        _roundButton = [[SHButton alloc] init];
        _roundButton.backgroundColor = [UIColor orangeColor];
        [_roundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_roundButton setTitle:@"Round" forState:UIControlStateNormal];
        _roundButton.bounds = CGRectMake(0, 0, 60, 60);
        _roundButton.center = CGPointMake(self.view.center.x, self.view.center.y - 40);
        _roundButton.layer.cornerRadius = 30.f;
    }
    return _roundButton;
}

- (SHButton *)imageButton {
    if (!_imageButton) {
        _imageButton = [[SHButton alloc] init];
        [_imageButton setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        _imageButton.bounds = CGRectMake(0, 0, 120, 120);
        _imageButton.layer.cornerRadius = 60.f;
        _imageButton.center = CGPointMake(self.view.center.x, self.view.center.y + 80);
        [_imageButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageButton;
}

- (void)buttonPressed:(SHButton *)button {
    NSLog(@"%s",__func__);
}

@end
