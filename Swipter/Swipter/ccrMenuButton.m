//
//  ccrMenuButton.m
//  Swipter
//
//  Created by Carl Cota-Robles on 2/25/14.
//  Copyright (c) 2014 Carl Cota-Robles. All rights reserved.
//

#import "ccrMenuButton.h"

@implementation ccrMenuButton

@synthesize name;
@synthesize number;

- (id)initWithFrame:(CGRect)frame andString:(NSString*)string
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        name = string;
        number = [self decode:string];
        [self setTitle:string forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor lightGrayColor]];
        [[self titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    }
    return self;
}

-(void)setName:(NSString *)localName {
    name = localName;
    number = [self decode:localName];
    [self setTitle:localName forState:UIControlStateNormal];
}

-(NSString*)swipeGoingRight:(BOOL)goingRight {
    if (goingRight) {
        number = (number+1)%6;
    }
    else {
        number = (number-1);
        if (number < 0) {
            number = 5;
        }
    }
    name = [self encode:number];
    [self setTitle:name forState:UIControlStateNormal];
    return name;
}


-(NSInteger)decode:(NSString*)text {
    if ([text isEqualToString:@"ACTION"]) {
        return 0;
    }
    else if ([text isEqualToString:@"CHARACTER"]) {
        return 1;
    }
    else if ([text isEqualToString:@"DIALOGUE"]) {
        return 2;
    }
    else if ([text isEqualToString:@"PARENTHETICAL"]) {
        return 3;
    }
    else if ([text isEqualToString:@"NEW SCENE"]) {
        return 4;
    }
    else if ([text isEqualToString:@"NEW ACT"]) {
        return 5;
    }
    
    return 0;
}

-(NSString*)encode:(NSInteger)num {
    switch (num) {
        case 0:
            return @"ACTION";
            break;
        case 1:
            return @"CHARACTER";
            break;
        case 2:
            return @"DIALOGUE";
            break;
        case 3:
            return @"PARENTHETICAL";
            break;
        case 4:
            return @"NEW SCENE";
            break;
        case 5:
            return @"NEW ACT";
            break;
        default:
            break;
    }
    
    return @"ACTION";
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
