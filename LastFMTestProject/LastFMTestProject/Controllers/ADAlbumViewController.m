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
#import "PCAngularActivityIndicatorView.h"

@interface ADAlbumViewController ()

@property (nonatomic, strong) ADAlbumViewModel *viewModel;
@property (nonatomic, strong) ADCollectionViewDataSource *dataSource;
@property (nonatomic, strong) PCAngularActivityIndicatorView *loadingIndicator;

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
    [self setupLoadingIndicator];
    [self.dataSource registerReusableViewsWithCollectionView:self.collectionView];
    
    [self fetchData];
}

- (void) setupLoadingIndicator
{
    self.loadingIndicator = [[PCAngularActivityIndicatorView alloc] initWithActivityIndicatorStyle:PCAngularActivityIndicatorViewStyleLarge];
    self.loadingIndicator.color = [UIColor lightGrayColor];
    [self.view addSubview:self.loadingIndicator];
    self.loadingIndicator.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
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
    [self.loadingIndicator startAnimating];
    @weakify(self)
    [self.viewModel fetchAlbumInfoWithSuccess:^(NSArray *tracks) {
        @strongify(self)
        [self.loadingIndicator stopAnimating];
        [self updateViewWithItems:tracks];
    } failure:^(NSError *error) {
        @strongify(self)
        [self.loadingIndicator stopAnimating];
        [TSMessage  showNotificationWithTitle:error.debugDescription
                                         type:TSMessageNotificationTypeError];
    }];
}

- (void) updateViewWithItems:(NSArray *) items
{
    [self.dataSource addItems:items];
    [self.collectionView reloadData];
}

#pragma mark UICollectionFlowLayoutDelegate

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat spacing = 10;
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.width - 2*spacing);
}


@end
