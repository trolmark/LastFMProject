//
//  LoginView.h
//  ADLoginViewController
//
//  Created by Andrew on 3/20/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADUserLoginModel, ADLoginView;
typedef void (^LoginBlock) (ADUserLoginModel *params);

@interface ADLoginView : UIView

@property (nonatomic, copy) LoginBlock loginBlock;

- (void) showError:(BOOL) show;
- (void) showLoading:(BOOL) show;


@end
