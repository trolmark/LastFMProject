//
//  ADFeedViewController.m
//  LastFMTestProject
//
//  Created by Andrew on 6/7/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADFeedViewController.h"
#import "ADTimeline.h"
#import "ADCollectionViewDataSource.h"
#import "PCAngularActivityIndicatorView.h"
#import "Support.h"

@interface ADFeedViewController()

@property (nonatomic, strong) PCAngularActivityIndicatorView *loadingIndicator;

@end

@implementation ADFeedViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setupLoadingIndicator];
}

- (void) setupLoadingIndicator
{
    self.loadingIndicator = [[PCAngularActivityIndicatorView alloc] initWithActivityIndicatorStyle:PCAngularActivityIndicatorViewStyleLarge];
    self.loadingIndicator.color = [UIColor redColor];
    [self.view addSubview:self.loadingIndicator];
    
    [RACObserve(self.feed, loading) subscribeNext:^(NSNumber *loading) {
        [loading boolValue] ? [self.loadingIndicator startAnimating] : [self.loadingIndicator stopAnimating];
    }];
}


- (void)refreshFeed
{
    BOOL allDownloaded = self.feed.allDownloaded;
    [self.collectionView reloadData];
    if (!allDownloaded) {
        [self checkContentSize];
    }
}

- (void)checkContentSize
{
    CGFloat contentHeight = self.collectionView.contentSize.height;
    CGFloat frameHeight = self.collectionView.frame.size.height;
    CGFloat offsetY = self.collectionView.contentOffset.y;
    if((contentHeight - offsetY) < frameHeight) {
        [self loadNextFeedPage];
    }
}

- (void)loadNextFeedPage
{
    if (self.feed.allDownloaded) { return; };
    
    [self.feed getNextPage:^(NSArray *items) {
        [self updateViewWithItems:items];
    } failure:nil];
}

- (void) updateViewWithItems:(NSArray *) items
{
    [self.dataSource addItems:items];
    [self.collectionView reloadData];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    [self checkContentSize];
}



@end
