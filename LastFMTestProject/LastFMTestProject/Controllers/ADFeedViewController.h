//
//  ADFeedViewController.h
//  LastFMTestProject
//
//  Created by Andrew on 6/7/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADTimeline, ADCollectionViewDataSource;
@interface ADFeedViewController : UICollectionViewController

@property (nonatomic, strong) ADTimeline *feed;
@property (nonatomic, strong) ADCollectionViewDataSource *dataSource;

- (void)refreshFeed;
- (void)loadNextFeedPage;

@end
