//
//  ViewController.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtistListViewController.h"
#import "ADTimeline.h"
#import "ADFeedSubclasses.h"

@interface ADArtistListViewController ()

@property (nonatomic, strong) ADTimeline *feed;

@end

@implementation ADArtistListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupDataSource];
    [self setupCollectionView];
    [self setupTimeline];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view layoutIfNeeded];
    [self updateView];
}

- (void) setupCollectionView {
    self.collectionView.backgroundColor = [UIColor clearColor];
}

- (void) setupDataSource {
    
}

- (void) setupTimeline
{
    ADCountryFeedItem *feedItem = [[ADCountryFeedItem alloc] initWithCountry:@"Spain"];
    self.feed = [[ADTimeline alloc] initWithFeedItem:feedItem];
}

- (void)updateView
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
    if (contentHeight < frameHeight){
        [self getNextItemSet];
    }
}

- (void)getNextItemSet
{
    if (self.feed.allDownloaded) { return; };
    
    [self.feed getNextPage:^(NSArray *items) {
        
    } failure:nil];
}

#pragma mark - UICollectionViewProtocol

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
