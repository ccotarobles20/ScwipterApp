//
//  ccrViewController.m
//  Swipter
//
//  Created by Carl Cota-Robles on 2/13/14.
//  Copyright (c) 2014 Carl Cota-Robles. All rights reserved.
//

#import "ccrViewController.h"

@interface ccrViewController ()

@end

@implementation ccrViewController

@synthesize headTextBox;
@synthesize scroller;
@synthesize currentTextType;
@synthesize textTypeMenu;
@synthesize currentTextBox;
@synthesize nextLineButton;
@synthesize header;

@synthesize smoothBlue;

// For touch events
@synthesize lastTouchX;
@synthesize originalTouchX;
@synthesize currentTextBoxX;
@synthesize beginTextBoxDragX;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // Initialize global variables:
    textTypeMenu = [NSMutableArray array];
    smoothBlue = [UIColor colorWithRed:(72/255.0) green:(234/255.0) blue:(234/255.0) alpha:0.6];

    //TODO: Circular swipe, if you swipe in a circle then alternates down the text boxes.
    
    // PAN/DRAG GESTURE RECOGNIZER
    UIPanGestureRecognizer *dragGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)];
    [dragGesture setMaximumNumberOfTouches:1];
    [dragGesture setMinimumNumberOfTouches:1];
    [self.view addGestureRecognizer:dragGesture];
    
    header = [[ccrHeader alloc] initWithMode:WRITING_MODE];
    [header.returnButton addTarget:self action:@selector(moveToMainView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:header];    
    
    // SCROLLVIEW SETUP
    // DISPLAY ALL SCREENPLAY TEXT INSIDE SCROLLER
    scroller = [[UIScrollView alloc] init];
    [scroller setContentSize:CGSizeMake(self.view.frame.size.width, 1000)];
    [self.view addSubview:scroller];
    
    // CREATE THE INITIAL TEXT BOX
    currentTextBox = [[ccrTextItem alloc] initWithText:@"" andFrame:CGRectMake(5, 5, scroller.frame.size.width-10, TEXTBOX_HEIGHT)];
    currentTextBox.backgroundColor = smoothBlue;
    [currentTextBox setDelegate:self];
    [currentTextBox becomeFirstResponder];
    [scroller addSubview:currentTextBox];
    currentTextBox.prev = nil;
    currentTextBox.next = nil;
    headTextBox = currentTextBox;
    
    // CREATE THE BUTTON MENU
    // Allows user to change the type of text in CurrentTextBox
    currentTextType = [[ccrMenuButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 140, 30) andString:@"NEW ACT"];
    [currentTextType addTarget:self action:@selector(revealTextTypeMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:currentTextType];
    
    // CREATE THE NEW LINE BUTTON
    nextLineButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nextLineButton setTitle:@"NEXT" forState:UIControlStateNormal];
    [nextLineButton setBackgroundColor:[UIColor orangeColor]];
    [nextLineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:nextLineButton];
    [nextLineButton addTarget:self action:@selector(createNewTextBox) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void) viewDidAppear:(BOOL)animated {
    
    [currentTextBox becomeFirstResponder];
    [header initializeFrames];
    
    //NSInteger keyboardHeight;
    //keyboardHeight = [UIKeyboardFrameBeginUserInfoKey integerValue];
    //NSLog(@"HEIGHT %ld ", (long)keyboardHeight);
    
    //NSInteger keyboardHeight2;
    //keyboardHeight2 = [UIKeyboardFrameEndUserInfoKey integerValue];
    //NSLog(@"HEIGHT 2 %ld ", (long)keyboardHeight2);

    
    // Edit the frames of all important elements.
    [scroller setFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-300)];
    [headTextBox setFrame:CGRectMake(5, 5, scroller.frame.size.width-10, TEXTBOX_HEIGHT)];
    [headTextBox editTextHeightByOffset:0 andDynamicChecking:YES];
    [currentTextType setFrame:CGRectMake(0, self.view.frame.size.height-250, 140, 30)];
    [nextLineButton setFrame:CGRectMake(self.view.frame.size.width-100, self.view.frame.size.height-250, 100, 30)];
}

-(void)moveToMainView {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)swipeRight {
    NSString *newType = [currentTextType swipeGoingRight:YES];
    [currentTextBox changeTextType:newType];
}

-(void)drag:(UIPanGestureRecognizer*)gesture {
    
    // RECORD THE X COORDINATE OF TOUCH AND THE X-COORDINATE OF THE CURRENTTEXTBOX
    CGPoint touchPoint = [gesture locationInView:Nil];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self beginDrag:touchPoint];
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self moveDrag:touchPoint];
    }
    else {
        [self endDrag:touchPoint];
    }
}

