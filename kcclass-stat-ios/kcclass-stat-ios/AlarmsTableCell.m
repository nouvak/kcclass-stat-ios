//
//  AlarmsTableCell.m
//  kcclass-stat-ios
//
//  Created by Marko Novak on 11/6/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import "AlarmsTableCell.h"

@implementation AlarmsTableCell

@synthesize statusLabel = _statusLabel;
@synthesize nameLabel = _nameLabel;
@synthesize dateLabel = _dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
