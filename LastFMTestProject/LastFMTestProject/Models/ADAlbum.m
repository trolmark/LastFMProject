//
//  ADAlbum.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAlbum.h"
#import "ADArtist.h"
#import "ADLastFMHelper.h"

@interface ADAlbum()

@property (nonatomic, copy, readwrite) NSString *imageThumbURL;
@property (nonatomic, copy, readwrite) NSString *imageURL;
@property (nonatomic, copy, readwrite) NSDictionary *imageDic;
@end

@implementation ADAlbum

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name" : @"name",
             @"artist" : @"artist",
             @"count" : @"playcount",
             @"imageDic":@"image"
            };
}


+ (NSValueTransformer *)artistJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:ADArtist.class];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error
{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    // Process image array
    NSArray *imageArray = dictionaryValue[@"imageDic"];
    NSString *imageThumbURL, *imageURL;
    ADSetImageURLsForThumbAndImage(imageArray, &imageThumbURL, &imageURL);
    self.imageThumbURL = imageThumbURL;
    self.imageURL = imageURL;
    
    return self;
}


@end
