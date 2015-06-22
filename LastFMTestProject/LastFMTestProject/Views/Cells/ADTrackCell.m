//
//  ADTrackCell.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/4/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADTrackCell.h"
#import "ADTrackViewModel.h"
#import "Support.h"

@interface ADTrackCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *durationLabel;

@end

@implementation ADTrackCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    [self setupLayout];
    
    return self;
}

- (void) setupLayout
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel constrainHeightToView:self.contentView predicate:nil];
     [self.titleLabel constrainWidthToView:self.contentView predicate:@"*.6"];
    [self.titleLabel alignTop:@"" leading:@"10" toView:self.contentView];
    self.titleLabel.font = [UIFont fontWithName:kBaseFont size:13];
    self.titleLabel.textColor = [UIColor darkGrayColor];
    
    self.durationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.durationLabel];
    [self.durationLabel alignTrailingEdgeWithView:self.contentView predicate:nil];
    [self.durationLabel alignCenterYWithView:self.contentView predicate:@""];
    [self.durationLabel constrainWidth:@"50"];
    self.durationLabel.font = [UIFont fontWithName:kBaseFont size:14];
}

- (void) configureWithData:(ADTrackViewModel *) data
{
    self.titleLabel.attributedText = data.attributedTitle;
    self.durationLabel.text = data.durationText;
}

@end
