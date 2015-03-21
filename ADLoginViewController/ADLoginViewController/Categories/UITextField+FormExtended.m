//
//  UITextField+FormExtended.m
//  RemoteAlarm
//
//  Created by Andrey Denisov on 12/29/14.
//  Copyright (c) 2014 Sotera Wireless. All rights reserved.
//

#import "UITextField+FormExtended.h"
#import <objc/runtime.h>

static char defaultHashKey;

@implementation UITextField (FormExtended)

- (UITextField*) ra_nextTextField {
    return objc_getAssociatedObject(self, &defaultHashKey);
}

- (void) setRa_nextTextField:(UITextField *)ra_nextTextField {
    objc_setAssociatedObject(self, &defaultHashKey, ra_nextTextField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
