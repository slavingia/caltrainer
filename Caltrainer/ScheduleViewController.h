//
//  ScheduleViewController.h
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    UIScrollView *timetable;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIScrollView *timetable;
- (int)heightForStation:(NSString *)stationName;
- (int)widthForTime:(NSString *)time;

@end
