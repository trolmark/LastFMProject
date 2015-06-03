//
//  ADAlbum.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAlbum.h"

@implementation ADAlbum

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"rank" : @"rank",
             @"name" : @"name",
             @"count" : @"playcount",
             @"artist" : @"artist"
             };
}

@end
