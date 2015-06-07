//
//  ADAlbumViewController.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAlbumViewController.h"
#import "ADViewModels.h"
#import "ADModels.h"
#import "ADAPIClient.h"
#import "ADCollectionViewDataSource.h"
#import "ADTrackCell.h"
#import "ADAlbumDetailFlowLayout.h"
#import "ADImageHelper.h"
#import "Support.h"
#import "ADCollectionViewMetrics.h"
#import "ADAlbumCoverHeaderView.h"

@interface ADAlbumViewController ()

@property (nonatomic, strong) ADAlbumViewModel *viewModel;
@property (nonatomic, strong) ADCollectionViewDataSource *dataSource;

@end

@implementation ADAlbumViewController


- (instancetype) initWithAlbumViewModel:(ADAlbumViewModel *) viewModel
{
    ADAlbumDetailFlowLayout *flowLayout = [[ADAlbumDetailFlowLayout alloc] init];
    self = [self initWithCollectionViewLayout:flowLayout];
    if (!self) return nil;
    
    
    if ([viewModel isKindOfClass:[ADAlbumViewModel class]]) {
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
    [self.dataSource registerReusableViewsWithCollectionView:self.collectionView];
    
    [self fetchData];
}

- (void) setupDataSource
{
    ADCellLayoutMetrics *cellMetrics = [[ADCellLayoutMetrics alloc]
                                            initWithClass:[ADTrackCell class]
                                            cellIdentifier:NSStringFromClass([ADTrackCell class])
                                            useNib:NO];
    
    ADSupplementaryLayoutMetrics *headerMetrics = [[ADSupplementaryLayoutMetrics alloc]
                                                        initWithClass:[ADAlbumCoverHeaderView class]
                                                        identifier:NSStringFromClass([ADAlbumCoverHeaderView class])
                                                        useNib:NO];
    
    ADLayoutMetrics *layoutMetrics = [[ADLayoutMetrics alloc] init];
    layoutMetrics.cellMetrics = @[cellMetrics];
    layoutMetrics.headers = @[headerMetrics];
    
    self.dataSource = [[ADCollectionViewDataSource alloc]
                            initWithLayoutMetrics:layoutMetrics
                            configureCellBlock:^(ADTrackCell *cell, ADTrackViewModel *item) {
                                [cell configureWithData:item];
                            }];
    
    @weakify(self)
    self.dataSource.configureSupplementaryBlock = ^(ADAlbumCoverHeaderView *supplementary, NSString *kind, NSIndexPath *path) {
        @strongify(self)
        if (UICollectionElementKindSectionHeader == kind) {
            [supplementary configureWithData:self.viewModel];
        }
    };
    
    self.collectionView.dataSource = self.dataSource;
}

- (void) fetchData
{
    @weakify(self)
    [self.viewModel fetchAlbumInfoWithSuccess:^(NSArray *tracks) {
        @strongify(self)
        [self.dataSource setItems:tracks];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.frame.size.width, 150);
}


@end
