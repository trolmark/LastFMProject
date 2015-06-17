//
//  ADPushTransition.m
//  LastFMTestProject
//
//  Created by Andrew on 6/17/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADPushTransition.h"
#import "ADTransitionProtocol.h"

@implementation ADPushTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController <ADTransitionProtocol> *fromViewController = (UIViewController <ADTransitionProtocol> * )([transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey]);
    
    UIViewController <ADTransitionProtocol> *toViewController = (UIViewController <ADTransitionProtocol> * )([transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]);
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    UIView *alphaView = [[UIView alloc] initWithFrame:[transitionContext finalFrameForViewController:toViewController]];
    alphaView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:alphaView];
    
    UIView *snapShot = [fromViewController snapShotForTransition];
    [containerView addSubview:snapShot];
    
    CGFloat animationScale = 1.2;
    if (!self.reverse) {
        [UIView animateWithDuration:0.3 animations:^{
            
            snapShot.transform = CGAffineTransformMakeScale(animationScale,
                                                            animationScale);
            snapShot.frame = [toViewController transitionDestinationFrame];
            alphaView.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 alphaView.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 snapShot.alpha = 0;
                                [snapShot removeFromSuperview];
                                 toView.hidden = NO;
                                 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             }];
        }];
    } else {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             snapShot.frame = [toViewController transitionDestinationFrame];
                             alphaView.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  snapShot.alpha = 0;
                                              }
                                              completion:^(BOOL finished) {
                                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                              }];
                         }];
    }
}

@end
