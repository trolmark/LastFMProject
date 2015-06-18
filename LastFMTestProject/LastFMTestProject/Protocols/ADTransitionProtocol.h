//
//  ADTransitionProtocol.h
//  LastFMTestProject
//
//  Created by Andrew on 6/17/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIView;
@protocol ADTransitionProtocol <NSObject>

- (UIView *) transitionFromViewReverse:(BOOL) reverse;
- (CGRect) transitionToViewFrameReverse:(BOOL) reverse;

@end
