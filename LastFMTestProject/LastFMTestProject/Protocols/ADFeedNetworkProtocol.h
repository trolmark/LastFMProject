//
//  ADFeedNetworkProtocol.h
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Types.h"

@protocol ADFeedNetworkProtocol <NSObject>

- (void)performNetworkRequestAtPage:(NSInteger)page withSuccess:(ResponseBlock)success failure:(ErrorBlock)failure;

@end
