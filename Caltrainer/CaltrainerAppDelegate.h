//
//  CaltrainerAppDelegate.h
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleViewController.h"

@interface CaltrainerAppDelegate : NSObject <UIApplicationDelegate> {
    
    ScheduleViewController *c;
    
}

@property (nonatomic, retain) ScheduleViewController *c;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
