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
#import "MTLModel+Dictionary.h"


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
                             @"page"    : @(page),
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
                             @"page"    : @(page),
                             @"format"  : @"json"};
    
    return [[[[self rac_GET:@"" parameters:params]  map:^NSArray *(OVCResponse *response) {
        return response.result[@"topalbums"][@"album"];
    }] map:^NSArray *(NSArray *items) {
        return [[[[items rac_sequence] filter:^BOOL(NSDictionary *value) {
            return [value isKindOfClass:[NSDictionary class]];
        }] map:^ADAlbum *(NSDictionary *value) {
            return [ADAlbum modelWithJSON:value];
        }] array];
    }] deliverOnMainThread];
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
        return [[[[items rac_sequence] filter:^BOOL(NSDictionary *value) {
            return [value isKindOfClass:[NSDictionary class]];
        }] map:^ADTrack *(NSDictionary *value) {
            ADTrack *model = [ADTrack modelWithJSON:value];
            // FIXTO : just to simplify
            model.rank = value[@"@attr"][@"rank"];
            return model;
        }] array];
    }];
}


@end
