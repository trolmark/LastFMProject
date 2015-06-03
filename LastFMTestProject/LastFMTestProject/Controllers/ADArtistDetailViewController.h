//
//  ADArtistDetailViewController.h
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADArtistViewModel;
@interface ADArtistDetailViewController : UICollectionViewController

- (instancetype) initWithArtistViewModel:(ADArtistViewModel *) viewModel;

@end
