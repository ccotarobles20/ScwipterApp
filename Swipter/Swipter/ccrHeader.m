//
//  ccrHeader.m
//  Swipter
//
//  Created by Carl Cota-Robles on 3/16/14.
//  Copyright (c) 2014 Carl Cota-Robles. All rights reserved.
//

#import "ccrHeader.h"

@implementation ccrHeader

@synthesize text;
@synthesize writingText;
@synthesize addScreenplayButton;
@synthesize returnButton;

- (id)initWithMode:(NSInteger)mode
{
    self = [super init];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:(72/255.0) green:(172/255.0) blue:(234/255.0) alpha:0.6];
        self.mode = mode;
        self.userInteractionEnabled = YES;
        if (mode == MAIN_SCREEN_MODE) {
            [self mainScreenHeader];
        }
        else {
            [self writingHeader];
        }
    }
    return self;
}

-(void)mainScreenHeader {
    text = [[UILabel alloc] init];
    text.text = @"SCWIPTER SCREENWRITING";
    text.textAlignment = NSTextAlignmentCenter;
    text.backgroundColor = [UIColor clearColor];
    [self addSubview:text];
    
    addScreenplayButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self addSubview:addScreenplayButton];
    [addScreenplayButton setTintColor:[UIColor blackColor]];
    
}

-(void)writingHeader {
    writingText = [[ccrTextItem alloc] initWithText:@"NEW SCREENPLAY" andFrame:CGRectMake(0, 0, 0, 0)];
    writingText.textAlignment = NSTextAlignmentCenter;
    writingText.backgroundColor = [UIColor clearColor];
    [self addSubview:writingText];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [returnButton setTitle:@"BACK" forState:UIControlStateNormal];
    [returnButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:returnButton];
}

-(void)initializeFrames {
    if (self.mode == MAIN_SCREEN_MODE) {
        self.frame = CGRectMake(self.superview.frame.origin.x, self.superview.frame.origin.y, self.superview.frame.size.width, 50);
        text.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+10, self.frame.size.width, self.frame.size.height-10);
        addScreenplayButton.frame = CGRectMake(self.superview.frame.size.width-40, self.superview.frame.origin.y+5, 40, 50);
    }
    else if (self.mode == WRITING_MODE) {
        self.frame = CGRectMake(self.superview.frame.origin.x, self.superview.frame.origin.y, self.superview.frame.size.width, 50);
        writingText.frame = CGRectMake(self.frame.origin.x+70, self.frame.origin.y+10, self.frame.size.width-140, self.frame.size.height-10);
        returnButton.frame = CGRectMake(0, 10, 60, 40);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
