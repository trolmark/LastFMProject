//
//  ADTrackViewModel.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADTrackViewModel.h"
#import "ADModels.h"
#import "Support.h"

@interface ADTrackViewModel()

@property (nonatomic, strong) ADTrack *model;

@end

@implementation ADTrackViewModel

- (instancetype)initWithModel:(ADTrack *)model {
    self = [super init];
    if (!self)
    return nil;
    
    if ([model isKindOfClass:[ADTrack class]]) {
        self.model = model;
        [self setupPresentationLogic];
    }
    
    return self;
}

- (void) setupPresentationLogic {
    //RAC(self,rank) = RACObserve(self.model, )
}

@end
