//
//  ADUserLoginModel.h
//  ADLoginViewController
//
//  Created by Andrew on 3/20/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADUserLoginModel : NSObject

- (instancetype) initWithUsername:(NSString *)username password:(NSString *)password;
- (NSDictionary *) loginParams;

@end
