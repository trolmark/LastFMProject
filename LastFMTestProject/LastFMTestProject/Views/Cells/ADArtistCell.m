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
    [self.imageView alignTop:@"10" leading:@"10" toView:self.contentView];
    [self.imageView constrainWidth:@"60" height:@"60"];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.layer.borderWidth = 0.5f;
    self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.artistLabel = [[UILabel alloc] initWithFrame:CGRectZero];
     [self.contentView addSubview:self.artistLabel];
    [self.artistLabel alignTop:@"10" leading:@"70" toView:self.imageView];
    
    self.listenersCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.listenersCountLabel];
    [self.listenersCountLabel alignTopEdgeWithView:self.artistLabel predicate:@"20"];
    [self.listenersCountLabel alignLeadingEdgeWithView:self.imageView predicate:@"70"];
    
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

@end
