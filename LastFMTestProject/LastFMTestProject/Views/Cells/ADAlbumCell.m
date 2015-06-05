//
//  ADAlbumCell.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/4/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAlbumCell.h"
#import "ADAlbumViewModel.h"
#import "Support.h"

@interface ADAlbumCell()
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation ADAlbumCell

- (void) configureWithData:(ADAlbumViewModel *) data {
    RACSignal *prepareForReuseSignal = [self rac_signalForSelector:@selector(prepareForReuse)];
    
    RAC(self.imageView, image) = [[[RACObserve(data, thumbnailData) ignore:[NSNull null]] map:^(NSData *data) {
        return [UIImage imageWithData:data];
    }] takeUntil:prepareForReuseSignal];
}

@end
