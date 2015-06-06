//
//  ViewController.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtistListViewController.h"
#import "ADArtistDetailViewController.h"
#import "ADTimeline.h"
#import "ADFeedSubclasses.h"
#import "ADCollectionViewDataSource.h"
#import "ADViewModels.h"
#import "ADArtistCell.h"

@interface ADArtistListViewController ()

@property (nonatomic, strong) ADTimeline *feed;
@property (nonatomic, strong) ADCollectionViewDataSource *dataSource;

@end

@implementation ADArtistListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupDataSource];
    [self setupCollectionView];
    [self setupTimeline];
    
    [self.dataSource registerReusableViewsWithCollectionView:self.collectionView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view layoutIfNeeded];
    [self updateView];
}

- (void) setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
}

- (void) setupDataSource
{
    self.dataSource = [[ADCollectionViewDataSource alloc]
                            initWithItems:@[]
                            cellIdentifier:NSStringFromClass([ADArtistCell class])
                            configureCellBlock:^(ADArtistCell *cell, ADArtistViewModel *item) {
                                [cell configureWithData:item];
                            }];
    self.collectionView.dataSource = self.dataSource;
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
        [self.dataSource setItems:items];
        [self.collectionView reloadData];
    } failure:nil];
}

#pragma mark - UICollectionViewProtocol

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ADArtistViewModel *viewModel = [self.dataSource itemAtIndexPath:indexPath];
    ADArtistDetailViewController *detailController = [[ADArtistDetailViewController alloc] initWithArtistViewModel:viewModel];
    [self.navigationController pushViewController:detailController animated:YES];
}



@end
