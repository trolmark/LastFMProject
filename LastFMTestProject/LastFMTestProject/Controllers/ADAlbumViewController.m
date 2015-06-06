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

@interface ADAlbumViewController ()

@property (nonatomic, strong) ADAlbumViewModel *viewModel;
@property (nonatomic, strong) ADCollectionViewDataSource *dataSource;
@property (nonatomic, strong) UICollectionView *trackListView;
@property (nonatomic, strong) UIImageView *coverImageView;

@end

@implementation ADAlbumViewController


- (instancetype) initWithAlbumViewModel:(ADAlbumViewModel *) viewModel {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if ([viewModel isKindOfClass:[ADAlbumViewModel class]]) {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.viewModel.name;
    
    [self setupCoverImage];
    [self setupDataSource];
    [self fetchData];
}

- (void) setupCoverImage
{
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [[ADImageHelper imageData:[NSURL URLWithString:self.viewModel.largeImageURL]]
        subscribeNext:^(NSData *x) {
            self.coverImageView.image = [[UIImage alloc] initWithData:x];
     }];
    
    [self.view addSubview:self.coverImageView];
}

- (void) setupDataSource
{
    self.dataSource = [[ADCollectionViewDataSource alloc]
                       initWithItems:@[]
                       cellIdentifier:NSStringFromClass([ADTrackCell class])
                       configureCellBlock:^(ADTrackCell *cell, ADTrackViewModel *item) {
                           [cell configureWithData:item];
                       }];
    self.trackListView.dataSource = self.dataSource;
}

- (void) setupCollectionView
{
    ADAlbumDetailFlowLayout *layout = [[ADAlbumDetailFlowLayout alloc] init];
    self.trackListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:self.trackListView];
}


- (void) fetchData
{
    [[[ADAPIClient newAPIClient] fetchInfoForAlbum:self.viewModel.model]
        subscribeNext:^(ADAlbum *x) {
            [self.viewModel updateModel:x];
            [self updateUI];
        } error:^(NSError *error) {
            // Log error
    }];
}

- (void) updateUI
{
    [self.dataSource setItems:[self.viewModel tracks]];
    [self.trackListView reloadData];
}




@end
