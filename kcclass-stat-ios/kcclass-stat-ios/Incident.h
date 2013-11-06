//
//  Incident.h
//  kcclass-stat-ios
//
//  Created by Marko Novak on 11/4/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Incident : NSObject
{
    NSString *incidentId;
    NSString *name;
    NSString *currentStatus;
    NSDate *dateFrom;
    NSDate *lastChange;
}

@property(nonatomic, retain) NSString *incidentId;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *currentStatus;
@property(nonatomic, retain) NSDate *dateFrom;
@property(nonatomic, retain) NSDate *lastChange;

@end
