//
//  ADAlbumViewModel.h
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADViewModelProtocol.h"

@class ADAlbum;
@interface ADAlbumViewModel : NSObject <ADViewModelProtocol>

@property (nonatomic, strong, readonly) ADAlbum *model;
@property (nonatomic, strong, readonly) NSData *thumbnailData;
@property (nonatomic, copy, readonly) NSString *largeImageURL;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *playCountText;


- (void) updateModel:(ADAlbum *) newModel;
- (NSArray *) tracks;

@end
