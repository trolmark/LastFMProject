//
//  ADTheme.m
//  ADLoginViewController
//
//  Created by Andrew on 3/20/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADTheme.h"

#define RGB(r,g,b,a) [UIColor colorWithRed:r green:g blue:b alpha:a]
#define RGB_255(r,g,b,a) RGB(r/255.0,g/255.0,b/255.0,a)

@implementation ADTheme

+ (UIColor *) backgroundColor {
    return RGB_255(27, 40, 58, 1.0);
}

+ (UIColor *) labelTextColor {
    return RGB_255(176, 205, 245, 1.0);
}

+ (UIColor *) inactiveTextColor {
    return RGB_255(176, 205, 245, 0.2);
}

+ (UIColor *) alarmTextColor {
    return RGB_255(255, 68, 68,1.00);
}

+ (UIColor *) infoBackgroundColor {
    return RGB_255(42,57,77,1.00);
}

+ (UIColor *) acceptLineColor {
    return RGB_255(37, 225, 90, 1.0);
}

+ (UIColor *) declineLineColor {
    return RGB_255(200, 0, 0, 1.0);
}

+ (UIColor *) acceptBackgroundColor {
    return RGB_255(0, 35, 1,0.8);
}

+ (UIColor *) declineBackgroundColor {
    return RGB_255(63, 0, 0,0.8);
}

+ (UIFont *) labelFontWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:fontSize];
}



@end
