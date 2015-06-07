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
#import "CountryItem.h"
#import "Support.h"
#include "REMenu.h"
#import "ADNavMenuItem.h"
#import "ADMenuItem.h"

@interface ADArtistListViewController ()

@property (nonatomic, strong) REMenu *dropdownMenu;
@property (nonatomic, strong) ADNavMenuItem *topMenuItem;

@end

@implementation ADArtistListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self setupDataSource];
    [self setupTimeline];
    [self setupTopMenu];
    
    [self.dataSource registerReusableViewsWithCollectionView:self.collectionView];
    [self loadFeedForDefaultCountry];
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
    self.feed = [[ADTimeline alloc] init];
}

- (void) setupTopMenu
{
    self.topMenuItem = [ADNavMenuItem newMenuItem];
    @weakify(self)
    [self.topMenuItem addAction:^{
        @strongify(self)
        [self toggleDropDownMenu];
    }];
    self.navigationItem.titleView = self.topMenuItem;
    
    NSArray *menuItems = [[[self.countries.rac_sequence
        map:^CountryItem *(NSString *value) {
            return [[CountryItem alloc] initWithName:value];
        }] map:^REMenuItem *(CountryItem *value) {
            return [[ADMenuItem alloc] initWithTitle:value.name
                                              action:^(REMenuItem *item) {
            [self updateListWithCountryItem:value];
        }];
    }] array];
    
    self.dropdownMenu = [[REMenu alloc] initWithItems:menuItems];
    self.dropdownMenu.separatorColor = [UIColor whiteColor];
}

- (NSArray *) countries {
    return @[@"France",@"Greece",@"Argentina",@"Spain",@"Ukraine"];
}

- (void) loadFeedForDefaultCountry
{
    NSString *defaultCountry = [[self countries] firstObject];
    CountryItem *defaultItem = [[CountryItem alloc] initWithName:defaultCountry];
    [self updateListWithCountryItem:defaultItem];
}

- (void) updateListWithCountryItem:(CountryItem *) item
{
    [self.topMenuItem setTitle:item.name];
    
    // Update feed with new country
    ADCountryFeedItem *feedItem = [[ADCountryFeedItem alloc] initWithCountry:item.name];
    [self.feed updateFeedItem:feedItem];
    
    [self.dataSource resetContent];
    [self.collectionView reloadData];
    
    // Scroll to top
    [self.collectionView setContentOffset:CGPointMake(-self.collectionView.contentInset.left, -self.collectionView.contentInset.top)];
    
    [self loadNextFeedPage];
}

- (void) toggleDropDownMenu
{
    if (self.dropdownMenu.isOpen) {
        return [self.dropdownMenu close];
    }
    
    [self.dropdownMenu showFromNavigationController:self.navigationController];
}

#pragma mark - UICollectionViewProtocol

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ADArtistViewModel *viewModel = [self.dataSource itemAtIndexPath:indexPath];
    ADArtistDetailViewController *detailController = [[ADArtistDetailViewController alloc] initWithArtistViewModel:viewModel];
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
