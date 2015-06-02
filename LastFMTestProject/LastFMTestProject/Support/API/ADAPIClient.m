//
//  ADAPIClient.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAPIClient.h"
#import "ADAPIClient+Stubs.h"
#import "Constants.h"


@implementation ADAPIClient

+ (instancetype) newAPIClient
{
    NSURL *baseURL = [NSURL URLWithString:kBaseAPIURL];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                      diskCapacity:50 * 1024 * 1024
                                                          diskPath:nil];
    [config setURLCache:cache];
    
    
    ADAPIClient *sharedClient = [[ADAPIClient alloc] initWithBaseURL:baseURL
                                                sessionConfiguration:config];
    sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
    
    if (TEST_MODE) {
        [ADAPIClient stubAllRequests];
    }

    return sharedClient;
}


#pragma mark - API Private methods

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
            
             };
}

+ (NSDictionary *)responseClassesByResourcePath {
    return @{
             
             };
}


@end
