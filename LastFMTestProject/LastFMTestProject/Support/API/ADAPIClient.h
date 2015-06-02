//
//  ADAPIClient.h
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Overcoat/Overcoat.h>
#import <Overcoat/ReactiveCocoa+Overcoat.h>

@interface ADAPIClient : OVCHTTPSessionManager

+ (instancetype) newAPIClient;

@end
