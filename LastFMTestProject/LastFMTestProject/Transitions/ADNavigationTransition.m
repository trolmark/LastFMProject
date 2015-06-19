//
//  ADPushTransition.m
//  LastFMTestProject
//
//  Created by Andrew on 6/17/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADNavigationTransition.h"
#import "ADTransitionProtocol.h"

@interface ADNavigationTransition()

@property (assign, nonatomic) CGFloat zoomScale;
@property (assign, atomic) NSTimeInterval duration;
@property (assign, nonatomic) UIViewAnimationCurve animationCurve;


@end


@implementation ADNavigationTransition


- (instancetype)init
{
    if (self = [super init]) {
        self.duration = 0.3f;
        self.zoomScale = 1.2;
        self.animationCurve = UIViewAnimationCurveEaseIn;
    }
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
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
    
    [toView layoutIfNeeded];
    
    UIView *snapShot = [fromViewController transitionFromViewReverse:self.reverse];
    [containerView addSubview:snapShot];

    if (self.reverse) {
        [UIView animateWithDuration:self.duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             snapShot.frame = [toViewController transitionToViewFrameReverse:self.reverse];
                             alphaView.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:self.duration
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  snapShot.alpha = 0;
                                              }
                                              completion:^(BOOL finished) {
                                                  [snapShot removeFromSuperview];
                                                  [transitionContext completeTransition:!self.canceled];
                                              }];
                         }];
    } else {
        [UIView animateWithDuration:self.duration animations:^{
            snapShot.transform = CGAffineTransformMakeScale(self.zoomScale,
                                                            self.zoomScale);
            snapShot.frame = [toViewController transitionToViewFrameReverse:self.reverse];
            alphaView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:self.duration
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 alphaView.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 snapShot.alpha = 0;
                                [snapShot removeFromSuperview];
                                 toView.hidden = NO;
                                  [transitionContext completeTransition:!self.canceled];
                             }];
        }];
    }
}

@end
