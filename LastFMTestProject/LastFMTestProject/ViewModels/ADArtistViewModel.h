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
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *listenersCountText;
@property (nonatomic, copy, readonly) NSData *thumbnailData;
@property (nonatomic, strong, readonly) NSURL *largeImageURL;

@end
