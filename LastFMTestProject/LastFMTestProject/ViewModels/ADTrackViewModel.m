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

- (void) setupPresentationLogic
{
    RAC(self, title) = [RACSignal
                            combineLatest:@[ RACObserve(self.model, name), RACObserve(self.model, duration) ]
                            reduce:^(NSString *name, NSNumber *duration) {
                                return [NSString stringWithFormat:@"%@ %@",name,[self formatTime:duration]];
                            }];
}

- (NSString *) formatTime:(NSNumber *)time
{
    NSInteger totalSeconds = [time intValue];
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
}

@end
