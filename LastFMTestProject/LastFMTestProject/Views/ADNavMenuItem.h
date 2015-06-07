//
//  ADNavMenuItem.h
//  LastFMTestProject
//
//  Created by Andrew on 6/7/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Types.h"

@interface ADNavMenuItem : UIButton

+ (instancetype) newMenuItem;
- (void) setTitle:(NSString *) title;
- (void) addAction:(VoidBlock) action;

@end
