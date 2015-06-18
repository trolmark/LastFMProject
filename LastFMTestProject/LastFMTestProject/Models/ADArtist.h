//
//  ADArtist.h
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ADArtist : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *rank;
@property (nonatomic, copy, readonly) NSNumber *listenersCount;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *imageThumbURL;
@property (nonatomic, copy, readonly) NSString *largeImageURL;

@end
