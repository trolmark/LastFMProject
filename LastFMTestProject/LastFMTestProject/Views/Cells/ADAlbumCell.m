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
#import "UIImageView+Snapshot.h"

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
    [self.imageView alignTop:@"5" leading:@"10" bottom:@"-5" trailing:@"-10" toView:self.contentView];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.borderWidth = 0.5f;
    self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:coverView];
    [self.contentView insertSubview:coverView aboveSubview:self.imageView];
    [coverView alignToView:self.imageView];
    coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];

    self.albumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.albumLabel];
    self.albumLabel.textColor = [UIColor whiteColor];
    self.albumLabel.textAlignment = NSTextAlignmentCenter;
    [self.albumLabel alignCenterWithView:self.contentView];
    [self.albumLabel constrainWidthToView:self.contentView predicate:@""];
    self.albumLabel.font = [UIFont fontWithName:kBaseFont size:15];
    
    self.playCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.playCountLabel];
    self.playCountLabel.textAlignment = NSTextAlignmentCenter;
    [self.playCountLabel alignTopEdgeWithView:self.albumLabel predicate:@"20"];
    [self.playCountLabel constrainWidthToView:self.albumLabel predicate:@""];
    self.playCountLabel.font =[UIFont fontWithName:kBaseFont size:11];
    self.playCountLabel.textColor = [UIColor whiteColor];
}


- (void) configureWithData:(ADAlbumViewModel *) data {
    
    self.albumLabel.text = data.name;
    self.playCountLabel.text = data.playCountText;
    
    RACSignal *prepareForReuseSignal = [self rac_signalForSelector:@selector(prepareForReuse)];
    
    RAC(self.imageView, image) = [[[RACObserve(data, thumbnailData) ignore:[NSNull null]] map:^(NSData *data) {
        return [UIImage imageWithData:data];
    }] takeUntil:prepareForReuseSignal];
}

- (UIView *) snapshot
{
    UIImageView *imageView = [self.imageView snapshot];
    imageView.frame = [self.imageView convertRect:self.imageView.bounds toView:self.superview.superview];
    return imageView;
}

@end
