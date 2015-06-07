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

@end

@implementation ADTrackCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    [self setupLayout];
    
    return self;
}

- (void) setupLayout {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel alignToView:self.contentView];
    self.titleLabel.font = [UIFont fontWithName:kBaseFont size:14];
}

- (void) configureWithData:(ADTrackViewModel *) data
{
    self.titleLabel.text = data.title;
}

@end
