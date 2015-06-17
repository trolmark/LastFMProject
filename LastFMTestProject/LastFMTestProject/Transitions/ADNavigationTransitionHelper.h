//
//  ADNavigationTransitionHelper.h
//  LastFMTestProject
//
//  Created by Andrew on 6/17/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ADNavigationTransitionHelper : NSObject <UINavigationControllerDelegate>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
                  panGestureRecognizerEnable:(BOOL)panGestureRecognizerEnable;

@end
