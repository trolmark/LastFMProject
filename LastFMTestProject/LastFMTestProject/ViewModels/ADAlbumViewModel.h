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

@end
