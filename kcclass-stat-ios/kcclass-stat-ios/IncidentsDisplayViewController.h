//
//  IncidentsDisplayViewController.h
//  kcclass-stat-ios
//
//  Created by Marko Novak on 10/28/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncidentsTableCell.h"

@interface IncidentsDisplayViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *incidentsArray;
}

@property(nonatomic, retain) NSMutableArray *incidentsArray;
@end
