//
//  AlarmsDisplayViewController.h
//  kcclass-stat-ios
//
//  Created by Marko Novak on 11/6/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmsTableCell.h"

@interface AlarmsDisplayViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *alarmsArray;
}

@property(nonatomic, retain) NSMutableArray *alarmsArray;
@end
