//
//  ccrAppDelegate.h
//  Swipter
//
//  Created by Carl Cota-Robles on 2/13/14.
//  Copyright (c) 2014 Carl Cota-Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccrMainViewController.h"

@class ccrViewController;

@interface ccrAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableArray *screenplays;
@property (strong, nonatomic) UINavigationController *navigator;
@property (strong, nonatomic) ccrViewController *viewController;
@property (strong, nonatomic) ccrMainViewController *mainViewController;

@end
