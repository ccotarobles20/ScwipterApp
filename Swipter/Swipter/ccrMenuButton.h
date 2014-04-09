//
//  ccrMenuButton.h
//  Swipter
//
//  Created by Carl Cota-Robles on 2/25/14.
//  Copyright (c) 2014 Carl Cota-Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ccrMenuButton : UIButton

@property (nonatomic) NSInteger number;
@property (nonatomic) NSString* name;

-(id)initWithFrame:(CGRect)frame andString:(NSString*)string;
-(NSInteger)decode:(NSString*)text;
-(NSString*)encode:(NSInteger)num;

-(NSString*)swipeGoingRight:(BOOL)goingRight;

@end
