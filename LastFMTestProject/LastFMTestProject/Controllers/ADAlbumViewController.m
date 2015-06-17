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
#import "ADImageHelper.h"
#import "ADTransitionProtocol.h"

@interface ADAlbumViewController ()<ADTransitionProtocol>

@property (nonatomic, strong) ADAlbumViewModel *viewModel;
@property (nonatomic, strong) ADCollectionViewDataSource *dataSource;
@property (nonatomic, strong) PCAngularActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) UIImageView *headerView;

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

    [self setupHeaderView];
    [self setupDataSource];
    [self setupLoadingIndicator];
    [self.dataSource registerReusableViewsWithCollectionView:self.collectionView];
    
    [self fetchData];
    
    UIEdgeInsets insets = self.collectionView.contentInset;
    insets.top = 20 + 300;
    self.collectionView.contentInset = insets;
    
}

- (void) setupLoadingIndicator
{
    self.loadingIndicator = [[PCAngularActivityIndicatorView alloc] initWithActivityIndicatorStyle:PCAngularActivityIndicatorViewStyleLarge];
    self.loadingIndicator.color = [UIColor lightGrayColor];
    [self.view addSubview:self.loadingIndicator];
    self.loadingIndicator.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}

- (void) setupHeaderView
{
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.headerView];
    [self.headerView alignLeading:@"0" trailing:@"0" toView:self.view];
    [self.headerView constrainTopSpaceToView:(UIView *)self.topLayoutGuide predicate:@"0"];
    [self.headerView constrainHeight:@"300"];
    
    @weakify(self)
    [[ADImageHelper imageData:self.viewModel.largeImageURL]
     subscribeNext:^(NSData *x) {
         @strongify(self)
         UIImage *coverImage = [UIImage imageWithData:x];
         self.headerView.image = coverImage;
     }];
}


- (void) setupDataSource
{
    self.dataSource = [[ADCollectionViewDataSource alloc]
                        initWithItems:@[]
                       cellIdentifier:NSStringFromClass([ADTrackCell class])
                       configureCellBlock:^(ADTrackCell *cell, ADTrackViewModel *item) {
            [cell configureWithData:item];
        
    }];

    
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

#pragma mark ADTransitionProtocol 

- (UIView *) snapShotForTransition {
    return self.headerView;
}

- (CGRect) transitionDestinationFrame
{
    return CGRectMake(0, 64, self.view.bounds.size.width, 300);
}




@end
