//
//  ADNavMenuItem.m
//  LastFMTestProject
//
//  Created by Andrew on 6/7/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADNavMenuItem.h"

@interface ADNavMenuItem()

@property (nonatomic, copy) VoidBlock actionBlock;

@end

@implementation ADNavMenuItem

+ (instancetype) newMenuItem
{
    ADNavMenuItem *item = [self buttonWithType:UIButtonTypeSystem];
    [item addTarget:item action:@selector(invokeAction) forControlEvents:UIControlEventTouchUpInside];
    return item;
}

- (void) setTitle:(NSString *) title
{
    [self setTitle:title forState:UIControlStateNormal];
}


- (void) addAction:(VoidBlock)action
{
    self.actionBlock = action;
}

- (void) invokeAction
{
    if (self.actionBlock) self.actionBlock();
}

@end
