//
//  ADAlbum.h
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Mantle/Mantle.h>

@class ADArtist;
@interface ADAlbum : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, copy, readonly) NSNumber *count;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *imageThumbURL;
@property (nonatomic, strong) ADArtist *artist;

@end
