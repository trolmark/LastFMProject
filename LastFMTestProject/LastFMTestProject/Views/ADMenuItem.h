//
//  ADMenuItem.h
//  LastFMTestProject
//
//  Created by Andrew on 6/7/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "REMenu.h"

@interface ADMenuItem : REMenuItem

- (instancetype) initWithTitle:(NSString *) title action:(void (^)(REMenuItem *item))action;

@end
