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
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.coverImageView];
    [self.coverImageView alignToView:self];
    self.coverImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.titleLabel];
    [self.titleLabel alignBottomEdgeWithView:self predicate:nil];
    [self.titleLabel constrainHeight:@"50"];
    [self.titleLabel constrainWidthToView:self predicate:@""];
    self.titleLabel.font = [UIFont fontWithName:kBaseFont size:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self insertSubview:self.titleLabel aboveSubview:self.coverImageView];
    
    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurredTitleBack =
    [[UIVisualEffectView alloc] initWithEffect:effect];
    [self addSubview:self.blurredTitleBack];
    [self.blurredTitleBack alignToView:self.titleLabel];
    [self insertSubview:self.blurredTitleBack belowSubview:self.titleLabel];
    
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



@end
