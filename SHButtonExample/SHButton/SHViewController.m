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
@property (nonatomic, strong) SHButton *defaultbutton;

@end

@implementation SHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

- (void)setupViews {
    [self.view addSubview:self.defaultbutton];
}

- (SHButton *)defaultbutton {
    if (!_defaultbutton) {
        _defaultbutton = [[SHButton alloc] init];
        [_defaultbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_defaultbutton setTitle:@"default button" forState:UIControlStateNormal];
        _defaultbutton.bounds = CGRectMake(0, 0, 150, 40);
        _defaultbutton.center = self.view.center;
    }
    return _defaultbutton;
}



@end
