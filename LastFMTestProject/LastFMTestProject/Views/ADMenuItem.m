//
//  ADMenuItem.m
//  LastFMTestProject
//
//  Created by Andrew on 6/7/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADMenuItem.h"
#import "Constants.h"

@implementation ADMenuItem

- (instancetype) initWithTitle:(NSString *)title action:(void (^)(REMenuItem *item))action
{
    self = [self initWithTitle:title image:nil highlightedImage:nil action:action];
    [self configureItem];
    return self;
}

- (void) configureItem {
    self.backgroundColor = [UIColor whiteColor];
    self.highlightedBackgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    self.font = [UIFont fontWithName:kBaseFont size:16];
}

@end
