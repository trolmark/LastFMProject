//
//  CountryItem.m
//  LastFMTestProject
//
//  Created by Andrew on 6/7/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "CountryItem.h"

@interface CountryItem()

@property (nonatomic,copy,readwrite) NSString *name;
@property (nonatomic, strong, readwrite) UIImage *image;

@end

@implementation CountryItem


- (instancetype) initWithName:(NSString *) name image:(UIImage *) image
{
    self = [super init];
    if (!self) { return nil; }
    
    self.name = name;
    self.image = image;
    
    return self;
}

- (instancetype) initWithName:(NSString *) name {
    return [self initWithName:name image:nil];
}


@end
