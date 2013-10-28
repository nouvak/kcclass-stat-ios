//
//  KCClassStatAppDelegate.h
//  kcclass-stat-ios
//
//  Created by Marko Novak on 10/28/13.
//  Copyright (c) 2013 XLAB d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KCClassStatViewController;

@interface KCClassStatAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) KCClassStatViewController *viewController;

@end
