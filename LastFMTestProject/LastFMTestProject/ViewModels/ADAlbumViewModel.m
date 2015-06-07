//
//  ADAlbumViewModel.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAlbumViewModel.h"
#import "ADModels.h"
#import "ADImageHelper.h"
#import "ADTrackViewModel.h"
#import "ADAPIClient.h"

@interface ADAlbumViewModel()

@property (nonatomic, strong) ADAlbum *model;
@property (nonatomic, strong, readwrite) NSData *thumbnailData;

@end

@implementation ADAlbumViewModel

- (instancetype)initWithModel:(ADAlbum *)model {
    self = [super init];
    if (!self)
    return nil;
    
    if ([model isKindOfClass:[ADAlbum class]]) {
        self.model = model;
        [self setupPresentationLogic];
    }
    
    return self;
}

- (void) setupPresentationLogic {
    
    RAC(self, name) = RACObserve(self.model, name);
    RAC(self, playCountText) = [RACObserve(self.model, count) map:^NSString *(NSNumber *value) {
        return [NSString stringWithFormat:@"%ld plays",(long)value.integerValue];
    }];
    
    RAC(self, largeImageURL) = [RACObserve(self.model, imageURL) map:^id(NSString *value) {
        return [NSURL URLWithString:value];
    }];
    
    [[ADImageHelper imageData:[NSURL URLWithString:self.model.imageThumbURL]]
     subscribeNext:^(NSData *x) {
         self.thumbnailData = x;
     }];
}

- (void) updateModel:(ADAlbum *) newModel {
    [self.model mergeValuesForKeysFromModel:newModel];
}

- (NSArray *) tracks {
    return @[];
}

- (void) fetchAlbumInfoWithSuccess:(ResponseBlock)success failure:(ErrorBlock)failure
{
    [[[ADAPIClient newAPIClient] fetchInfoForAlbum:self.model]
     subscribeNext:^(NSArray *items) {
         items = [[[items rac_sequence] map:^id(ADTrack *value) {
             return [[ADTrackViewModel alloc] initWithModel:value];
         }] array];
         
         if (success) success(items);
     } error:^(NSError *error) {
         if (failure) failure(error);
     }];
}

@end
