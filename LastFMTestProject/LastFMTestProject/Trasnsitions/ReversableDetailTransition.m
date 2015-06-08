//
//  ReversableBlurredTransition.m
//  PhotoTransitionsExample
//
//  Created by Eric Allam on 15/12/2013.
//  Copyright (c) 2013 Code School. All rights reserved.
//

#import "ReversableDetailTransition.h"
#import "ADArtistDetailViewController.h"
#import "ADAlbumViewController.h"
#import "ADAlbumCell.h"

@interface ReversableDetailTransition ()
@property (assign, nonatomic) UIViewAnimationCurve animationCurve;
@end

@implementation ReversableDetailTransition

- (instancetype)initWithStartingFrame:(CGRect)startingFrame;
{
    if (self = [super init]) {
        self.startingFrame = startingFrame;
        self.duration = 0.6f;
        self.animationCurve = UIViewAnimationCurveEaseIn;
        self.reverse = NO;
    }
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)context
{
    self.context = context;
    
    if (self.reverse) {
        [self animateReverseTransition];
    }else{
        [self animateForwardTransition];
    }
}

- (void)animateForwardTransition {
    ADArtistDetailViewController *fromViewController = (ADArtistDetailViewController*)[self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    ADAlbumViewController *toViewController = (ADAlbumViewController*)[self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [self.context containerView];
    NSTimeInterval duration = self.duration;
    
    // Get a snapshot of the thing cell we're transitioning from
    ADAlbumCell *cell = (ADAlbumCell*)[fromViewController.collectionView cellForItemAtIndexPath:[[fromViewController.collectionView indexPathsForSelectedItems] firstObject]];
    UIView *cellImageSnapshot = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    cell.imageView.hidden = YES;
    
    // Setup the initial view states
    toViewController.view.frame = [self.context finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
   // toViewController.imageView.hidden = YES;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:cellImageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        // Fade in the second view controller's view
        toViewController.view.alpha = 1.0;
        
        // Move the cell snapshot so it's over the second view controller's image view
        CGRect frame = [containerView convertRect:[toViewController coverImageRect] fromView:toViewController.view];
        cellImageSnapshot.frame = frame;
    } completion:^(BOOL finished) {
        // Clean up
//        toViewController.imageView.hidden = NO;
        cell.hidden = NO;
        [cellImageSnapshot removeFromSuperview];
        
        // Declare that we've finished
        [self.context completeTransition:!self.context.transitionWasCancelled];
    }];
}

- (void) animateReverseTransition
{
    ADAlbumViewController *fromViewController = (ADAlbumViewController*)[self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    ADArtistDetailViewController *toViewController = (ADArtistDetailViewController*)[self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [self.context containerView];
    NSTimeInterval duration = self.duration;
    
    // Get a snapshot of the image view
    UIView *imageSnapshot = [fromViewController.view resizableSnapshotViewFromRect:[fromViewController coverImageRect] afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];//[fromViewController.imageView snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = [containerView convertRect:[fromViewController coverImageRect] fromView:fromViewController.view];
    //fromViewController.imageView.hidden = YES;
    
    // Get the cell we'll animate to
    ADAlbumCell *cell = (ADAlbumCell *)[toViewController cellForAlbumViewModel:fromViewController.viewModel];
    cell.imageView.hidden = YES;
    
    // Setup the initial view states
    toViewController.view.frame = [self.context finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    [containerView addSubview:imageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        // Fade out the source view controller
        fromViewController.view.alpha = 0.0;
        
        // Move the image view
        imageSnapshot.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    } completion:^(BOOL finished) {
        // Clean up
        [imageSnapshot removeFromSuperview];
        //fromViewController.imageView.hidden = NO;
        cell.imageView.hidden = NO;
        
        // Declare that we've finished
        [self.context completeTransition:!self.context.transitionWasCancelled];
    }];
}


@end
