//
//  ccrTextItem.m
//  Swipter
//
//  Created by Carl Cota-Robles on 2/13/14.
//  Copyright (c) 2014 Carl Cota-Robles. All rights reserved.
//

#import "ccrTextItem.h"

@implementation ccrTextItem

@synthesize leftAlign;
@synthesize rightAlign;
@synthesize bottomAlign;
@synthesize dramaticFont;
@synthesize next;
@synthesize prev;
@synthesize nextName;
@synthesize nameOfType;

-(id)initWithText:(NSString *)initText andFrame:(CGRect)rect {
    
    initText = [self truncateSpaces:initText];
    self = [super initWithFrame:CGRectMake(rect.origin.x+leftAlign, rect.origin.y, rect.size.width-rightAlign, rect.size.height)];
    
    [self setText:initText];
    dramaticFont = [UIFont fontWithName:@"Courier" size:TEXTBOX_HEIGHT];
    leftAlign = 0;
    rightAlign = 0;
    bottomAlign = 10;
    self.textColor = [UIColor blackColor];
    [self setFont:dramaticFont];
    
    nameOfType = @"NEW ACT";
    [self setActHeading];
    
    [self specialSizeToFit];
    
    return self;
}

// Remove this textView from the SuperView and then re-link the surrounding textviews.
-(void)remove {
    
    [UIView beginAnimations:@"Removal" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(patchLinkedList)];
    
    [self setFrame:CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    [self editTextHeightByOffset:-(self.frame.size.height+bottomAlign) andDynamicChecking:NO];
    
    [UIView commitAnimations];
}

/* Patches up the linked list by removing this element from it
        !!!!!ONLY CALL AFTER THE REMOVE METHOD IS CALLED ABOVE!!!! */
-(void)patchLinkedList {
    [self removeFromSuperview];
    ccrTextItem *before = prev;
    ccrTextItem *after = next;
    prev.next = after;
    next.prev = before;
    
}

-(void)getReadyForNext {
    [self resignFirstResponder];
}

-(void)setNextItem:(ccrTextItem*)nextItem {
    nextItem.prev = self;
    nextItem.next = nil;
    if (next == nil) {
        next = nextItem;
    }
    else {
        ccrTextItem *temp = next;
        next = nextItem;
        nextItem.next = temp;
        
        temp.prev = nextItem;
    }
        
    self.backgroundColor = [UIColor whiteColor];
    [self.superview addSubview:nextItem];
    [nextItem becomeFirstResponder];
}

// IMPORTANT!!!!!
// Below is the code for different types of text items (ie Action, Dialogue, etc)
// First function is clear, which sets everything back to default.  After that, you can change as desired the features of the text type.

-(void)clear {
    leftAlign = -leftAlign;
    rightAlign = -rightAlign;
    bottomAlign = -bottomAlign;
    [self resetAlignments];
    
    
    leftAlign = 0;
    rightAlign = 0;
    bottomAlign = 10;
    nextName = @"ACTION";
    [self resetAlignments];
}

-(void)resetAlignments {
    [self setFrame:CGRectMake(self.frame.origin.x+leftAlign, self.frame.origin.y, self.frame.size.width-leftAlign-rightAlign, self.frame.size.height+bottomAlign)];
    
    [self specialSizeToFit];
}

-(void)setAction {
    // Nothing special needed
}

-(void)setDialogue {
    self.leftAlign = 70;
    self.rightAlign = 70;
    [self resetAlignments];
}

-(void)setCharacter {
    self.rightAlign = 110;
    self.leftAlign = 110;
    self.bottomAlign = 0;
    [self resetAlignments];
    self.text = [self.text uppercaseString];
    nextName = @"DIALOGUE";
    [self setAutocapitalizationType:UITextAutocapitalizationTypeAllCharacters];
}

-(void)setParenthetical {
    self.rightAlign = 90;
    self.leftAlign = 90;
    self.bottomAlign = 0;
    [self resetAlignments];
    [self setText:[[self text] lowercaseString]];
    self.text = [NSString stringWithFormat:@"(%@)", self.text];
    nextName = @"DIALOGUE";
}

-(void)setSceneHeading {
    self.text = [self.text uppercaseString];

}

-(void)setActHeading {
    self.text = [self.text uppercaseString];
    nextName = @"NEW SCENE";
}

-(void)specialSizeToFit {
    // Align all the text perfectly with the code below!
    [self setTextContainerInset:UIEdgeInsetsZero];
    NSInteger oldWidth = self.frame.size.width;
    [self sizeToFit];
    NSInteger newHeight = self.frame.size.height;
    if (self.frame.size.height < TEXTBOX_HEIGHT) {
        newHeight = 20;
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, oldWidth, newHeight)];
}

