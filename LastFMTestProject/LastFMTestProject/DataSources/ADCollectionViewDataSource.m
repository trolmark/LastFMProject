//
//  ADCollectionViewDataSource.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADCollectionViewDataSource.h"

@interface ADCollectionViewDataSource()

@property (nonatomic, copy) CellConfigureBlock configureCellBlock;
@property (nonatomic, copy) NSString *defaultCellIdentifier;

@end

@implementation ADCollectionViewDataSource

- (instancetype)initWithItems:(NSArray *)anItems
               cellIdentifier:(NSString *)aCellIdentifier
           configureCellBlock:(CellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)registerReusableViewsWithCollectionView:(UICollectionView *)collectionView
{

}

- (NSString *) cellIdentifierForIndexPath:(NSIndexPath *)path {
    return self.defaultCellIdentifier;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self countOfItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifierForIndexPath:indexPath] forIndexPath:indexPath];
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, item);
    }
    return cell;
}



@end
