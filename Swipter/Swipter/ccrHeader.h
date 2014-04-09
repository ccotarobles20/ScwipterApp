//
//  ccrHeader.h
//  Swipter
//
//  Created by Carl Cota-Robles on 3/16/14.
//  Copyright (c) 2014 Carl Cota-Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccrTextItem.h"

#define MAIN_SCREEN_MODE 1
#define WRITING_MODE 2

@interface ccrHeader : UIImageView

@property (nonatomic, strong) UILabel *text;
@property (nonatomic, strong) ccrTextItem *writingText;
@property (nonatomic, strong) UIButton *addScreenplayButton;
@property (nonatomic, strong) UIButton *returnButton;
@property (nonatomic) NSInteger mode;

-(id)initWithMode:(NSInteger)mode;
-(void)mainScreenHeader;
-(void)writingHeader;
-(void)initializeFrames;

@end
