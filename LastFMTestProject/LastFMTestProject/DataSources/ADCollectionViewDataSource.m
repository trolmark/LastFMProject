//
//  ADCollectionViewDataSource.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADCollectionViewDataSource.h"
#import "ADCollectionViewMetrics.h"

@interface ADCollectionViewDataSource()

@property (nonatomic, copy) NSString *defaultCellIdentifier;
@property (nonatomic, strong) ADLayoutMetrics *layoutMetrics;

@end

@implementation ADCollectionViewDataSource

- (instancetype)initWithItems:(NSArray *)anItems
               cellIdentifier:(NSString *)aCellIdentifier
           configureCellBlock:(CellConfigureBlock)aConfigureCellBlock
{
    ADLayoutMetrics *layout = [[ADLayoutMetrics alloc] init];
    ADCellLayoutMetrics *cellMetrics = [[ADCellLayoutMetrics alloc] initWithClass:NSClassFromString(aCellIdentifier)
                                                                   cellIdentifier:aCellIdentifier useNib:NO];
    layout.cellMetrics = @[cellMetrics];
    self = [self initWithLayoutMetrics:layout configureCellBlock:aConfigureCellBlock];
    [self setItems:anItems];
    
    return self;
}

- (instancetype) initWithLayoutMetrics:(ADLayoutMetrics *) layoutMetrics
                    configureCellBlock:(CellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.layoutMetrics = layoutMetrics;
    self.configureCellBlock = [aConfigureCellBlock copy];
    
    return self;
}

- (void)registerReusableViewsWithCollectionView:(UICollectionView *)collectionView
{
    [self.layoutMetrics registerWithCollectionView:collectionView];
}

- (NSString *) cellIdentifierForIndexPath:(NSIndexPath *)path
{
    // By default, take first object. Can be overloaded in subclasses
    
    ADCellLayoutMetrics *cellMetrics = [[self.layoutMetrics cellMetrics] firstObject];
    return cellMetrics.cellIdentifier;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self countOfItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
                                  [self cellIdentifierForIndexPath:indexPath] forIndexPath:indexPath];
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, item);
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ADSupplementaryLayoutMetrics *metrics = [[self layoutMetrics] headerForSection:indexPath.section];
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:metrics.reuseIdentifier forIndexPath:indexPath];
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ADSupplementaryLayoutMetrics *metrics = [[self layoutMetrics] footerForSection:indexPath.section];
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:metrics.reuseIdentifier forIndexPath:indexPath];
    }
    
    if (self.configureSupplementaryBlock) {
        self.configureSupplementaryBlock(view,kind,indexPath);
    }
    return view;
}


@end
