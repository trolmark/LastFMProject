//
//  ADTimeline.h
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Types.h"
#import "ADFeedNetworkProtocol.h"

@interface ADTimeline : NSObject

@property (readonly, nonatomic, assign) BOOL allDownloaded;
@property (readonly, nonatomic, assign) BOOL downloadLock;

- (instancetype) initWithFeedItem:(id<ADFeedNetworkProtocol>) feedItem;

- (void) getNextPage:(ResponseBlock)success failure:(ErrorBlock)failure;
- (void) updateFeedItem:(id<ADFeedNetworkProtocol>) feedItem;

@end
