//
//  ADCollectionViewDataSource.h
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADBaseDataSource.h"
#import "Types.h"

@class ADLayoutMetrics;
@interface ADCollectionViewDataSource : ADBaseDataSource<UICollectionViewDataSource>


- (instancetype) initWithItems:(NSArray *)anItems
                cellIdentifier:(NSString *)aCellIdentifier
            configureCellBlock:(CellConfigureBlock)aConfigureCellBlock;

#pragma mark customize collection view ,ethods

- (NSString *) cellIdentifierForIndexPath:(NSIndexPath *)path;
- (void)registerReusableViewsWithCollectionView:(UICollectionView *)collectionView;

@end
