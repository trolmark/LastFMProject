//
//  ADArtistDetailViewController.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtistDetailViewController.h"
#import "ADViewModels.h"
#import "ADTimeline.h"
#import "ADFeedSubclasses.h"

@interface ADArtistDetailViewController ()

@property (nonatomic, strong) ADArtistViewModel *viewModel;
@property (nonatomic, strong) ADTimeline *feed;

@end

@implementation ADArtistDetailViewController

- (instancetype) initWithArtistViewModel:(ADArtistViewModel *) viewModel {
    self = [super init];
    if (!self) { return nil; }
    
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

- (void) setupDataSource {
    
}

- (void) setupCollectionView {
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
        
    } failure:nil];
}

#pragma mark - UICollectionViewProtocol

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