-(void)editTextHeightByOffset:(NSInteger)offset andDynamicChecking:(Boolean)enabled {
    ccrTextItem *textBox = self;
    
    //Do nothing if the offset passed in is 0.
    if (offset == 0 && !enabled) {
        return;
    }
    
    NSLog(@" HI %f ", textBox.superview.frame.size.width);
    
    while (textBox.next != Nil) {
        CGRect newframe = textBox.next.frame;
        newframe.origin.y = newframe.origin.y+offset;
        textBox.next.frame = newframe;
        textBox = textBox.next;
        if (enabled) {
            [textBox setFrame:CGRectMake(textBox.frame.origin.x, textBox.frame.origin.y, textBox.superview.frame.size.width-textBox.leftAlign-textBox.rightAlign, textBox.frame.size.height)];
            NSInteger oldHeight = textBox.frame.size.height;
            [textBox specialSizeToFit];
            NSInteger newHeight = textBox.frame.size.height;
            if (newHeight != oldHeight) {
                offset += (newHeight-oldHeight);
            }
        }
    }
}

-(void)changeTextType:(NSString *)newType {
    [self clear];
    if ([newType isEqualToString:@"ACTION"]) {
        nameOfType = @"ACTION";
        [self setAction];
    }
    else if ([newType isEqualToString:@"DIALOGUE"]) {
        nameOfType = @"DIALOGUE";
        [self setDialogue];
    }
    else if ([newType isEqualToString:@"CHARACTER"]) {
        nameOfType = @"CHARACTER";
        [self setCharacter];
    }
    else if ([newType isEqualToString:@"NEW SCENE"]) {
        nameOfType = @"NEW SCENE";
        [self setSceneHeading];
    }
    else if ([newType isEqualToString:@"NEW ACT"]) {
        nameOfType = @"NEW ACT";
        [self setActHeading];
    }
    else if ([newType isEqualToString:@"PARENTHETICAL"]) {
        nameOfType = @"PARENTHETICAL";
        [self setParenthetical];
    }
    else {
        NSLog(@"Error with changing type to %@", nameOfType);
    }
}

//Pretty-Printing choosing methods
-(void)smartText {
    self.text = [self truncateSpaces:self.text];
    if ([nameOfType isEqualToString:@"ACTION"]) {
        self.text = [self addPeriod:self.text];
    }
    else if ([nameOfType isEqualToString:@"DIALOGUE"]) {
        self.text = [self addPeriod:self.text];
    }
    else if ([nameOfType isEqualToString:@"CHARACTER"]) {
        self.text = [self.text uppercaseString];
    }
    else if ([nameOfType isEqualToString:@"PARENTHETICAL"]) {
        [self.text lowercaseString];
    }
    else if ([nameOfType isEqualToString:@"NEW SCENE"]) {
        self.text = [self.text uppercaseString];
        self.text = [self formatToSceneHeading:self.text];
    }
    else if ([nameOfType isEqualToString:@"NEW ACT"]) {
        self.text = [self.text uppercaseString];
    }
}

// Pretty-Printing and Smart-Type helper methods below:

-(NSString*)addPeriod:(NSString*)contents {
    if ([contents characterAtIndex:contents.length-1] > 65) {
        contents = [NSString stringWithFormat:@"%@.",contents];
    }
    return contents;
}

-(NSString*)truncateSpaces:(NSString *)contents {
    while ([contents rangeOfString:@"  "].location != NSNotFound) {
        contents = [contents stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    }
    
    return contents;
}

-(NSString*)formatToSceneHeading:(NSString*)text {
    
    NSInteger spaces = 2;
    NSString *newText = @"";
    NSInteger lastIndex = 0;
    
    for (int i=0;i<text.length;i++) {
        if ([text characterAtIndex:i] == ' ') {
            newText = [NSString stringWithFormat:@"%@%@", newText, [text substringWithRange:NSMakeRange(lastIndex, i-lastIndex)]];
            lastIndex = i;
            if ([newText isEqualToString:@"INT"] || [newText isEqualToString:@"EXT"]) {
                newText = [newText stringByAppendingString:@"."];
            }
            
            spaces--;
        }
    }
    
    if (spaces<1 && [newText characterAtIndex:newText.length-1] != '-') {
        newText = [newText stringByAppendingString:@" -"];
    }
    
    newText = [newText stringByAppendingString:[text substringWithRange:NSMakeRange(lastIndex, text.length-lastIndex)]];
    
    return newText;
}


@end
