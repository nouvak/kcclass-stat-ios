//
//  IncidentsTableCell.h
//  kcclass-stat-ios
//
//  Created by Marko Novak on 10/28/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncidentsTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *currentStatusLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateFromLabel;
@property (nonatomic, weak) IBOutlet UILabel *lastChangeLabel;

@end
