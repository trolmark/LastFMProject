//
//  ADTrack.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADTrack.h"

@interface ADTrack()

@end

@implementation ADTrack

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name" : @"name",
             @"duration" : @"duration",
             };
}



@end
