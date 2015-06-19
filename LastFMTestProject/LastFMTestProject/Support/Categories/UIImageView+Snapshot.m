//
//  UIImageView+Snapshot.m
//  LastFMTestProject
//
//  Created by Andrey Denisov on 6/19/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "UIImageView+Snapshot.h"

@implementation UIImageView (Snapshot)

- (UIImageView *) snapshot
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    imageView.contentMode = self.contentMode;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    return imageView;
}

@end
