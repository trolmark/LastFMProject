//
//  ViewController.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADArtistListViewController.h"

@interface ADArtistListViewController ()

@end

@implementation ADArtistListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupDataSource];
    [self setupCollectionView];
}

- (void) setupCollectionView {
    self.collectionView.backgroundColor = [UIColor clearColor];
}

- (void) setupDataSource {
    
}


@end
