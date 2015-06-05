//
//  ADArtistDetailViewController.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtistDetailViewController.h"
#import "ADAlbumViewController.h"
#import "ADViewModels.h"
#import "ADTimeline.h"
#import "ADFeedSubclasses.h"
#import "ADCollectionViewDataSource.h"
#import "ADAlbumCell.h"
#import "ADArtistDetailFlowLayout.h"

@interface ADArtistDetailViewController ()

@property (nonatomic, strong) ADArtistViewModel *viewModel;
@property (nonatomic, strong) ADTimeline *feed;
@property (nonatomic, strong) ADCollectionViewDataSource *dataSource;

@end

@implementation ADArtistDetailViewController


- (instancetype) initWithArtistViewModel:(ADArtistViewModel *) viewModel
{
    ADArtistDetailFlowLayout *flowLayout = [[ADArtistDetailFlowLayout alloc] init];
    self = [self initWithCollectionViewLayout:flowLayout];
    if (!self) return nil;
    
    if ([viewModel isKindOfClass:[ADArtistViewModel class]]) {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDataSource];
    [self setupCollectionView];
    [self setupTimeline];
}

- (void) setupDataSource
{
    self.dataSource = [[ADCollectionViewDataSource alloc]
                       initWithItems:@[]
                       cellIdentifier:NSStringFromClass([ADAlbumCell class])
                       configureCellBlock:^(ADAlbumCell *cell, ADAlbumViewModel *item) {
                           [cell configureWithData:item];
                       }];
    self.collectionView.dataSource = self.dataSource;
}

- (void) setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor clearColor];
}

- (void) setupTimeline
{
    ADArtistFeedItem *feedItem = [[ADArtistFeedItem alloc] initWithArtist:nil];
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
    } failure:nil];
}

#pragma mark - UICollectionViewProtocol

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ADAlbumViewModel *viewModel = [self.dataSource itemAtIndexPath:indexPath];
    ADAlbumViewController *detailController = [[ADAlbumViewController alloc] initWithAlbumViewModel:viewModel];
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
