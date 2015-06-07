//
//  CountryItem.h
//  LastFMTestProject
//
//  Created by Andrew on 6/7/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CountryItem : NSObject


@property (nonatomic,copy,readonly) NSString *name;
@property (nonatomic, strong, readonly) UIImage *image;

- (instancetype) initWithName:(NSString *) name image:(UIImage *) image;
- (instancetype) initWithName:(NSString *) name;
@end
