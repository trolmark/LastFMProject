//
//  ADAlbumCell.h
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/4/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADDataViewProtocol.h"

@interface ADAlbumCell : UICollectionViewCell <ADDataViewProtocol>

@property (nonatomic,strong,readonly) UIImageView *imageView;

@end
