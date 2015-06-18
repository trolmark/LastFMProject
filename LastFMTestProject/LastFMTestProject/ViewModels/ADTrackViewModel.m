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
@property (nonatomic, copy) NSAttributedString *attributedTitle;

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
    RAC(self, attributedTitle) = [RACSignal
                                    combineLatest:@[RACObserve(self.model,rank),RACObserve(self.model, name), RACObserve(self.model, duration) ]
                                    reduce:^(NSNumber *rank, NSString *name, NSNumber *duration) {
                                        NSString *title = [NSString stringWithFormat:@"%d. %@ %@",[rank intValue],name,[self formatTime:duration]];
                                        NSMutableAttributedString *value = [[NSMutableAttributedString alloc] initWithString:title ?: @""];
                                        NSString *rankStr = [NSString stringWithFormat:@"%d",[rank intValue]];
                                        NSString *durationStr = [self formatTime:duration];
                                        
                                        [value addAttribute:NSFontAttributeName
                                                      value:[UIFont fontWithName:kBaseFont size:11.0]
                                                      range:[title rangeOfString:rankStr]];
                                        
                                        [value addAttribute:NSFontAttributeName
                                                      value:[UIFont fontWithName:kBaseFont size:11.0]
                                                      range:[title rangeOfString:durationStr]];
                                        
                                        [value addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[title rangeOfString:durationStr]];
                                        
                                        return value;
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
