//
//  KCClassStatViewController.m
//  kcclass-stat-ios
//
//  Created by Marko Novak on 10/28/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import "KCClassStatViewController.h"
#import "Incident.h"

@implementation KCClassStatViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSDate *)stringToDate:(NSString *)strDate
{
    NSTimeInterval _interval=[strDate doubleValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    return date;
}

- (void)getIncidentsFromServer:(NSString *)incidentStatus
{
    NSString *urlString=@"http://kcclass-stat-backend.cfapps.io/mobile/incidents/";
    urlString = [urlString stringByAppendingString:incidentStatus];
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
             NSMutableArray *jsonIncidents = [responseDict valueForKey:@"incidents"];
             NSMutableArray *incidentsArray = [[NSMutableArray alloc] initWithCapacity:40];
             for (NSDictionary* jsonIncident in jsonIncidents) {                
                 NSString* id = [jsonIncident valueForKey:@"id"];
                 NSString* name = [jsonIncident valueForKey:@"name"];
                 NSString* currentStatus = [jsonIncident valueForKey:@"current_status"];
                 NSString* strDateFrom = [jsonIncident valueForKey:@"date_from"];
                 NSDate* dateFrom = [self stringToDate:strDateFrom];
                 NSString* strLastChange = [jsonIncident valueForKey:@"last_change"];
                 NSDate* lastChange = [self stringToDate:strLastChange];
                 
                 Incident *incident = [[Incident alloc] init];
                 incident.incidentId = id;
                 incident.name = name;
                 incident.currentStatus = currentStatus;
                 incident.dateFrom = dateFrom;
                 incident.lastChange = lastChange;
                 [incidentsArray addObject:incident];
             }
             IncidentsDisplayViewController *incidentsDisplayView = [[IncidentsDisplayViewController alloc] initWithNibName: @"IncidentsDisplayViewController" bundle:[NSBundle mainBundle ]];
             incidentsDisplayView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
             incidentsDisplayView.incidentsArray = incidentsArray;
             [self presentModalViewController:incidentsDisplayView animated:YES];
         }
         else if ([data length] == 0 && error == nil) {
             NSLog(@"No data received!");
         } 
         else if (error != nil) {
             NSLog(@"Error when retrieving data from the server: %@", [error localizedDescription]);
         }
     }];
}

- (IBAction) openPendingIncidentsView {
    [self getIncidentsFromServer: @"pending"];
}

- (IBAction) openClosedIncidentsView {
    [self getIncidentsFromServer: @"closed"];
}


@end
