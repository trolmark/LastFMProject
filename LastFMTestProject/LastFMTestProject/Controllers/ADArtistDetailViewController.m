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
    
    self.title = self.viewModel.name;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self setupDataSource];
    [self setupTimeline];
    [self.dataSource registerReusableViewsWithCollectionView:self.collectionView];
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

- (void) setupTimeline
{
    ADArtistFeedItem *feedItem = [[ADArtistFeedItem alloc] initWithArtist:self.viewModel.model];
    self.feed = [[ADTimeline alloc] initWithFeedItem:feedItem];
}

#pragma mark - UICollectionViewProtocol

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ADAlbumViewModel *viewModel = [self.dataSource itemAtIndexPath:indexPath];
    ADAlbumViewController *detailController = [[ADAlbumViewController alloc] initWithAlbumViewModel:viewModel];
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
