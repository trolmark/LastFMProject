//
//  ADAlbumViewModel.h
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADViewModelProtocol.h"
#import "Types.h"

@class ADAlbum;
@interface ADAlbumViewModel : NSObject <ADViewModelProtocol>

@property (nonatomic, strong, readonly) ADAlbum *model;
@property (nonatomic, strong, readonly) NSData *thumbnailData;
@property (nonatomic, strong, readonly) NSURL *largeImageURL;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *playCountText;


- (void) fetchAlbumInfoWithSuccess:(ResponseBlock)success failure:(ErrorBlock)failure;

@end
