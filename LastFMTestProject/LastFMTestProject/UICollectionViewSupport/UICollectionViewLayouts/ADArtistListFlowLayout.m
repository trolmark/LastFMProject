//
//  ADArtistListFlowLayout.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/5/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtistListFlowLayout.h"

@implementation ADArtistListFlowLayout

-(instancetype)init {
    if (!(self = [super init])) return nil;
    
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = [self updatedItemSize];
}

- (CGSize) updatedItemSize {
    return CGSizeMake(self.collectionView.bounds.size.width - 2*10, 300);
}




@end