-(void)beginDrag:(CGPoint)touchPoint {
    
    // RECORD THE X COORDINATE OF TOUCH AND THE X-COORDINATE OF THE CURRENTTEXTBOX
    lastTouchX = touchPoint.x;
    originalTouchX = lastTouchX;
    
    beginTextBoxDragX = currentTextBox.frame.origin.x;
    
    currentTextBoxX = currentTextBox.frame.origin.x;
}

-(void)endDrag:(CGPoint)touchPoint {
    
    // IF THE X COORDINATE RECORDED IS LESS THAN SOME VALUE, CALL REMOVE ON CURRENT TEXT BOX AND
    // SET CURRENT TEXT BOX TO NEXT.
    
    if (((currentTextBoxX-beginTextBoxDragX) < -80) && (![currentTextBox isEqual:headTextBox])) {
        ccrTextItem *temp = currentTextBox;
        [currentTextBox.next becomeFirstResponder];
        
        [temp remove];
    }
    else {
        [currentTextBox setFrame:CGRectMake(beginTextBoxDragX, currentTextBox.frame.origin.y, currentTextBox.frame.size.width, currentTextBox.frame.size.height)];
        [currentTextBox setBackgroundColor:[UIColor colorWithRed:(72/255.0) green:(234/255.0) blue:(234/255.0) alpha:0.6]];
        
        if ([currentTextBox isEqual:headTextBox]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SORRY!" message:@"You can't delete the first text box until I become smarter." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    
    if (originalTouchX < (touchPoint.x-80)) {
        [self swipeRight];
    }
}

-(void)moveDrag:(CGPoint)touchPoint {
    
    // CALCULATE THE DIFFERENCE BETWEEN THE X COORDINATE OF TOUCH AND RECORDED ONE'S LAST VALUE.
    // UPDATE THE RECORDED ONE TO CURRENT X COORDINATE
    // OFFSET TEXTBOX BY DIFFERENCE THAT WAS CALCULATED
    
    NSInteger newTouch = touchPoint.x;
    NSInteger touchDiff = newTouch-lastTouchX;
    
    touchDiff = (touchDiff/2); // Slow down dragging
    
    lastTouchX = newTouch;
    
    currentTextBoxX = currentTextBox.frame.origin.x + touchDiff;
    
    if (currentTextBoxX > beginTextBoxDragX) {
        currentTextBoxX -= touchDiff;
        return;
    }
    
    [currentTextBox setFrame:CGRectMake(currentTextBoxX, currentTextBox.frame.origin.y, currentTextBox.frame.size.width, currentTextBox.frame.size.height)];
    
    NSInteger change = beginTextBoxDragX - currentTextBoxX;
    
    [currentTextBox setBackgroundColor:[UIColor colorWithRed:((72+change*4)/255.0) green:((234-change*3)/255.0) blue:((234-change*3)/255.0) alpha:0.6]];
}

-(void)createNewTextBox {
    [self hideTextTypeMenu:currentTextType];
    
    ccrTextItem *item;
    
    [currentTextBox getReadyForNext];
    
    item = [[ccrTextItem alloc] initWithText:@"" andFrame:CGRectMake(5, currentTextBox.frame.origin.y+currentTextBox.frame.size.height+currentTextBox.bottomAlign, self.view.frame.size.width-10, TEXTBOX_HEIGHT)];
    
    item.backgroundColor = [UIColor colorWithRed:(72/255.0) green:(234/255.0) blue:(234/255.0) alpha:0.6];
    [item setDelegate:self];
    ccrTextItem *temp = currentTextBox;
    [currentTextBox setNextItem:item]; // This also sets currentTextBox to item by virtue of giving item firstResponder status.
    [currentTextType setName:[temp nextName]];
    [currentTextBox changeTextType:currentTextType.name];
    [currentTextBox editTextHeightByOffset:currentTextBox.frame.size.height+temp.bottomAlign andDynamicChecking:NO];
}

-(void)raiseKeyboard {
    [self hideTextTypeMenu:currentTextType];
    [UIView beginAnimations:@"Moving Stuff Up" context:nil];
    [UIView setAnimationDuration:0.2];
    [currentTextType setFrame:CGRectMake(currentTextType.frame.origin.x, currentTextType.frame.origin.y-220, currentTextType.frame.size.width, currentTextType.frame.size.height)];
    [nextLineButton setFrame:CGRectMake(nextLineButton.frame.origin.x, nextLineButton.frame.origin.y-220, nextLineButton.frame.size.width, nextLineButton.frame.size.height)];
    [scroller setFrame:CGRectMake(scroller.frame.origin.x, scroller.frame.origin.y, scroller.frame.size.width, scroller.frame.size.height-220)];
    [UIView commitAnimations];
}

-(void)lowerKeyboard {
    [currentTextType setFrame:CGRectMake(currentTextType.frame.origin.x, currentTextType.frame.origin.y+220, currentTextType.frame.size.width, currentTextType.frame.size.height)];
    [nextLineButton setFrame:CGRectMake(nextLineButton.frame.origin.x, nextLineButton.frame.origin.y+220, nextLineButton.frame.size.width, nextLineButton.frame.size.height)];
    [scroller setFrame:CGRectMake(scroller.frame.origin.x, scroller.frame.origin.y, scroller.frame.size.width, scroller.frame.size.height+220)];
}

-(void)revealTextTypeMenu:(ccrMenuButton*)button {
    int change = button.frame.size.height;
    [button removeTarget:self action:@selector(revealTextTypeMenu:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(hideTextTypeMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i=0;i<6;i++) {
        if (i==button.number) {
            continue;
        }
        ccrMenuButton *newButton = [[ccrMenuButton alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y-change, button.frame.size.width, button.frame.size.height) andString:[button encode:i]];
        [newButton addTarget:self action:@selector(hideTextTypeMenu:) forControlEvents:UIControlEventTouchUpInside];
        [textTypeMenu addObject:newButton];
        [self.view addSubview:newButton];
        
        change += button.frame.size.height;
    }
}

-(void)hideTextTypeMenu:(ccrMenuButton*)button {
    BOOL changed = true;
    [currentTextType removeTarget:self action:@selector(hideTextTypeMenu:) forControlEvents:UIControlEventTouchUpInside];
    [currentTextType addTarget:self action:@selector(revealTextTypeMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([currentTextType.name isEqualToString:[[button titleLabel] text]]) {
        changed = false;
    }
    
    [currentTextType setName:[[button titleLabel] text]];
    
    if (changed) {
        [currentTextBox changeTextType:currentTextType.name];
    }
    for (int i=0; i<textTypeMenu.count; i++) {
        [textTypeMenu[i] removeFromSuperview];
    }
    textTypeMenu = [NSMutableArray array];
}


#pragma mark UITextFieldDelagate
-(void)textViewDidBeginEditing:(UITextView *)textView {
    [textView setBackgroundColor:[UIColor colorWithRed:(72/255.0) green:(234/255.0) blue:(234/255.0) alpha:0.6]];
    [self raiseKeyboard];
    currentTextBox = textView;
    [currentTextBox specialSizeToFit];
    [currentTextType setName:currentTextBox.nameOfType];
}

#pragma mark UITextFieldDelagate
-(void)textViewDidEndEditing:(UITextView *)textView {
    ccrTextItem *textItem = (ccrTextItem*)textView;
    [textItem smartText];
    [textItem resignFirstResponder];
    [textItem setBackgroundColor:[UIColor whiteColor]];
    if (textItem.next != nil) {
        [textItem editTextHeightByOffset:((textItem.frame.origin.y+textItem.frame.size.height+textItem.bottomAlign)-textItem.next.frame.origin.y) andDynamicChecking:NO];
    }
    [self lowerKeyboard];
}

#pragma mark UITextFieldDelagate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)newText {
        
    // Adjust the height of the text box dynamically.
    textView.text = [NSString stringWithFormat:@"%@H", textView.text];
    NSInteger oldHeight = textView.frame.size.height;
    NSInteger oldWidth = textView.frame.size.width;
    [textView sizeToFit];
    [textView setFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y, oldWidth, textView.frame.size.height)];
    
    // TODO: New height offset to be used in adjusting the height of next node and so on.
    NSInteger newHeightOffset = textView.frame.size.height-oldHeight;
    
    if (newHeightOffset != 0) {
        [(ccrTextItem*) textView editTextHeightByOffset:newHeightOffset andDynamicChecking:NO];
    }
    
    textView.text = [textView.text substringToIndex:textView.text.length-1];
    
    if ([newText isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [textView setBackgroundColor:[UIColor colorWithRed:(72/255.0) green:(234/255.0) blue:(234/255.0) alpha:0.6]];
        return NO;
    }
    currentTextBox.text = textView.text;
    return YES;
}


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    // Need to adjust this to take into account keyboard-size for when the view is rotated.
    [header initializeFrames];
    NSInteger oldHeight = headTextBox.frame.size.height;
    [scroller setFrame:CGRectMake(scroller.frame.origin.x, scroller.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-100)];
    [headTextBox specialSizeToFit];
    NSInteger newHeight = headTextBox.frame.size.height;
    [headTextBox editTextHeightByOffset:newHeight-oldHeight andDynamicChecking:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
