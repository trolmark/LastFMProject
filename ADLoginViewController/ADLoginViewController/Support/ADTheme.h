//
//  ADTheme.h
//  ADLoginViewController
//
//  Created by Andrew on 3/20/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ADThemeProtocol <NSObject>

+ (UIColor *) backgroundColor;
+ (UIColor *) labelTextColor;
+ (UIColor *) inactiveTextColor;
+ (UIColor *) alarmTextColor;
+ (UIColor *) infoBackgroundColor;
+ (UIColor *) acceptLineColor;
+ (UIColor *) acceptBackgroundColor;
+ (UIColor *) declineLineColor;
+ (UIColor *) declineBackgroundColor;

+ (UIFont *) labelFontWithSize:(CGFloat)fontSize;

@end;


@interface ADTheme : NSObject <ADThemeProtocol>

@end
