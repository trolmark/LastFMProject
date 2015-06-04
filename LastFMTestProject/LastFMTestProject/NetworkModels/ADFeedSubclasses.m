//
//  ADFeedSubclasses.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADFeedSubclasses.h"
#import "Support.h"
#import "ADAPIClient.h"
#import "ADModels.h"
#import "ADViewModels.h"

@interface ADCountryFeedItem ()

@property (nonatomic, strong) NSString *country;

@end

@implementation ADCountryFeedItem

- (instancetype)initWithCountry:(NSString *)country
{
    self = [super init];
    if (!self) { return nil; }
    
    _country = country;
    return self;
}

- (void)performNetworkRequestAtPage:(NSInteger)page withSuccess:(ResponseBlock)success failure:(ErrorBlock)failure
{
    [[[ADAPIClient newAPIClient] fetchArtistListAtPage:page byCountry:_country] subscribeNext:^(NSArray *items) {
        items = [[[items rac_sequence] map:^id(ADArtist *value) {
            return [[ADArtistViewModel alloc] initWithModel:value];
        }] array];
        
        if (success) success(items);
    } error:^(NSError *error) {
        if (failure) failure(error);
    }];
}

@end


////////////////////////

@interface ADArtistFeedItem ()
@property (nonatomic, strong) ADArtist *artist;
@end

@implementation ADArtistFeedItem

- (instancetype)initWithArtist:(ADArtist *)artist {
    self = [super init];
    if (!self) { return nil; }
    
    _artist = artist;
    return self;
}

- (void)performNetworkRequestAtPage:(NSInteger)page withSuccess:(ResponseBlock)success failure:(ErrorBlock)failure
{
    [[[ADAPIClient newAPIClient] fetchAlbumListAtPage:page forArtist:_artist] subscribeNext:^(NSArray *items) {
        items = [[[items rac_sequence] map:^id(ADAlbum *value) {
            return [[ADAlbumViewModel alloc] initWithModel:value];
        }] array];
        
        if (success) success(items);
    } error:^(NSError *error) {
        if (failure) failure(error);
    }];
}

@end
