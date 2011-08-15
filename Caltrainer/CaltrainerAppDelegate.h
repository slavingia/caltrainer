//
//  CaltrainerAppDelegate.h
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/12/11.
//  Copyright 2011 Little Big Things, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleViewController.h"

@interface CaltrainerAppDelegate : NSObject <UIApplicationDelegate> {
    
    UINavigationController *nc;
    ScheduleViewController *c;
    
}

@property (nonatomic, retain) UINavigationController *nc;
@property (nonatomic, retain) ScheduleViewController *c;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
