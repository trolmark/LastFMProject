//
//  ADArtistCell.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/4/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtistCell.h"
#import "ADArtistViewModel.h"
#import "Support.h"

@interface ADArtistCell()
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation ADArtistCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor darkGrayColor];
    [self setupLayout];
    
    return self;
}

- (void) setupLayout {
    
}

- (void) configureWithData:(ADArtistViewModel *) data
{
    RACSignal *prepareForReuseSignal = [self rac_signalForSelector:@selector(prepareForReuse)];
    
    RAC(self.imageView, image) = [[[RACObserve(data, thumbnailData) ignore:[NSNull null]] map:^(NSData *data) {
        return [UIImage imageWithData:data];
    }] takeUntil:prepareForReuseSignal];
}

@end
