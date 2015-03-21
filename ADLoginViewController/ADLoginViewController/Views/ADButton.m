//
//  RAButton.m
//  RemoteAlarm
//
//  Created by Andrey Denisov on 3/16/15.
//  Copyright (c) 2015 Sotera Wireless. All rights reserved.
//

#import "ADButton.h"

@interface ADButton()

@property (nonatomic, copy) CompletionBlock pressHandler;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end

@implementation ADButton

- (instancetype) init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
}

- (void) commonInit
{
    [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self setupSpinner];
}

- (void) setupSpinner
{
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.spinner setUserInteractionEnabled:NO];
    [self addSubview:self.spinner];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.spinner.center = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds));
}

- (void) configureWithBlock:(CompletionBlock) handler
{
    if (handler) {
        self.pressHandler = handler;
    }
}

- (void) showLoading:(BOOL) show
{
    self.titleLabel.hidden = show;
    if (show) {
        [self.spinner startAnimating];
    } else {
        [self.spinner stopAnimating];
    }
}

- (void) touchDown
{
    [self animatePressed:YES completion:nil];
}

- (void) touchUpInside
{
    __weak typeof(self) weakSelf = self;
    if (self.pressHandler) {
        [self animatePressed:NO completion:^(BOOL finished) {
            weakSelf.pressHandler(weakSelf);
        }];
    } else {
        [self animatePressed:NO completion:nil];
    }
}

- (void) animatePressed:(BOOL) pressed completion:(CompletionAnimationBlock)completion
{
    CGFloat scale = pressed ? 0.95 : 1.0;
    CGFloat delay = pressed ? 0.0 : 0.2;
    
    [UIView animateWithDuration:0.2
                          delay:delay
         usingSpringWithDamping:0.4
          initialSpringVelocity:1
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(scale,scale);
                     }
                     completion:completion];
}


@end
