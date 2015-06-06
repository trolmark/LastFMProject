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
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *albumLabel;
@property (nonatomic, strong) UILabel *playCountLabel;

@end

@implementation ADAlbumCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    [self setupLayout];
    
    return self;
}

- (void) setupLayout
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.imageView];
    [self.imageView alignTop:@"10" leading:@"10" toView:self.contentView];
    [self.imageView constrainWidth:@"60" height:@"60"];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.layer.borderWidth = 0.5f;
    self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.albumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.albumLabel];
    [self.albumLabel alignTop:@"10" leading:@"70" toView:self.imageView];
    
    self.playCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.playCountLabel];
    [self.playCountLabel alignTopEdgeWithView:self.albumLabel predicate:@"20"];
    [self.playCountLabel alignLeadingEdgeWithView:self.imageView predicate:@"70"];
}


- (void) configureWithData:(ADAlbumViewModel *) data {
    
    self.albumLabel.text = data.name;
    self.playCountLabel.text = data.playCountText;
    
    RACSignal *prepareForReuseSignal = [self rac_signalForSelector:@selector(prepareForReuse)];
    
    RAC(self.imageView, image) = [[[RACObserve(data, thumbnailData) ignore:[NSNull null]] map:^(NSData *data) {
        return [UIImage imageWithData:data];
    }] takeUntil:prepareForReuseSignal];
}

@end
