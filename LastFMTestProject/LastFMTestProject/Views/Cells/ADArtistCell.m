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
#import "UIImageView+Snapshot.h"
#import "UIColor+Random.h"

@interface ADArtistCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *artistLabel;
@property (nonatomic, strong) UILabel *listenersCountLabel;

@end

@implementation ADArtistCell

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
    [self.imageView alignToView:self.contentView];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.layer.borderWidth = 0.5f;
    self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.imageView.clipsToBounds = YES;

    
    self.artistLabel = [[UILabel alloc] initWithFrame:CGRectZero];
     [self.contentView addSubview:self.artistLabel];
    [self.artistLabel alignBottomEdgeWithView:self.contentView predicate:@"-25"];
    [self.artistLabel constrainWidthToView:self.contentView predicate:@""];
    self.artistLabel.font = [UIFont fontWithName:kBaseFont size:20];
    self.artistLabel.textAlignment = NSTextAlignmentCenter;
    self.artistLabel.textColor = [UIColor whiteColor];
    
    self.listenersCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.listenersCountLabel];
    self.listenersCountLabel.textAlignment = NSTextAlignmentCenter;
    [self.listenersCountLabel alignTopEdgeWithView:self.artistLabel predicate:@"30"];
    [self.listenersCountLabel constrainWidthToView:self.contentView predicate:@""];
    self.listenersCountLabel.font = [UIFont fontWithName:kBaseFont size:13];
    self.listenersCountLabel.textColor = [UIColor whiteColor];
    
    UIView *titleBackground = [[UIView alloc] initWithFrame:CGRectZero];
    titleBackground.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
    [self.contentView addSubview:titleBackground];
    [titleBackground alignBottomEdgeWithView:self.contentView predicate:nil];
    [titleBackground alignTopEdgeWithView:self.artistLabel predicate:nil];
    [titleBackground constrainWidthToView:self.contentView predicate:nil];
    [self.contentView insertSubview:titleBackground aboveSubview:self.imageView];
    
    self.backgroundColor = [UIColor randomColor];
}

- (void) configureWithData:(ADArtistViewModel *) data
{
    RACSignal *prepareForReuseSignal = [self rac_signalForSelector:@selector(prepareForReuse)];
    
    RAC(self.imageView, image) = [[[RACObserve(data, thumbnailData) ignore:[NSNull null]] map:^(NSData *data) {
        return [UIImage imageWithData:data];
    }] takeUntil:prepareForReuseSignal];
    
    self.artistLabel.text = data.name;
    self.listenersCountLabel.text = data.listenersCountText;
   
}

- (UIView *) snapshot
{
    UIImageView *imageView = [self.imageView snapshot];
    imageView.frame = [self.imageView convertRect:self.imageView.frame toView:self.superview.superview];
    return imageView;
}

@end
