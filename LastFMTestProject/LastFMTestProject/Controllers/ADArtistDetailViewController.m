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
#import "ADNavigationTransitionHelper.h"
#import "ADTransitionProtocol.h"
#import "ADCoverHeaderView.h"
#import "Support.h"

@interface ADArtistDetailViewController () <ADTransitionProtocol>

@property (nonatomic, strong) ADArtistViewModel *viewModel;
@property (nonatomic, strong) ADAlbumViewModel *selectedModel;
@property (nonatomic, strong) ADCoverHeaderView *headerView;
@property (nonatomic, strong) UIVisualEffectView *blurredView;

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self setupHeaderView];
    //[self setupBlurView];
    [self setupDataSource];
    [self setupTimeline];
    [self.dataSource registerReusableViewsWithCollectionView:self.collectionView];
    
    [self.view layoutIfNeeded];
    
    UIEdgeInsets insets = self.collectionView.contentInset;
    insets.top = self.headerView.frame.size.height;
    self.collectionView.contentInset = insets;
}

- (void) setupHeaderView
{
    self.headerView = [[ADCoverHeaderView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.headerView];
    [self.headerView alignLeading:@"0" trailing:@"0" toView:self.view];
    [self.headerView constrainTopSpaceToView:(UIView *)self.topLayoutGuide predicate:@"0"];
    [self.headerView constrainHeight:@"300"];
    [self.headerView configureWithData:self.viewModel];
    [self.view insertSubview:self.headerView belowSubview:self.collectionView];
}

- (void) setupBlurView
{
    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    self.blurredView =
    [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.view addSubview:self.blurredView];
//    [self.blurredView alignToView:self.view];
    [self.blurredView constrainWidthToView:self.view predicate:@""];
    [self.blurredView constrainHeightToView:self.view predicate:@""];
    [self.view insertSubview:self.blurredView aboveSubview:self.headerView];
    self.blurredView.hidden = YES;
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
    self.selectedModel = viewModel;
    ADAlbumViewController *detailController = [[ADAlbumViewController alloc] initWithAlbumViewModel:viewModel];
    [self.navigationController pushViewController:detailController animated:YES];
}

/*- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
   /* [super scrollViewDidScroll:scrollView];
    NSLog(@"Content offset = %@",NSStringFromCGPoint(scrollView.contentOffset));
    if (scrollView.contentOffset.y < 0) {
        [self.blurredView setFrameOrigin:CGPointMake(0.0,fabs(scrollView.contentOffset.y))];
    }
    NSLog(@"Blur view = %@",self.blurredView);
    //self.blurredView.hidden  = !(scrollView.contentOffset.y - 80 > -scrollView.contentInset.top);
}*/

#pragma mark ADTransitionProtocol

- (UIView *) transitionFromViewReverse:(BOOL) reverse
{
    if (reverse) {
        return [self.headerView snapshot];
    } else {
        ADAlbumCell *cell = [self selectedCell];
        return [cell snapshot];
    }
}

- (ADAlbumCell *) selectedCell
{
    NSIndexPath *selectedIndexPath = [[self.dataSource indexPathsForItem:self.selectedModel] firstObject];
    ADAlbumCell *cell = (ADAlbumCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    return cell;
}

- (CGRect) transitionToViewFrameReverse:(BOOL) reverse
{
    if (reverse) {
        ADAlbumCell *cell = [self selectedCell];
        return [cell.snapshot frame];
    } else {
        return [self.headerView snapshot].frame;
    }
}

@end
