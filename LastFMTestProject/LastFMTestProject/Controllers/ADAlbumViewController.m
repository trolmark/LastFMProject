//
//  ADAlbumViewController.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADAlbumViewController.h"
#import "ADViewModels.h"

@interface ADAlbumViewController ()

@property (nonatomic, strong) ADAlbumViewModel *viewModel;

@end

@implementation ADAlbumViewController


- (instancetype) initWithAlbumViewModel:(ADAlbumViewModel *) viewModel {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if ([viewModel isKindOfClass:[ADAlbumViewModel class]]) {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}




@end
