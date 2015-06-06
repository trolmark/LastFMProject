//
//  ADImageHelper.h
//  LastFMTestProject
//
//  Created by Andrew on 6/6/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Support.h"

@interface ADImageHelper : NSObject

+(RACSignal *)imageData:(NSURL *)imageUrl;

@end
