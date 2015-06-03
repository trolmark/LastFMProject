//
//  ADAlbumViewModel.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAlbumViewModel.h"
#import "ADModels.h"

@interface ADAlbumViewModel()
@property (nonatomic, strong) ADAlbum *model;
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
    
}

@end
