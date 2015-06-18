//
//  ADPushTransition.h
//  LastFMTestProject
//
//  Created by Andrew on 6/17/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ADNavigationTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL reverse;

- (instancetype) initWithStartView:(UIView *) view destinationFrame:(CGRect) destinationFrame;

- (void) configureWithStartView:(UIView *) view destinationFrame:(CGRect) destinationFrame;



@end
