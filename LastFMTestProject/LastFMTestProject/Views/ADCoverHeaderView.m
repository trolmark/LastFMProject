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

@end

@implementation ADCoverHeaderView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.coverImageView];
    [self.coverImageView alignToView:self];
    self.coverImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.titleLabel];
    [self.titleLabel alignTop:@"150" bottom:@"100" toView:self.coverImageView];
    [self.titleLabel constrainWidthToView:self predicate:nil];
    self.titleLabel.font = [UIFont fontWithName:kBaseFont size:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self insertSubview:self.titleLabel aboveSubview:self.coverImageView];
    
    return self;
}

- (void) configureWithData:(ADAlbumViewModel *)data
{
    RACSignal *prepareForReuseSignal = [self rac_signalForSelector:@selector(prepareForReuse)];
    
    [[[ADImageHelper imageData:data.largeImageURL]
        takeUntil:prepareForReuseSignal ]
        subscribeNext:^(NSData *x) {
            UIImage *coverImage = [UIImage imageWithData:x];
            self.coverImageView.image = coverImage;
        }];
    
    RAC(self.titleLabel, text) = RACObserve(data, name);
}



@end
