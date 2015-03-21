//
//  ViewController.m
//  ADLoginViewController
//
//  Created by Andrew on 3/20/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADLoginViewController.h"
#import "ADLoginView.h"
#import "ADUserLoginModel.h"

@interface ADLoginViewController ()

@property (strong, nonatomic) IBOutlet ADLoginView *contentView;

@end

@implementation ADLoginViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.contentView.loginBlock = ^(ADUserLoginModel *params) {
        [weakSelf loginWithParams:params];
    };
}

- (void) loginWithParams:(ADUserLoginModel *) params
{
    [self.contentView showLoading:YES];
    
    // Call to network client
    double delayInSeconds = 0.7;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self.contentView showLoading:NO];
    });
}

@end
