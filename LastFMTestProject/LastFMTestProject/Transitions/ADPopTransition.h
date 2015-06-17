//
//  ADPopTransition.h
//  LastFMTestProject
//
//  Created by Andrew on 6/17/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ADPopTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL canceled;

@end
