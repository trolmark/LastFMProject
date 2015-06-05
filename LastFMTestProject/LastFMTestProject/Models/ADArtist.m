//
//  ADArtist.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtist.h"
#import "ADLastFMHelper.h"

@interface ADArtist()

@property (nonatomic, copy, readwrite) NSString *imageThumbURL;
@property (nonatomic, copy, readwrite) NSDictionary *image;
@end

@implementation ADArtist

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"rank" : @"rank",
             @"name" : @"name",
             @"listenersCount" : @"listeners",
             @"image":@"image"
             };
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error
{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    // Process image array
    NSArray *imageArray = dictionaryValue[@"image"];
    NSString *imageThumbURL, *imageURL;
    ADSetImageURLsForThumbAndImage(imageArray, &imageThumbURL, &imageURL);
    self.imageThumbURL = imageThumbURL;
    
    return self;
}

@end
