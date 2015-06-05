//
//  ADArtistViewModel.h
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADViewModelProtocol.h"

@class ADArtist;
@interface ADArtistViewModel : NSObject <ADViewModelProtocol>

@property (nonatomic, strong, readonly) ADArtist *model;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign, readonly) NSInteger playCount;
@property (nonatomic, strong, readonly) NSData *thumbnailData;

@end
