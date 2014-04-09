//
//  ccrViewController.h
//  Swipter
//
//  Created by Carl Cota-Robles on 2/13/14.
//  Copyright (c) 2014 Carl Cota-Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccrMenuButton.h"
#import "ccrTextItem.h"
#import "ccrHeader.h"

@interface ccrViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic) NSInteger globalIndex;

@property (nonatomic, strong) UIViewController *mainViewController;

@property (nonatomic) ccrTextItem *headTextBox;
@property (nonatomic) ccrMenuButton *currentTextType;
@property (nonatomic) UIScrollView *scroller;
@property (nonatomic) NSMutableArray *textTypeMenu;
@property (nonatomic) ccrTextItem *currentTextBox;
@property (nonatomic) UIButton *nextLineButton;
@property (nonatomic) ccrHeader *header;

@property (nonatomic) UIColor *smoothBlue;

// For Touch Events
@property (nonatomic) NSInteger lastTouchX;
@property (nonatomic) NSInteger originalTouchX;
@property (nonatomic) NSInteger currentTextBoxX;
@property (nonatomic) NSInteger beginTextBoxDragX;

-(void)swipeRight;

-(void)drag:(UIPanGestureRecognizer*)gesture;
-(void)touchesBegan:(CGPoint)touchPoint;
-(void)touchesEnded:(CGPoint)touchPoint;
-(void)touchesMoved:(CGPoint)touchPoint;

-(void)raiseKeyboard;
-(void)createNewTextBox;
-(void)lowerKeyboard;

-(void)revealTextTypeMenu:(ccrMenuButton*)button;
-(void)hideTextTypeMenu:(ccrMenuButton*)button;

-(void)moveToMainView;

@end
