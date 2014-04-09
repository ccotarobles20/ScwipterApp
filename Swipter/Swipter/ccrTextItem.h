//
//  ccrTextItem.h
//  Swipter
//
//  Created by Carl Cota-Robles on 2/13/14.
//  Copyright (c) 2014 Carl Cota-Robles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ccrTextItem : UITextView

#define ACTION 0
#define CHARACTER 1
#define DIALOGUE 2
#define PARENTHETICAL 3
#define SCENE 4
#define ACT 5

#define TEXTBOX_HEIGHT 18

@property(nonatomic) NSInteger leftAlign;
@property(nonatomic) NSInteger rightAlign;
@property (nonatomic) NSInteger bottomAlign;
@property (nonatomic) UIFont *dramaticFont;
@property (nonatomic) ccrTextItem *next;
@property (nonatomic) ccrTextItem *prev;
@property (nonatomic) NSString *nextName;
@property (nonatomic) NSString *nameOfType;

-(id)initWithText:(NSString *)initText andFrame:(CGRect)rect;
-(void)editTextHeightByOffset:(NSInteger)offset andDynamicChecking:(Boolean)enabled;

-(NSString*)addPeriod:(NSString*)contents;
-(NSString*)truncateSpaces:(NSString*)contents;

-(void)getReadyForNext;
-(void)setNextItem:(ccrTextItem*)next;

-(void)changeTextType:(NSString*)newType;

-(void)specialSizeToFit;
-(void)smartText;

-(void)remove;

@end
