//
//  ADArtistDetailFlowLayout.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/5/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtistDetailFlowLayout.h"

@implementation ADArtistDetailFlowLayout


-(instancetype)init {
    if (!(self = [super init])) return nil;

    self.minimumInteritemSpacing = 5;
    self.minimumLineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    
    return self;
}


- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = [self updatedItemSize];
}

- (CGSize) updatedItemSize {
    return CGSizeMake(self.collectionView.bounds.size.width - 2*self.minimumLineSpacing, 80);
}

@end
