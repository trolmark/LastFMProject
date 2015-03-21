//
//  ADUserLoginModel.m
//  ADLoginViewController
//
//  Created by Andrew on 3/20/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADUserLoginModel.h"

@interface ADUserLoginModel()

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@end

@implementation ADUserLoginModel

- (instancetype) initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.username = username;
    self.password = password;
    
    return self;
}

- (NSDictionary *) loginParams
{
    return @{
        @"username" : self.username,
        @"pass" : self.password
    };
}

@end
