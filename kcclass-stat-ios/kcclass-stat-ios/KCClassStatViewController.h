//
//  KCClassStatViewController.h
//  kcclass-stat-ios
//
//  Created by Marko Novak on 10/28/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncidentsDisplayViewController.h"

@interface KCClassStatViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

- (IBAction)openPendingIncidentsView;
- (IBAction)openClosedIncidentsView;

@end
