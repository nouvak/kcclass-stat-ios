//
//  AlarmsDisplayViewController.m
//  kcclass-stat-ios
//
//  Created by Marko Novak on 11/6/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import "AlarmsDisplayViewController.h"
#import "Alarm.h"

@implementation AlarmsDisplayViewController

@synthesize alarmsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)closeView {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [alarmsArray count];
}

- (NSString *)getStatusDescription: (NSString *)statusCode 
{
    if ([statusCode isEqualToString:@"crit"]) {
        return @"critical";
    }
    else if ([statusCode isEqualToString:@"warn"]) {
        return @"warning";
    }
    else if ([statusCode isEqualToString:@"ok"]) {
        return @"ok";
    }
    else {
        return @"UNDEFINED";
    }
}

- (UIColor *)getBackgroundColorFromStatus: (NSString *)statusCode 
{
    if ([statusCode isEqualToString:@"crit"]) {
        return [UIColor redColor];
    }
    else if ([statusCode isEqualToString:@"warn"]) {
        return [UIColor yellowColor];
    }
    else if ([statusCode isEqualToString:@"ok"]) {
        return [UIColor greenColor];
    }
    else {
        return [UIColor whiteColor];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *alarmsTableIdentifier = @"AlarmsTableCell";
    
    AlarmsTableCell *cell = (AlarmsTableCell *)[tableView dequeueReusableCellWithIdentifier: alarmsTableIdentifier];
    if (cell == nil) 
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AlarmsTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    } 
    Alarm *alarm = [alarmsArray objectAtIndex: indexPath.row];
    cell.nameLabel.text = alarm.name;
    cell.contentView.backgroundColor = [self getBackgroundColorFromStatus: alarm.status];
    cell.statusLabel.text = [self getStatusDescription: alarm.status];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy HH:mm:ss"];
    cell.dateLabel.text = [formatter stringFromDate:alarm.date];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}


@end
