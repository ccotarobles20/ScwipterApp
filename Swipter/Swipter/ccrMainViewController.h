//
//  ccrMainViewController.h
//  Swipter
//
//  Created by Carl Cota-Robles on 3/14/14.
//  Copyright (c) 2014 Carl Cota-Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccrViewController.h"
#import "ccrHeader.h"

@interface ccrMainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray *screenplays;
@property (nonatomic) UIColor *lightYellow;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIButton *createScreenplayButton;
@property (nonatomic) ccrHeader *header;

-(void)moveToView;
-(void)createScreenplayFunction;
-(void)updateMain:(NSString*)string atIndex:(NSInteger)index;

@end
