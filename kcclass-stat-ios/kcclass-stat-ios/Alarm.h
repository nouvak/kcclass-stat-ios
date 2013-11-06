//
//  Alarm.h
//  kcclass-stat-ios
//
//  Created by Marko Novak on 11/6/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alarm : NSObject
{
    NSString *alarmId;
    NSString *name;
    NSString *status;
    NSDate *date;
}

@property(nonatomic, retain) NSString *alarmId;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *status;
@property(nonatomic, retain) NSDate *date;
@end
