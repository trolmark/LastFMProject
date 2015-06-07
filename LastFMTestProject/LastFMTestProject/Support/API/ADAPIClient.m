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
#import "MTLModel+JSON.h"


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
    return @{};
}


- (RACSignal *) fetchArtistListAtPage:(NSInteger) page byCountry:(NSString *) country
{
    if (!country) return [RACSignal empty];
    
    NSDictionary *params = @{@"method"  : ADArtistListPath,
                             @"api_key" : kLastFMAPIKey,
                             @"country" : country,
                             @"format"  : @"json"};
    
    return [[[self rac_GET:@"" parameters:params] map:^NSArray *(OVCResponse *response) {
        return response.result[@"topartists"][@"artist"];
    }] map:^NSArray *(NSArray *items) {
        return [[[items rac_sequence] map:^ADArtist *(NSDictionary *value) {
            return [ADArtist modelWithJSON:value];
        }] array];
    }];
}

- (RACSignal *) fetchAlbumListAtPage:(NSInteger) page forArtist:(ADArtist *) artist
{
    NSDictionary *params = @{@"method"  : ADAlbumListPath,
                             @"api_key" : kLastFMAPIKey,
                             @"artist"  : artist.name,
                             @"format"  : @"json"};
    
    return [[[[self rac_GET:@"" parameters:params]  map:^NSArray *(OVCResponse *response) {
        return response.result[@"topalbums"][@"album"];
    }] map:^NSArray *(NSArray *items) {
        return [[[items rac_sequence] map:^ADAlbum *(NSDictionary *value) {
            return [ADAlbum modelWithJSON:value];
        }] array];
    }] deliverOnMainThread];;
}

- (RACSignal *) fetchInfoForAlbum:(ADAlbum *) album
{
    NSDictionary *params = @{@"method"  : ADAlbumInfoPath,
                             @"api_key" : kLastFMAPIKey,
                             @"artist"  : album.artist.name,
                             @"album"   : album.name,
                             @"format"  : @"json"};
    
    return [[[self rac_GET:@"" parameters:params]  map:^NSArray *(OVCResponse *response) {
        return response.result[@"album"][@"tracks"][@"track"];
    }] map:^NSArray *(NSArray *items)  {
        return [[[items rac_sequence] map:^ADTrack *(NSDictionary *value) {
            return [ADTrack modelWithJSON:value];
        }] array];
    }];
}


@end
