//
//  ADImageHelper.m
//  LastFMTestProject
//
//  Created by Andrew on 6/6/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADImageHelper.h"

@implementation ADImageHelper


+(RACSignal *)imageData:(NSURL *)imageUrl {
    
    RACScheduler *scheduler = [RACScheduler
                               schedulerWithPriority:RACSchedulerPriorityBackground];
    
    RACSignal *imageDownloadSignal = [[RACSignal
                                       createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                           NSData *data = [NSData dataWithContentsOfURL:imageUrl];
                                           [subscriber sendNext:data];
                                           [subscriber sendCompleted];
                                           return nil;
                                       }] subscribeOn:scheduler];
    
    return [imageDownloadSignal
            deliverOn:[RACScheduler mainThreadScheduler]];
    
}

@end
