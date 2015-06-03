//
//  ADArtist.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtist.h"

@implementation ADArtist

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"rank" : @"rank",
             @"name" : @"name",
             @"count" : @"playcount"
             };
}

@end
