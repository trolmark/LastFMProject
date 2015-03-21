//
//  RAButton.h
//  RemoteAlarm
//
//  Created by Andrey Denisov on 3/16/15.
//  Copyright (c) 2015 Sotera Wireless. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  ADButton;
typedef void (^CompletionAnimationBlock) (BOOL finished);
typedef void (^CompletionBlock) (ADButton *sender);

@interface ADButton : UIButton

- (void) configureWithBlock:(CompletionBlock) handler;
- (void) showLoading:(BOOL) show;

@end
