//
//  AlarmsTableCell.h
//  kcclass-stat-ios
//
//  Created by Marko Novak on 11/6/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmsTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end
