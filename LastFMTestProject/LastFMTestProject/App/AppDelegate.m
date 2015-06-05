//
//  AppDelegate.m
//  LastFMTestProject
//
//  Created by Andrew on 6/2/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "AppDelegate.h"
#import "ADArtistListViewController.h"
#import "ADArtistListFlowLayout.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ADArtistListViewController *artistListController = [[ADArtistListViewController alloc] initWithCollectionViewLayout:[[ADArtistListFlowLayout alloc] init]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:artistListController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
