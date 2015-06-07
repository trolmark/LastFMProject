//
//  ADTimeline.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/3/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADTimeline.h"
#import "Support.h"

@interface ADTimeline()

@property (readwrite, nonatomic, assign) BOOL downloadLock;
@property (readwrite, nonatomic, assign) NSInteger currentPage;
@property (readwrite, nonatomic, strong) id<ADFeedNetworkProtocol> feedItem;

@end

@implementation ADTimeline

- (instancetype)init
{
    return [self initWithFeedItem:nil];
}

- (instancetype) initWithFeedItem:(id<ADFeedNetworkProtocol>) feedItem
{
    self = [super init];
    if (!self) { return nil; }
    
    [self updateFeedItem:feedItem];
    return self;
}

- (void)getNextPage:(ResponseBlock)success failure:(ErrorBlock)failure
{
    if (self.downloadLock) { return; }
    
    self.downloadLock = YES;
    @weakify(self);
    
    [self.feedItem performNetworkRequestAtPage:self.currentPage withSuccess:^(NSArray *items) {
        @strongify(self);
        if (!self) { return; }
        
        self.currentPage++;
        self.downloadLock = NO;
        
        if (items.count == 0) {
            self->_allDownloaded = YES;
        }
        
        if(success) success(items);
        
    } failure:^(NSError *error) {
        @strongify(self);
        if (!self) { return; }
        
        self->_allDownloaded = YES;
        self.downloadLock = NO;
        
        if(failure) failure(error);
    }];
}


- (void) updateFeedItem:(id<ADFeedNetworkProtocol>) feedItem
{
    self.currentPage = 1;
    self->_allDownloaded = NO;
    self.feedItem = feedItem;
}

@end
