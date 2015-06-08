//
//  ADAlbumCoverHeaderView.m
//  LastFMTestProject
//
//  Created by Andrew on 6/7/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAlbumCoverHeaderView.h"
#import "ADViewModels.h"
#import "ADImageHelper.h"
#import "Support.h"

@interface ADAlbumCoverHeaderView()

@property (nonatomic, strong) UIImageView *coverImageView;

@end

@implementation ADAlbumCoverHeaderView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    [self setupCover];
    
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
}

- (void) setupCover
{
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.coverImageView];
    [self.coverImageView alignToView:self];
    self.coverImageView.contentMode = UIViewContentModeScaleToFill;
}



@end
