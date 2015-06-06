//
//  ADAlbumDetailFlowLayout.m
//  LastFMTestProject
//
//  Created by Andrew on 6/6/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAlbumDetailFlowLayout.h"

@implementation ADAlbumDetailFlowLayout

-(instancetype)init {
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(145, 44);
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    return self;
}

@end
