//
//  ADTrackViewModel.h
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADViewModelProtocol.h"


@class ADTrack;
@interface ADTrackViewModel : NSObject <ADViewModelProtocol>

@property (nonatomic, strong, readonly) ADTrack *model;
@property (nonatomic, copy, readonly) NSString *rank;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *durationText;
@property (nonatomic, copy, readonly) NSAttributedString *attributedTitle;

@end
