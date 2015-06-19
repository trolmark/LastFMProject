//
//  UIColor+Random.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/19/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+ (UIColor *) randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

@end
