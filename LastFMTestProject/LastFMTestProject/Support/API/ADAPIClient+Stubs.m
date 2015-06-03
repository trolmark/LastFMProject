//
//  ADAPIClient+Stubs.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAPIClient+Stubs.h"
#import "ADModels.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "ADNetworkConstants.h"


@implementation ADAPIClient (Stubs)

+ (void) stubAllRequests
{
    [self stubArtistList];
    [self stubAlbumInfo];
    [self stubAlbumList];
}

+ (void) stubArtistList {

    NSDictionary *artist = @{
        @"rank": @1,
        @"name": @"Coldplay",
        @"playcount": @3199,
        @"mbid": @"cc197bad-dc9c-440d-a5b5-d52ba2e14234",
        @"url": @"http://www.last.fm/music/Coldplay",
        @"streamable": @YES,
        @"image_small": @"",
        @"image_medium":@"",
        @"image_large": @""
    };
    
    NSData *artistData = [NSKeyedArchiver archivedDataWithRootObject:artist];
    [self stubRequestWithPath:ADArtistListPath response:artistData];
}

+ (void) stubAlbumList {
    
}

+ (void) stubAlbumInfo {
    
}

+ (void) stubRequestWithPath:(NSString *)path response:(NSData *)response
{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [self isRequest:request toPath:path];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithData:response statusCode:200 headers:[self stubbedHeaders]];
    }];
}

+ (NSDictionary *) stubbedHeaders {
    return @{@"Content-Type":@"application/json"};
}

+ (BOOL) isRequest:(NSURLRequest *)request toPath:(NSString *)path {
    return ([request.URL.relativePath rangeOfString:path].location != NSNotFound);
}

@end
