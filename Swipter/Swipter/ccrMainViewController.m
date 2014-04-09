//
//  ccrMainViewController.m
//  Swipter
//
//  Created by Carl Cota-Robles on 3/14/14.
//  Copyright (c) 2014 Carl Cota-Robles. All rights reserved.
//

#import "ccrMainViewController.h"

@interface ccrMainViewController ()

@end

@implementation ccrMainViewController

@synthesize screenplays;
@synthesize lightYellow;
@synthesize tableView;
@synthesize createScreenplayButton;
@synthesize header;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        lightYellow = [UIColor colorWithRed:(251/255.0) green:(250/255.0) blue:(200/255.0) alpha:0.6];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50) style:UITableViewStylePlain];
    [tableView setBackgroundColor:lightYellow];
    [tableView setSeparatorColor:[UIColor blackColor]];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [self.view addSubview:tableView];
    
    header = [[ccrHeader alloc] initWithMode:MAIN_SCREEN_MODE];
    [self.view addSubview:header];
    [header.addScreenplayButton addTarget:self action:@selector(createScreenplayFunction) forControlEvents:UIControlEventTouchUpInside];    
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [tableView setFrame:CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    [header initializeFrames];
}

-(void) viewDidAppear:(BOOL)animated {
    
    [tableView setFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
    
    [header initializeFrames];
    [tableView reloadData];
}

-(void)createScreenplayFunction {
    ccrViewController *view = [[ccrViewController alloc] init];
    [screenplays addObject:view];
    [view setMainViewController:self];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return screenplays.count;
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"TESTING";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Listings";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Listings"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setBackgroundColor:lightYellow];
    }
    NSInteger indexNumber = indexPath.row;
    if (indexNumber < screenplays.count) {
        ccrViewController *entry = [screenplays objectAtIndex:indexNumber];
        cell.textLabel.text = entry.headTextBox.text;
    }
    else {
        cell.textLabel.text = @"Not in data yet";
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger indexNumber = indexPath.row;
    ccrViewController *viewToPush = [screenplays objectAtIndex:indexNumber];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:viewToPush animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
