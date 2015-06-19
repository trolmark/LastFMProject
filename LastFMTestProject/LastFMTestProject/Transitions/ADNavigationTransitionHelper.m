//
//  ADNavigationTransitionHelper.m
//  LastFMTestProject
//
//  Created by Andrew on 6/17/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADNavigationTransitionHelper.h"
#import "ADNavigationTransition.h"

@interface ADNavigationTransitionHelper()

@property (nonatomic, strong) ADNavigationTransition *pushTransition;
@property (nonatomic, strong) ADNavigationTransition *popTransition;
@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@property (nonatomic, assign) BOOL panGestureRecognizerEnable;

@end

@implementation ADNavigationTransitionHelper

#pragma mark - Propertys

- (ADNavigationTransition *)pushTransition {
    if (!_pushTransition) {
        _pushTransition = [[ADNavigationTransition alloc] init];
    }
    return _pushTransition;
}

- (ADNavigationTransition *)popTransition {
    if (!_popTransition) {
        _popTransition = [[ADNavigationTransition alloc] init];
        _popTransition.reverse = YES;
    }
    return _popTransition;
}

#pragma mark - Life Cycle

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
                  panGestureRecognizerEnable:(BOOL)panGestureRecognizerEnable {
    self = [super init];
    if (self) {
        self.navigationController = navigationController;
        
        self.navigationController.delegate = self;
        
        self.panGestureRecognizerEnable = panGestureRecognizerEnable;
        if (self.panGestureRecognizerEnable) {
            UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
            
            [self.navigationController.view addGestureRecognizer:panGestureRecognizer];
        }
    }
    return self;
}

#pragma mark - UIPanGestureRecognizer Helper Method

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint location = [panGestureRecognizer locationInView:panGestureRecognizer.view];
            if (location.y > 0 && self.navigationController.viewControllers.count > 1) {
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [panGestureRecognizer translationInView:panGestureRecognizer.view];
            CGFloat d = fabs(translation.y / CGRectGetHeight(panGestureRecognizer.view.bounds));
            [self.interactionController updateInteractiveTransition:d];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded: {
            CGPoint velocity = [panGestureRecognizer velocityInView:panGestureRecognizer.view];
            if (velocity.y > 80) {
                self.popTransition.canceled = NO;
                [self.interactionController finishInteractiveTransition];
            } else {
                self.popTransition.canceled = YES;
                [self.interactionController cancelInteractiveTransition];
            }
            self.interactionController = nil;
            break;
        }
        default:
            break;
    }
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return self.pushTransition;
    } else if (operation == UINavigationControllerOperationPop) {
        return self.popTransition;
    }
    
    return nil;
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if (self.panGestureRecognizerEnable) {
        return self.interactionController;
    } else {
        return nil;
    }
}


@end
