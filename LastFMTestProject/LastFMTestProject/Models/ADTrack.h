//
//  ADTrack.h
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ADTrack : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSNumber *duration;
@property (nonatomic, copy) NSNumber *rank;



@end
