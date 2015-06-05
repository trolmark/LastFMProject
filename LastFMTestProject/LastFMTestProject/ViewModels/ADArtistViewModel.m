//
//  ADArtistViewModel.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtistViewModel.h"
#import "ADModels.h"
#import "RACSignal+Image.h"
#import "Support.h"

@interface ADArtistViewModel()

@property (nonatomic, strong) ADArtist *model;

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
}

@end
