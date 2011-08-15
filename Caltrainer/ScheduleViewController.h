//
//  ScheduleViewController.h
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/12/11.
//  Copyright 2011 Little Big Things, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    UIScrollView *timetable;
    
    BOOL southbound;
    BOOL weekday;
    
    UISegmentedControl *dayControl;
    UISegmentedControl *directionControl;
}

- (IBAction)showInfo:(id)sender;
- (void)setValues;
- (void)setDay;
- (void)display;
- (void)reset;

@property BOOL southbound;
@property BOOL weekday;

@property (nonatomic, retain) IBOutlet UISegmentedControl *dayControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl *directionControl;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIScrollView *timetable;
- (int)heightForStation:(NSString *)stationName;

@end
