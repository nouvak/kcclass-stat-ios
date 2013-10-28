//
//  KCClassStatViewController.m
//  kcclass-stat-ios
//
//  Created by Marko Novak on 10/28/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import "KCClassStatViewController.h"

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

- (IBAction) openPendingIncidentsView {    
    IncidentsDisplayViewController *oView = [[IncidentsDisplayViewController alloc] initWithNibName: @"IncidentsDisplayViewController" bundle:[NSBundle mainBundle]];
    oView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:oView animated:YES];
}

- (IBAction) openClosedIncidentsView {
    IncidentsDisplayViewController *oView = [[IncidentsDisplayViewController alloc] initWithNibName: @"IncidentsDisplayViewController" bundle:[NSBundle mainBundle]];
    oView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:oView animated:YES];
}



@end
