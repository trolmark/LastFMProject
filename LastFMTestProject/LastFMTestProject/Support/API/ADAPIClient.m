//
//  ADAPIClient.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAPIClient.h"
#import "ADAPIClient+Stubs.h"
#import "Support.h"
#import "ADModels.h"
#import "ADNetworkConstants.h"


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
             ADArtistListPath   : [ADArtist class],
             ADAlbumListPath    : [ADAlbum class],
             ADAlbumInfoPath    : [ADAlbum class],
            };
}

+ (NSDictionary *)responseClassesByResourcePath {
    return @{
             ADArtistListPath   : [OVCResponse class],
             ADAlbumListPath    : [OVCResponse class],
             ADAlbumInfoPath    : [OVCResponse class],
             };
}


- (RACSignal *) fetchArtistListAtPage:(NSInteger) page byCountry:(NSString *) country
{
    if (!country) return [RACSignal empty];
    
    NSDictionary *params = @{@"method"  : ADArtistListPath,
                             @"api_key" : kLastFMAPIKey,
                             @"country" : country,
                             @"format"  : @"json"};
    
    return [[self rac_GET:@"" parameters:params] map:^NSArray *(OVCResponse *response) {
        return response.result;
    }];
}

- (RACSignal *) fetchAlbumListAtPage:(NSInteger) page forArtist:(ADArtist *) artist
{
    return [[self rac_GET:@"" parameters:nil]  map:^NSArray *(OVCResponse *response) {
        return response.result;
    }];
}

- (RACSignal *) fetchInfoForAlbum:(ADAlbum *) album
{
    return [[self rac_GET:@"" parameters:nil]  map:^NSArray *(OVCResponse *response) {
        return response.result;
    }];
}


@end
