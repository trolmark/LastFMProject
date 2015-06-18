//
//  ADArtistViewModel.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtistViewModel.h"
#import "ADModels.h"
#import "Support.h"
#import "ADImageHelper.h"

@interface ADArtistViewModel()

@property (nonatomic, strong) ADArtist *model;
@property (nonatomic, copy, readwrite) NSData *thumbnailData;

@end

@implementation ADArtistViewModel

- (instancetype)initWithModel:(ADArtist *)model {
    self = [super init];
    if (!self)
    return nil;
    
    if ([model isKindOfClass:[ADArtist class]]) {
        self.model = model;
        [self setupPresentationLogic];
    }
    
    return self;
}

- (void) setupPresentationLogic
{
    RAC(self, name) = RACObserve(self.model, name);
    RAC(self, listenersCountText) = [RACObserve(self.model, listenersCount) map:^NSString *(NSNumber *value) {
        return [NSString stringWithFormat:@"%ld listeners",(long)value.integerValue];
    }];
    
    RAC(self, largeImageURL) = [RACObserve(self.model, largeImageURL) map:^id(NSString *value) {
        return [NSURL URLWithString:value];
    }];
    
    [[ADImageHelper imageData:[NSURL URLWithString:self.model.imageThumbURL]]
        subscribeNext:^(NSData *x) {
            self.thumbnailData = x;
    }];
}

@end
