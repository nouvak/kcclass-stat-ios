//
//  IncidentsDisplayViewController.m
//  kcclass-stat-ios
//
//  Created by Marko Novak on 10/28/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import "IncidentsDisplayViewController.h"
#import "Incident.h"
#import "AlarmsDisplayViewController.h"
#import "Alarm.h"

@implementation IncidentsDisplayViewController

@synthesize incidentsArray;

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
    return [incidentsArray count];
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
    static NSString *incidentsTableIdentifier = @"IncidentsTableCell";
    
    IncidentsTableCell *cell = (IncidentsTableCell *)[tableView dequeueReusableCellWithIdentifier: incidentsTableIdentifier];
    if (cell == nil) 
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"IncidentsTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    } 
    Incident *incident = [incidentsArray objectAtIndex: indexPath.row];
    cell.nameLabel.text = incident.name;
    cell.contentView.backgroundColor = [self getBackgroundColorFromStatus: incident.currentStatus];
    cell.currentStatusLabel.text = [self getStatusDescription: incident.currentStatus];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy HH:mm:ss"];
    cell.dateFromLabel.text = [formatter stringFromDate:incident.dateFrom];
    cell.lastChangeLabel.text = [formatter stringFromDate:incident.lastChange];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (NSDate *)stringToDate:(NSString *)strDate
{
    NSTimeInterval _interval=[strDate doubleValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    return date;
}

- (void)getAlarmsFromServer:(NSString *)incidentId
{
    NSString *urlString=[NSString stringWithFormat:@"http://kcclass-stat-backend.cfapps.io/mobile/incident/%@/alarms", incidentId];
    NSURL *url=[NSURL URLWithString:urlString];
    NSMutableURLRequest *kcRequest = [[NSMutableURLRequest alloc] init];    
    [kcRequest setURL:url];
    [kcRequest setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:kcRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil) {
             NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"Data received: %@", responseString);
             NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             NSMutableArray *jsonAlarms = [responseDict valueForKey:@"alarms"];
             NSMutableArray *alarmsArray = [[NSMutableArray alloc] initWithCapacity:40];
             for (NSDictionary* jsonAlarm in jsonAlarms) {                
                 NSString* id = [jsonAlarm valueForKey:@"id"];
                 NSString* name = [jsonAlarm valueForKey:@"name"];
                 NSString* status = [jsonAlarm valueForKey:@"status"];
                 NSString* strDate = [jsonAlarm valueForKey:@"date"];
                 NSDate* date = [self stringToDate:strDate];
                 
                 Alarm *alarm = [[Alarm alloc] init];
                 alarm.alarmId = id;
                 alarm.name = name;
                 alarm.status = status;
                 alarm.date = date;
                 [alarmsArray addObject:alarm];
             }
             AlarmsDisplayViewController *alarmsDisplayView = [[AlarmsDisplayViewController alloc] initWithNibName: @"AlarmsDisplayViewController" bundle:[NSBundle mainBundle ]];
             alarmsDisplayView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
             alarmsDisplayView.alarmsArray = alarmsArray;
             [self presentModalViewController:alarmsDisplayView animated:YES];
         }
         else if ([data length] == 0 && error == nil) {
             NSLog(@"No data received!");
         } 
         else if (error != nil) {
             NSLog(@"Error when retrieving data from the server: %@", [error localizedDescription]);
         }
     }];
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath 
{
    Incident *incident = [incidentsArray objectAtIndex: indexPath.row];
    [self getAlarmsFromServer:incident.incidentId];
}

@end
