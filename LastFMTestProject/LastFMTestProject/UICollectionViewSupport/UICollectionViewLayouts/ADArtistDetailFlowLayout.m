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

    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    return self;
}


- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = [self updatedItemSize];
}

- (CGSize) updatedItemSize {
    return CGSizeMake(self.collectionView.bounds.size.width, 80);
}


@end
