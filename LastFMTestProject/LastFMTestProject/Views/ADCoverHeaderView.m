//
//  ADAlbumCoverHeaderView.m
//  LastFMTestProject
//
//  Created by Andrew on 6/7/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADCoverHeaderView.h"
#import "ADViewModels.h"
#import "ADImageHelper.h"
#import "Support.h"
#import "UIImageView+Snapshot.h"
#import "UIColor+Random.h"

@interface ADCoverHeaderView()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIVisualEffectView *blurredTitleBack;

@end

@implementation ADCoverHeaderView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.coverImageView];
    [self.coverImageView alignToView:self];
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageView.clipsToBounds = YES;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.titleLabel];
    [self.titleLabel alignBottomEdgeWithView:self predicate:nil];
    [self.titleLabel constrainHeight:@"50"];
    [self.titleLabel alignLeading:@"10" trailing:@"-10" toView:self];
    self.titleLabel.font = [UIFont fontWithName:kBaseFont size:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.minimumScaleFactor = 0.7;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self insertSubview:self.titleLabel aboveSubview:self.coverImageView];
    
    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurredTitleBack =
    [[UIVisualEffectView alloc] initWithEffect:effect];
    [self addSubview:self.blurredTitleBack];
    [self.blurredTitleBack alignBottomEdgeWithView:self predicate:nil];
    [self.blurredTitleBack alignTopEdgeWithView:self.titleLabel predicate:nil];
    [self.blurredTitleBack constrainWidthToView:self predicate:nil];
    [self insertSubview:self.blurredTitleBack belowSubview:self.titleLabel];
    
    self.backgroundColor = [UIColor randomColor];
    
    return self;
}

- (void) configureWithData:(ADAlbumViewModel *)data
{
    [[ADImageHelper imageData:data.largeImageURL]
        subscribeNext:^(NSData *x) {
            UIImage *coverImage = [UIImage imageWithData:x];
            self.coverImageView.image = coverImage;
        }];
    
    RAC(self.titleLabel, text) = RACObserve(data, name);
}

- (UIView *) snapshot
{
    UIImageView *imageView = [self.coverImageView snapshot];
    // FIXTO: hack
    imageView.frame = [self.coverImageView convertRect:self.coverImageView.frame toView:self.superview.superview];
    return imageView;
}



@end
