//
//  ADFeedSubclasses.h
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADFeedNetworkProtocol.h"
#import "ADModels.h"

@interface ADCountryFeedItem : NSObject <ADFeedNetworkProtocol>
- (instancetype)initWithCountry:(NSString *)country;
@end

@interface ADArtistFeedItem : NSObject <ADFeedNetworkProtocol>
- (instancetype)initWithArtist:(ADArtist *)artist;
@end
