//
//  ScheduleViewController.m
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/12/11.
//  Copyright 2011 Little Big Things, LLC. All rights reserved.
//

#import "AboutViewController.h"
#import "ScheduleViewController.h"
#import "StationName.h"
#import "StationTimes.h"
#import "FlurryAPI.h"

@implementation ScheduleViewController

@synthesize scrollView, timetable, weekday, southbound, dayControl, directionControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Caltrainer";
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.scrollView setScrollsToTop:NO];
    [self.timetable setScrollsToTop:YES];
    
    [self.scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"station_background.png"]]];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setMaximumZoomScale:1.0f]; [self.scrollView setMinimumZoomScale:1.0f];
    [self.timetable setMaximumZoomScale:1.0f]; [self.timetable setMinimumZoomScale:1.0f];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    self.southbound = [defaults boolForKey:@"southbound"];

    [self setDay];
    
    if (weekday) {
        [dayControl setSelectedSegmentIndex:0];
    } else {
        [dayControl setSelectedSegmentIndex:1];
    }

    if (southbound) {
        [directionControl setSelectedSegmentIndex:1];
    } else {
        [directionControl setSelectedSegmentIndex:0];
    }
        
    [self setValues];
    [self display];
    
    [self.dayControl addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    [self.directionControl addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setDay];
    [self setValues];
    [self display];
}

- (void)setDay {
    int day = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]] weekday];
    if (day != 1 && day != 7) {
        weekday = YES;
    } else {
        weekday = NO;
    }
}

- (void)setValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (dayControl.selectedSegmentIndex == 0) {
        self.weekday = YES;
    } else {
        self.weekday = NO;        
    }
    
    if (directionControl.selectedSegmentIndex == 0) {
        self.southbound = NO;
    } else {
        self.southbound = YES;        
    }
    
    [defaults setBool:southbound forKey:@"southbound"];
    [defaults synchronize];
}

- (void)changeValue:(id)sender { 
    if (sender == dayControl) {
        [FlurryAPI logEvent:@"Day changed."];
    } else {
        [FlurryAPI logEvent:@"Direction changed."];
    }

    [self setValues];

    [self reset];
    [self display];
}

- (void)reset {
    for (UIView *view in [timetable subviews]) {
        if (view.tag == 123) {
            [view removeFromSuperview];
        }
    }

    for (UIView *view in [scrollView subviews]) {
        [view removeFromSuperview];
    }
}

- (void)display {
    [FlurryAPI logEvent:@"Showing schedule."];
    
    NSArray *stations = nil;

    //Southbound weekday.
    if (southbound && weekday) {
        stations = [NSArray arrayWithObjects:
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Francisco", @"name", [NSArray arrayWithObjects:@"4:55", @"5:25", @"6:11", @"6:24", @"6:44", @"6:59", @"7:14", @"7:19", @"7:24", @"7:44", @"7:59", @"8:14", @"8:19", @"8:24", @"8:44", @"8:59", @"9:07", @"10:07", @"11:07", @"12:07", @"1:07", @"2:07", @"3:07", @"3:37", @"4:09", @"4:19", @"4:27", @"4:33", @"4:56", @"5:14", @"5:20", @"5:27", @"5:33", @"5:56", @"6:14", @"6:27", @"6:33", @"6:56", @"7:30", @"8:40", @"9:40", @"10:40", @"12:01", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"22nd Street", @"name", [NSArray arrayWithObjects:@"5:00", @"5:30", @"6:16", @"6:29", @"6:49", @"7:04", @"7:19", @"-", @"7:29", @"7:49", @"8:04", @"8:19", @"-", @"8:29", @"8:49", @"9:04", @"9:12", @"10:12", @"11:12", @"12:12", @"1:12", @"2:12", @"3:12", @"-", @"-", @"-", @"4:32", @"-", @"-", @"-", @"-", @"5:32", @"-", @"-", @"-", @"6:32", @"-", @"-", @"7:35", @"8:45", @"9:45", @"10:45", @"12:06", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Bayshore", @"name", [NSArray arrayWithObjects:@"5:05", @"5:35", @"-", @"6:34", @"-", @"-", @"-", @"-", @"7:34", @"-", @"-", @"-", @"-", @"8:34", @"-", @"-", @"9:17", @"10:17", @"11:17", @"12:17", @"1:17", @"2:17", @"3:17", @"-", @"-", @"-", @"4:40", @"-", @"-", @"-", @"-", @"5:40", @"-", @"-", @"-", @"6:40", @"-", @"-", @"7:40", @"8:50", @"9:50", @"10:50", @"12:11", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"So. San Francisco", @"name", [NSArray arrayWithObjects:@"5:11", @"5:41", @"-", @"6:40", @"-", @"-", @"-", @"-", @"7:40", @"-", @"-", @"-", @"-", @"8:40", @"-", @"-", @"9:23", @"10:23", @"11:23", @"12:23", @"1:23", @"2:23", @"3:23", @"-", @"-", @"-", @"4:48", @"-", @"5:08", @"-", @"-", @"5:48", @"-", @"6:08", @"-", @"6:48", @"-", @"7:08", @"7:46", @"8:56", @"9:56", @"10:56", @"12:17", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Bruno", @"name", [NSArray arrayWithObjects:@"5:15", @"5:45", @"-", @"6:44", @"-", @"-", @"-", @"7:33", @"7:44", @"-", @"-", @"-", @"8:33", @"8:44", @"-", @"-", @"9:27", @"10:27", @"11:27", @"12:27", @"1:27", @"2:27", @"3:27", @"3:51", @"-", @"4:33", @"4:52", @"-", @"-", @"-", @"5:34", @"5:52", @"-", @"-", @"-", @"6:52", @"-", @"-", @"7:50", @"9:00", @"10:00", @"11:00", @"12:21", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Millbrae", @"name", [NSArray arrayWithObjects:@"5:19", @"5:49", @"6:29", @"6:48", @"7:01", @"7:17", @"7:32", @"-", @"7:48", @"8:01", @"8:17", @"8:32", @"-", @"8:48", @"9:01", @"9:17", @"9:31", @"10:31", @"11:31", @"12:31", @"1:31", @"2:31", @"3:31", @"3:55", @"4:25", @"-", @"4:56", @"4:49", @"5:14", @"5:30", @"-", @"5:56", @"5:49", @"6:14", @"6:30", @"6:56", @"6:49", @"7:14", @"7:54", @"9:04", @"10:04", @"11:04", @"12:25", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Burlingame", @"name", [NSArray arrayWithObjects:@"5:23", @"5:53", @"6:33", @"6:52", @"-", @"-", @"-", @"7:38", @"7:52", @"-", @"-", @"-", @"8:38", @"8:52", @"-", @"-", @"9:35", @"10:35", @"11:35", @"12:35", @"1:35", @"2:35", @"3:35", @"3:59", @"-", @"4:38", @"5:00", @"-", @"-", @"-", @"5:39", @"6:00", @"-", @"-", @"-", @"7:00", @"-", @"-", @"7:58", @"9:08", @"10:08", @"11:08", @"12:29", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Mateo", @"name", [NSArray arrayWithObjects:@"5:26", @"5:56", @"6:36", @"6:55", @"7:07", @"-", @"-", @"7:42", @"7:55", @"8:07", @"-", @"-", @"8:42", @"8:55", @"9:07", @"-", @"9:38", @"10:38", @"11:38", @"12:38", @"1:38", @"2:38", @"3:38", @"4:02", @"-", @"4:42", @"5:04", @"4:57", @"-", @"-", @"5:43", @"6:04", @"5:57", @"-", @"-", @"7:04", @"6:57", @"-", @"8:01", @"9:11", @"10:11", @"11:11", @"12:32", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Hayward Park", @"name", [NSArray arrayWithObjects:@"5:29", @"5:59", @"-", @"6:58", @"-", @"-", @"-", @"-", @"7:58", @"-", @"-", @"-", @"-", @"8:58", @"-", @"-", @"9:41", @"10:41", @"11:41", @"12:41", @"1:41", @"2:41", @"3:41", @"-", @"-", @"-", @"5:07", @"-", @"-", @"-", @"-", @"6:07", @"-", @"-", @"-", @"7:07", @"-", @"-", @"8:04", @"9:14", @"10:14", @"11:14", @"12:35", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Hillsdale", @"name", [NSArray arrayWithObjects:@"5:32", @"6:02", @"6:40", @"7:01", @"-", @"-", @"7:40", @"7:46", @"8:01", @"-", @"-", @"8:40", @"8:46", @"9:01", @"-", @"-", @"9:44", @"10:44", @"11:44", @"12:44", @"1:44", @"2:44", @"3:44", @"4:06", @"4:33", @"4:47", @"5:11", @"-", @"5:22", @"5:38", @"5:48", @"6:11", @"-", @"6:22", @"6:38", @"7:11", @"-", @"7:22", @"8:07", @"9:17", @"10:17", @"11:17", @"12:38", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Belmont", @"name", [NSArray arrayWithObjects:@"5:35", @"6:05", @"-", @"7:04", @"-", @"-", @"-", @"-", @"8:04", @"-", @"-", @"-", @"-", @"9:04", @"-", @"-", @"9:47", @"10:47", @"11:47", @"12:47", @"1:47", @"2:47", @"3:47", @"4:09", @"-", @"-", @"5:14", @"-", @"-", @"-", @"-", @"6:14", @"-", @"-", @"-", @"7:14", @"-", @"-", @"8:10", @"9:20", @"10:20", @"11:20", @"12:41", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Carlos", @"name", [NSArray arrayWithObjects:@"5:38", @"6:08", @"6:44", @"7:07", @"7:13", @"-", @"-", @"7:50", @"8:07", @"8:13", @"-", @"-", @"8:50", @"9:07", @"9:13", @"-", @"9:50", @"10:50", @"11:50", @"12:50", @"1:50", @"2:50", @"3:50", @"4:12", @"-", @"4:51", @"5:18", @"-", @"-", @"-", @"5:52", @"6:18", @"-", @"-", @"-", @"7:18", @"-", @"-", @"8:13", @"9:23", @"10:23", @"11:23", @"12:44", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Redwood City", @"name", [NSArray arrayWithObjects:@"5:43", @"6:13", @"6:49", @"7:12", @"7:18", @"7:30", @"-", @"-", @"8:12", @"8:18", @"8:30", @"-", @"-", @"9:12", @"9:18", @"9:30", @"9:55", @"10:55", @"11:55", @"12:55", @"1:55", @"2:55", @"3:55", @"4:17", @"-", @"-", @"5:22", @"5:06", @"5:28", @"-", @"-", @"6:22", @"6:06", @"6:28", @"-", @"7:22", @"7:06", @"7:28", @"8:18", @"9:28", @"10:28", @"11:28", @"12:49", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Menlo Park", @"name", [NSArray arrayWithObjects:@"5:48", @"6:18", @"6:54", @"-", @"7:23", @"7:35", @"-", @"7:58", @"-", @"8:23", @"8:35", @"-", @"8:58", @"-", @"9:23", @"9:35", @"10:00", @"11:00", @"12:00", @"1:00", @"2:00", @"3:00", @"4:00", @"4:22", @"-", @"-", @"5:28", @"-", @"5:34", @"-", @"-", @"6:28", @"-", @"6:34", @"-", @"7:28", @"-", @"7:34", @"8:23", @"9:33", @"10:33", @"11:33", @"12:54", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Palo Alto", @"name", [NSArray arrayWithObjects:@"5:51", @"6:21", @"6:57", @"7:18", @"7:26", @"-", @"7:51", @"8:01", @"8:18", @"8:26", @"-", @"8:51", @"9:01", @"9:18", @"9:26", @"-", @"10:03", @"11:03", @"12:03", @"1:03", @"2:03", @"3:03",  @"4:03", @"4:25", @"4:44", @"5:01", @"-", @"5:12", @"5:38", @"5:49", @"6:02", @"-", @"6:12", @"6:38", @"6:49", @"-", @"7:12", @"7:38", @"8:26", @"9:36", @"10:36", @"11:36", @"12:57", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"California Ave", @"name", [NSArray arrayWithObjects:@"5:55", @"6:25", @"7:01", @"-", @"7:30", @"-", @"-", @"-", @"-", @"8:30", @"-", @"-", @"-", @"-", @"9:30", @"-", @"10:07", @"11:07", @"12:07", @"1:07", @"2:07", @"3:07", @"4:07", @"4:29", @"-", @"5:05", @"-", @"-", @"5:42", @"-", @"6:06", @"-", @"-", @"6:42", @"-", @"-", @"-", @"7:42", @"8:30", @"9:40", @"10:40", @"11:40", @"1:01", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Antonio", @"name", [NSArray arrayWithObjects:@"5:59", @"6:29", @"-", @"-", @"7:34", @"-", @"-", @"-", @"-", @"8:34", @"-", @"-", @"-", @"-", @"9:34", @"-", @"10:11", @"11:11", @"12:11", @"1:11", @"2:11", @"3:11", @"4:11", @"4:33", @"-", @"-", @"-", @"-", @"5:46", @"-", @"-", @"-", @"-", @"6:46", @"-", @"-", @"-", @"7:46", @"8:34", @"9:44", @"10:44", @"11:44", @"1:05", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Mountain View", @"name", [NSArray arrayWithObjects:@"6:03", @"6:33", @"7:07", @"-", @"7:38", @"7:44", @"7:58", @"8:09", @"-", @"8:38", @"8:44", @"8:58", @"9:09", @"-", @"9:38", @"9:44", @"10:15", @"11:15", @"12:15", @"1:15", @"2:15", @"3:15", @"4:15", @"4:37", @"4:51", @"5:11", @"5:36", @"-", @"5:50", @"5:56", @"6:12", @"6:36", @"-", @"6:50", @"6:56", @"7:36", @"-", @"7:50", @"8:38", @"9:48", @"10:48", @"11:48", @"1:09", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Sunnyvale", @"name", [NSArray arrayWithObjects:@"6:08", @"6:38", @"-", @"-", @"7:43", @"-", @"-", @"-", @"-", @"8:43", @"-", @"-", @"-", @"-", @"9:43", @"-", @"10:20", @"11:20", @"12:20", @"1:20", @"2:20", @"3:20", @"4:20", @"4:42", @"-", @"5:16", @"-", @"5:21", @"5:55", @"-", @"6:17", @"-", @"6:21", @"6:55", @"-", @"-", @"7:21", @"7:55", @"8:43", @"9:53", @"10:53", @"11:53", @"1:14", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Lawrence", @"name", [NSArray arrayWithObjects:@"6:12", @"6:42", @"7:12", @"-", @"7:49", @"-", @"-", @"8:16", @"-", @"8:49", @"-", @"-", @"9:16", @"-", @"9:49", @"-", @"10:24", @"11:24", @"12:24", @"1:24", @"2:24", @"3:24", @"4:24", @"4:46", @"-", @"-", @"-", @"-", @"6:01", @"-", @"-", @"6:43", @"-", @"7:01", @"-", @"-", @"-", @"7:59", @"8:47", @"9:57", @"10:57", @"11:57", @"1:18", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Santa Clara", @"name", [NSArray arrayWithObjects:@"6:17", @"6:47", @"-", @"7:34", @"7:56", @"-", @"-", @"-", @"8:34", @"8:56", @"-", @"-", @"-", @"9:34", @"9:56", @"-", @"10:29", @"11:29", @"12:29", @"1:29", @"2:29", @"3:29", @"4:29", @"4:51", @"-", @"-", @"5:47", @"-", @"6:08", @"-", @"-", @"6:48", @"-", @"7:08", @"-", @"7:47", @"-", @"8:04", @"8:52", @"10:02", @"11:02", @"12:02", @"1:23", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"College Park", @"name", [NSArray arrayWithObjects:@"-", @"-", @"-", @"-", @"7:59", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"4:32", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Jose", @"name", [NSArray arrayWithObjects:@"6:26", @"6:56", @"7:24", @"7:43", @"8:06", @"7:58", @"8:13", @"8:28", @"8:43", @"9:05", @"8:58", @"9:13", @"9:28", @"9:43", @"10:05", @"9:58", @"10:38", @"11:38", @"12:38", @"1:38", @"2:38", @"3:38", @"4:39", @"5:00", @"5:06", @"5:27", @"5:55", @"5:32", @"6:16", @"6:11", @"6:28", @"6:56", @"6:32", @"7:16", @"7:11", @"7:55", @"7:32", @"8:12", @"9:01", @"10:11", @"11:11", @"12:11", @"1:32", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Tamien", @"name", [NSArray arrayWithObjects:@" ", @"7:03", @" ", @"7:50", @"8:13", @" ", @"8:50", @"9:12", @" ", @"9:50", @"10:12", @" ", @"4:45", @"5:07", @" ", @"5:39", @"6:22", @" ", @"7:02", @"6:39", @"7:23", @" ", @"7:39", @"8:19", @" ", @"10:18", @"11:18", @" ", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Capitol", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"4:52", @"", @"", @"", @"", @"", @"6:29", @"", @"", @"7:09", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Blossom Hill", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"4:58", @"", @"", @"", @"", @"", @"6:35", @"", @"", @"7:15", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Morgan Hill", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"5:11", @"", @"", @"", @"", @"", @"6:48", @"", @"", @"7:28", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Martin", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"5:17", @"", @"", @"", @"", @"", @"6:54", @"", @"", @"7:34", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Gilroy", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"5:30", @"", @"", @"", @"", @"", @"7:07", @"", @"", @"7:47", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                    nil];
    } else if (southbound && !weekday) {
        stations = [NSArray arrayWithObjects:
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Francisco", @"name", [NSArray arrayWithObjects:@"8:15", @"9:15", @"10:15", @"11:15", @"11:59", @"12:15", @"1:15", @"2:15", @"3:15", @"4:15", @"5:15", @"6:15", @"6:59", @"7:15", @"8:15", @"9:15", @"10:15", @"12:01", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"22nd Street", @"name", [NSArray arrayWithObjects:@"8:20", @"9:20", @"10:20", @"11:20", @"-", @"12:20", @"1:20", @"2:20", @"3:20", @"4:20", @"5:20", @"6:20", @"-", @"7:20", @"8:20", @"9:20", @"10:20", @"12:06", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Bayshore", @"name", [NSArray arrayWithObjects:@"8:25", @"9:25", @"10:25", @"11:25", @"-", @"12:25", @"1:25", @"2:25", @"3:25", @"4:25", @"5:25", @"6:25", @"-", @"7:25", @"8:25", @"9:25", @"10:25", @"12:11", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"So. San Francisco", @"name", [NSArray arrayWithObjects:@"8:31", @"9:31", @"10:31", @"11:31", @"-", @"12:31", @"1:31", @"2:31", @"3:31", @"4:31", @"5:31", @"6:31", @"-", @"7:31", @"8:31", @"9:31", @"10:31", @"12:17", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Bruno", @"name", [NSArray arrayWithObjects:@"8:35", @"9:35", @"10:35", @"11:35", @"-", @"12:35", @"1:35", @"2:35", @"3:35", @"4:35", @"5:35", @"6:35", @"-", @"7:35", @"8:35", @"9:35", @"10:35", @"12:21", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Millbrae", @"name", [NSArray arrayWithObjects:@"8:39", @"9:39", @"10:39", @"11:39", @"12:15", @"12:39", @"1:39", @"2:39", @"3:39", @"4:39", @"5:39", @"6:39", @"7:15", @"7:39", @"8:39", @"9:39", @"10:39", @"12:25", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Broadway", @"name", [NSArray arrayWithObjects:@"8:43", @"9:43", @"10:43", @"11:43", @"-", @"12:43", @"1:43", @"2:43", @"3:43", @"4:43", @"5:43", @"6:43", @"-", @"7:43", @"8:43", @"9:43", @"10:43", @"12:29", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Burlingame", @"name", [NSArray arrayWithObjects:@"8:45", @"9:45", @"10:45", @"11:45", @"-", @"12:45", @"1:45", @"2:45", @"3:45", @"4:45", @"5:45", @"6:45", @"-", @"7:45", @"8:45", @"9:45", @"10:45", @"12:31", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Mateo", @"name", [NSArray arrayWithObjects:@"8:49", @"9:49", @"10:49", @"11:49", @"12:21", @"12:49", @"1:49", @"2:49", @"3:49", @"4:49", @"5:49", @"6:49", @"7:21", @"7:49", @"8:49", @"9:49", @"10:49", @"12:35", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Hayward Park", @"name", [NSArray arrayWithObjects:@"8:52", @"9:52", @"10:52", @"11:52", @"-", @"12:52", @"1:52", @"2:52", @"3:52", @"4:52", @"5:52", @"6:52", @"-", @"7:52", @"8:52", @"9:52", @"10:52", @"12:38", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Hillsdale", @"name", [NSArray arrayWithObjects:@"8:55", @"9:55", @"10:55", @"11:55", @"12:25", @"12:55", @"1:55", @"2:55", @"3:55", @"4:55", @"5:55", @"6:55", @"7:25", @"7:55", @"8:55", @"9:55", @"10:55", @"12:41", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Belmont", @"name", [NSArray arrayWithObjects:@"8:58", @"9:58", @"10:58", @"11:58", @"-", @"12:58", @"1:58", @"2:58", @"3:58", @"4:58", @"5:58", @"6:58", @"-", @"7:58", @"8:58", @"9:58", @"10:58", @"12:44", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Carlos", @"name", [NSArray arrayWithObjects:@"9:01", @"10:01", @"11:01", @"12:01", @"-", @"1:01", @"2:01", @"3:01", @"4:01", @"5:01", @"6:01", @"7:01", @"-", @"8:01", @"9:01", @"10:01", @"11:01", @"12:47", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Redwood City", @"name", [NSArray arrayWithObjects:@"9:07", @"10:07", @"11:07", @"12:07", @"12:33", @"1:07", @"2:07", @"3:07", @"4:07", @"5:07", @"6:07", @"7:07", @"7:33", @"8:07", @"9:07", @"10:07", @"11:07", @"12:53", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Atherton", @"name", [NSArray arrayWithObjects:@"9:11", @"10:11", @"11:11", @"12:11", @"-", @"1:11", @"2:11", @"3:11", @"4:11", @"5:11", @"6:11", @"7:11", @"-", @"8:11", @"9:11", @"10:11", @"11:11", @"12:57", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Menlo Park", @"name", [NSArray arrayWithObjects:@"9:14", @"10:14", @"11:14", @"12:14", @"-", @"1:14", @"2:14", @"3:14", @"4:14", @"5:14", @"6:14", @"7:14", @"-", @"8:14", @"9:14", @"10:14", @"11:14", @"1:00", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Palo Alto", @"name", [NSArray arrayWithObjects:@"9:17", @"10:17", @"11:17", @"12:17", @"12:39", @"1:17", @"2:17", @"3:17", @"4:17", @"5:17", @"6:17", @"7:17", @"7:39", @"8:17", @"9:17", @"10:17", @"11:17", @"1:03", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"California Ave", @"name", [NSArray arrayWithObjects:@"9:21", @"10:21", @"11:21", @"12:21", @"-", @"1:21", @"2:21", @"3:21", @"4:21", @"5:21", @"6:21", @"7:21", @"-", @"8:21", @"9:21", @"10:21", @"11:21", @"1:07", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Antonio", @"name", [NSArray arrayWithObjects:@"9:25", @"10:25", @"11:25", @"12:25", @"-", @"1:25", @"2:25", @"3:25", @"4:25", @"5:25", @"6:25", @"7:25", @"-", @"8:25", @"9:25", @"10:25", @"11:25", @"1:11", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Mountain View", @"name", [NSArray arrayWithObjects:@"9:29", @"10:29", @"11:29", @"12:29", @"12:47", @"1:29", @"2:29", @"3:29", @"4:29", @"5:29", @"6:29", @"7:29", @"7:47", @"8:29", @"9:29", @"10:29", @"11:29", @"1:15", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Sunnyvale", @"name", [NSArray arrayWithObjects:@"9:34", @"10:34", @"11:34", @"12:34", @"12:52", @"1:34", @"2:34", @"3:34", @"4:34", @"5:34", @"6:34", @"7:34", @"7:52", @"8:34", @"9:34", @"10:34", @"11:34", @"1:20", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Lawrence", @"name", [NSArray arrayWithObjects:@"9:38", @"10:38", @"11:38", @"12:38", @"-", @"1:38", @"2:38", @"3:38", @"4:38", @"5:38", @"6:38", @"7:38", @"-", @"8:38", @"9:38", @"10:38", @"11:38", @"1:24", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Santa Clara", @"name", [NSArray arrayWithObjects:@"9:43", @"10:43", @"11:43", @"12:43", @"-", @"1:43", @"2:43", @"3:43", @"4:43", @"5:43", @"6:43", @"7:43", @"-", @"8:43", @"9:43", @"10:43", @"11:43", @"1:29", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Jose", @"name", [NSArray arrayWithObjects:@"9:51", @"10:51", @"11:51", @"12:51", @"1:03", @"1:51", @"2:51", @"3:51", @"4:51", @"5:51", @"6:51", @"7:51", @"8:03", @"8:51", @"9:51", @"10:51", @"11:51", @"1:37", nil], @"times", nil],
                    nil];
    } else if (weekday) { //Northbound weekday.
        stations = [NSArray arrayWithObjects:
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Gilroy", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"6:07", @"", @"6:30", @"", @"", @"7:05", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Martin", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"6:16", @"", @"6:39", @"", @"", @"7:14", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Morgan Hill", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"6:22", @"", @"6:45", @"", @"", @"7:20", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Blossom Hill", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"6:35", @"", @"6:58", @"", @"", @"7:33", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Capitol", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"6:41", @"", @"7:04", @"", @"", @"7:39", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Tamien", @"name", [NSArray arrayWithObjects:@"4:58", @"", @"5:50", @"5:56", @"", @"", @"", @"6:49", @"6:56", @"7:12", @"", @"", @"7:47", @"7:56", @"", @"8:33", @"", @"", @"", @"", @"", @"", @"", @"3:37", @"3:58", @"", @"4:32", @"", @"4:58", @"", @"", @"5:32", @"", @"5:58", @"", @"6:24", @"", @"", @"", @"8:23", @"9:23", @"", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Jose", @"name", [NSArray arrayWithObjects:@"4:30", @"5:05", @"5:45", @"5:57", @"6:03", @"6:22", @"6:45", @"6:50", @"6:57", @"7:03", @"7:20", @"7:45", @"7:50", @"7:55", @"8:03", @"8:22", @"8:40", @"9:10", @"10:10", @"11:10", @"12:10", @"1:10", @"2:10", @"3:05", @"3:44", @"4:05", @"4:25", @"4:39", @"4:45", @"5:05", @"5:25", @"5:31", @"5:39", @"5:45", @"6:05", @"6:25", @"6:31", @"6:45", @"6:50", @"7:30", @"8:30", @"9:30", @"10:30", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"College Park", @"name", [NSArray arrayWithObjects:@"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"7:58", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"3:08", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Santa Clara", @"name", [NSArray arrayWithObjects:@"4:35", @"5:10", @"-", @"6:02", @"-", @"6:27", @"-", @"-", @"7:02", @"-", @"7:25", @"-", @"-", @"8:02", @"-", @"8:27", @"8:45", @"9:15", @"10:15", @"11:15", @"12:15", @"1:15", @"2:15", @"3:12", @"3:49", @"4:10", @"-", @"4:44", @"-", @"5:10", @"-", @"-", @"5:44", @"-", @"6:10", @"-", @"-", @"-", @"6:55", @"7:35", @"8:35", @"9:35", @"10:35", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Lawrence", @"name", [NSArray arrayWithObjects:@"4:40", @"5:15", @"-", @"6:12", @"-", @"-", @"-", @"-", @"7:12", @"-", @"7:30", @"-", @"-", @"8:12", @"-", @"-", @"8:50", @"9:20", @"10:20", @"11:20", @"12:20", @"1:20", @"2:20", @"3:17", @"3:54", @"-", @"-", @"4:52", @"-", @"-", @"-", @"5:39", @"5:52", @"-", @"-", @"-", @"6:39", @"6:53", @"7:00", @"7:40", @"8:40", @"9:40", @"10:40", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Sunnyvale", @"name", [NSArray arrayWithObjects:@"4:44", @"5:19", @"-", @"6:18", @"6:13", @"-", @"-", @"7:00", @"7:18", @"7:13", @"-", @"-", @"8:00", @"8:18", @"8:13", @"-", @"8:54", @"9:24", @"10:24", @"11:24", @"12:24", @"1:24", @"2:24", @"3:21", @"3:58", @"-", @"-", @"4:58", @"-", @"-", @"-", @"-", @"5:58", @"-", @"-", @"-", @"-", @"-", @"7:04", @"7:44", @"8:44", @"9:44", @"10:44", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Mountain View", @"name", [NSArray arrayWithObjects:@"4:49", @"5:24", @"5:57", @"6:23", @"-", @"6:37", @"6:57", @"7:05", @"7:23", @"-", @"7:37", @"7:57", @"8:05", @"8:23", @"-", @"8:37", @"8:59", @"9:29", @"10:29", @"11:29", @"12:29", @"1:29", @"2:29", @"3:26", @"4:03", @"-", @"4:37", @"5:03", @"4:58", @"-", @"5:37", @"5:46", @"6:03", @"5:58", @"-", @"6:37", @"6:46", @"7:00", @"7:09", @"7:49", @"8:49", @"9:49", @"10:49", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Antonio", @"name", [NSArray arrayWithObjects:@"4:53", @"5:28", @"-", @"6:27", @"-", @"-", @"-", @"-", @"7:27", @"-", @"-", @"-", @"-", @"8:27", @"-", @"-", @"9:03", @"9:33", @"10:33", @"11:33", @"12:33", @"1:33", @"2:33", @"3:30", @"4:07", @"-", @"-", @"5:07", @"-", @"-", @"-", @"-", @"6:07", @"-", @"-", @"-", @"-", @"-", @"7:13", @"7:53", @"8:53", @"9:53", @"10:53", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"California Ave", @"name", [NSArray arrayWithObjects:@"4:57", @"5:32", @"-", @"6:31", @"-", @"-", @"-", @"7:11", @"7:31", @"-", @"-", @"-", @"8:11", @"8:31", @"-", @"-", @"9:07", @"9:37", @"10:37", @"11:37", @"12:37", @"1:37", @"2:37", @"3:34", @"4:11", @"-", @"-", @"5:11", @"-", @"-", @"-", @"-", @"6:11", @"-", @"-", @"-", @"-", @"7:06", @"7:17", @"7:57", @"8:57", @"9:57", @"10:57", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Palo Alto", @"name", [NSArray arrayWithObjects:@"5:01", @"5:36", @"6:05", @"6:36", @"6:23", @"-", @"7:05", @"7:16", @"7:36", @"7:23", @"-", @"8:05", @"8:16", @"8:36", @"8:23", @"-", @"9:11", @"9:41", @"10:41", @"11:41", @"12:41", @"1:41", @"2:41", @"3:38", @"4:16", @"4:24", @"-", @"5:16", @"5:06", @"5:24", @"-", @"5:54", @"6:16", @"6:06", @"6:24", @"-", @"6:54", @"7:10", @"7:21", @"8:01", @"9:01", @"10:01", @"11:01", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Menlo Park", @"name", [NSArray arrayWithObjects:@"5:04", @"5:39", @"-", @"6:39", @"-", @"6:45", @"-", @"-", @"7:39", @"-", @"7:45", @"-", @"-", @"8:39", @"-", @"8:45", @"9:14", @"9:44", @"10:44", @"11:44", @"12:44", @"1:44", @"2:44", @"3:41", @"4:19", @"-", @"4:46", @"5:19", @"-", @"-", @"5:46", @"5:57", @"6:19", @"-", @"-", @"6:46", @"6:57", @"7:13", @"7:24", @"8:04", @"9:04", @"10:04", @"11:04", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Redwood City", @"name", [NSArray arrayWithObjects: @"5:09", @"5:44", @"-", @"6:45", @"6:30", @"6:51", @"-", @"-", @"7:45", @"7:30", @"7:51", @"-", @"-", @"8:45", @"8:30", @"8:51", @"9:19", @"9:49", @"10:49", @"11:49", @"12:49", @"1:49", @"2:49", @"3:46", @"4:25", @"4:31", @"4:52", @"5:25", @"-", @"5:31", @"5:52", @"-", @"6:25", @"-", @"6:31", @"6:52", @"-", @"7:19", @"7:29", @"8:09", @"9:09", @"10:09", @"11:09", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Carlos", @"name", [NSArray arrayWithObjects:@"5:13", @"5:48", @"-", @"-", @"-", @"6:55", @"-", @"7:24", @"-", @"-", @"7:55", @"-", @"8:24", @"-", @"-", @"8:55", @"9:23", @"9:53", @"10:53", @"11:53", @"12:53", @"1:53", @"2:53", @"3:50", @"4:29", @"4:35", @"-", @"5:29", @"-", @"5:35", @"-", @"6:04", @"6:29", @"-", @"6:35", @"-", @"7:04", @"7:23", @"7:33", @"8:13", @"9:13", @"10:13", @"11:13", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Belmont", @"name", [NSArray arrayWithObjects:@"5:16", @"5:51", @"-", @"-", @"-", @"6:58", @"-", @"-", @"-", @"-", @"7:58", @"-", @"-", @"-", @"-", @"8:58", @"9:26", @"9:56", @"10:56", @"11:56", @"12:56", @"1:56", @"2:56", @"3:53", @"-", @"4:38", @"-", @"-", @"-", @"5:38", @"-", @"-", @"-", @"-", @"6:38", @"-", @"-", @"-", @"7:36", @"8:16", @"9:16", @"10:16", @"11:16", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Hillsdale", @"name", [NSArray arrayWithObjects:@"5:19", @"5:54", @"6:16", @"6:51", @"-", @"7:02", @"7:16", @"7:28", @"7:51", @"-", @"8:02", @"8:16", @"8:28", @"8:51", @"-", @"9:02", @"9:29", @"9:59", @"10:59", @"11:59", @"12:59", @"1:59", @"2:59", @"3:56", @"-", @"4:42", @"-", @"-", @"5:17", @"5:42", @"-", @"6:08", @"-", @"6:17", @"6:42", @"-", @"7:08", @"7:28", @"7:39", @"8:19", @"9:19", @"10:19", @"11:19", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Hayward Park", @"name", [NSArray arrayWithObjects:@"5:22", @"5:57", @"-", @"-", @"-", @"7:05", @"-", @"-", @"-", @"-", @"8:05", @"-", @"-", @"-", @"-", @"9:05", @"-", @"10:02", @"11:02", @"12:02", @"1:02", @"2:02", @"3:02", @"3:59", @"-", @"4:45", @"-", @"-", @"-", @"5:45", @"-", @"-", @"-", @"-", @"6:45", @"-", @"-", @"-", @"7:42", @"8:22", @"9:22", @"10:22", @"11:22", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Mateo", @"name", [NSArray arrayWithObjects:@"5:25", @"6:00", @"-", @"-", @"6:39", @"7:08", @"-", @"7:32", @"-", @"7:39", @"8:08", @"-", @"8:32", @"-", @"8:39", @"9:08", @"9:33", @"10:05", @"11:05", @"12:05", @"1:05", @"2:05", @"3:05", @"4:02", @"4:36", @"4:48", @"-", @"5:36", @"-", @"5:48", @"-", @"6:12", @"6:36", @"-", @"6:48", @"-", @"7:12", @"7:32", @"7:45", @"8:25", @"9:25", @"10:25", @"11:25", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Burlingame", @"name", [NSArray arrayWithObjects:@"5:28", @"6:03", @"-", @"-", @"-", @"7:11", @"-", @"7:35", @"-", @"-", @"8:11", @"-", @"8:35", @"-", @"-", @"9:11", @"9:36", @"10:08", @"11:08", @"12:08", @"1:08", @"2:08", @"3:08", @"4:05", @"-", @"4:51", @"-", @"-", @"-", @"5:51", @"-", @"6:15", @"-", @"-", @"6:51", @"-", @"7:15", @"7:35", @"7:48", @"8:28", @"9:28", @"10:28", @"11:28", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Millbrae", @"name", [NSArray arrayWithObjects:@"5:33", @"6:08", @"6:24", @"6:59", @"6:45", @"7:17", @"7:24", @"-", @"7:59", @"7:45", @"8:17", @"8:24", @"-", @"8:59", @"8:45", @"9:17", @"9:41", @"10:13", @"11:13", @"12:13", @"1:13", @"2:13", @"3:13", @"4:10", @"4:43", @"4:57", @"5:05", @"5:43", @"5:25", @"5:57", @"6:05", @"-", @"6:43", @"6:25", @"6:57", @"7:05", @"-", @"7:41", @"7:53", @"8:33", @"9:33", @"10:33", @"11:33", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Bruno", @"name", [NSArray arrayWithObjects:@"5:37", @"6:12", @"-", @"-", @"-", @"7:21", @"-", @"7:42", @"-", @"-", @"8:21", @"-", @"8:42", @"-", @"-", @"9:21", @"9:45", @"10:17", @"11:17", @"12:17", @"1:17", @"2:17", @"3:17", @"4:14", @"-", @"5:01", @"-", @"-", @"-", @"6:01", @"-", @"6:22", @"-", @"-", @"7:01", @"-", @"7:22", @"-", @"7:57", @"8:37", @"9:37", @"10:37", @"11:37", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"So. San Francisco", @"name", [NSArray arrayWithObjects:@"5:41", @"6:16", @"-", @"7:05", @"-", @"7:25", @"-", @"-", @"8:05", @"-", @"8:25", @"-", @"-", @"9:05", @"-", @"9:25", @"-", @"10:21", @"11:21", @"12:21", @"1:21", @"2:21", @"3:21", @"4:18", @"-", @"5:05", @"-", @"-", @"-", @"6:05", @"-", @"-", @"-", @"-", @"7:05", @"-", @"-", @"-", @"8:01", @"8:41", @"9:41", @"10:41", @"11:41", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Bayshore", @"name", [NSArray arrayWithObjects: @"5:47", @"6:22", @"-", @"-", @"-", @"7:33", @"-", @"-", @"-", @"-", @"8:33", @"-", @"-", @"-", @"-", @"9:31", @"-", @"10:27", @"11:27", @"12:27", @"1:27", @"2:27", @"3:27", @"4:24", @"-", @"5:13", @"-", @"-", @"-", @"6:13", @"-", @"-", @"-", @"-", @"7:13", @"-", @"-", @"-", @"8:07", @"8:47", @"9:47", @"10:47", @"11:47", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"22nd Street", @"name", [NSArray arrayWithObjects:@"5:52", @"6:27", @"-", @"-", @"-", @"7:40", @"-", @"-", @"-", @"-", @"8:40", @"-", @"-", @"-", @"-", @"9:37", @"-", @"10:32", @"11:32", @"12:32", @"1:32", @"2:32", @"3:32", @"4:29", @"4:55", @"5:21", @"5:17", @"5:55", @"5:37", @"6:21", @"6:17", @"-", @"6:55", @"6:37", @"7:21", @"7:17", @"-", @"7:53", @"8:12", @"8:52", @"9:52", @"10:52", @"11:52", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Francisco", @"name", [NSArray arrayWithObjects:@"6:01", @"6:36", @"6:42", @"7:19", @"7:02", @"7:48", @"7:42", @"7:57", @"8:19", @"8:02", @"8:48", @"8:42", @"8:57", @"9:19", @"9:02", @"9:45", @"10:02", @"10:41", @"11:41", @"12:41", @"1:41", @"2:41", @"3:41", @"4:38", @"5:03", @"5:29", @"5:24", @"6:02", @"5:44", @"6:29", @"6:24", @"6:39", @"7:02", @"6:44", @"7:29", @"7:24", @"7:39", @"8:00", @"8:21", @"9:01", @"10:01", @"11:01", @"12:01", nil], @"times", nil],
                    nil];
    } else { //Northbound weekend.
        stations = [NSArray arrayWithObjects:
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Jose", @"name", [NSArray arrayWithObjects:@"7:00", @"8:00", @"9:00", @"10:00", @"10:35", @"11:00", @"12:00", @"1:00", @"2:00", @"3:00", @"4:00", @"5:00", @"5:35", @"6:00", @"7:00", @"8:00", @"9:00", @"10:30", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Santa Clara", @"name", [NSArray arrayWithObjects:@"7:05", @"8:05", @"9:05", @"10:05", @"-", @"11:05", @"12:05", @"1:05", @"2:05", @"3:05", @"4:05", @"5:05", @"-", @"6:05", @"7:05", @"8:05", @"9:05", @"10:35", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Lawrence", @"name", [NSArray arrayWithObjects:@"7:10", @"8:10", @"9:10", @"10:10", @"-", @"11:10", @"12:10", @"1:10", @"2:10", @"3:10", @"4:10", @"5:10", @"-", @"6:10", @"7:10", @"8:10", @"9:10", @"10:40", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Sunnyvale", @"name", [NSArray arrayWithObjects:@"7:14", @"8:14", @"9:14", @"10:14", @"10:45", @"11:14", @"12:14", @"1:14", @"2:14", @"3:14", @"4:14", @"5:14", @"5:45", @"6:14", @"7:14", @"8:14", @"9:14", @"10:44", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Mountain View", @"name", [NSArray arrayWithObjects:@"7:19", @"8:19", @"9:19", @"10:19", @"10:50", @"11:19", @"12:19", @"1:19", @"2:19", @"3:19", @"4:19", @"5:19", @"5:50", @"6:19", @"7:19", @"8:19", @"9:19", @"10:49", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Antonio", @"name", [NSArray arrayWithObjects:@"7:23", @"8:23", @"9:23", @"10:23", @"-", @"11:23", @"12:23", @"1:23", @"2:23", @"3:23", @"4:23", @"5:23", @"-", @"6:23", @"7:23", @"8:23", @"9:23", @"10:53", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"California Ave", @"name", [NSArray arrayWithObjects:@"7:27", @"8:27", @"9:27", @"10:27", @"-", @"11:27", @"12:27", @"1:27", @"2:27", @"3:27", @"4:27", @"5:27", @"-", @"6:27", @"7:27", @"8:27", @"9:27", @"10:57", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Palo Alto", @"name", [NSArray arrayWithObjects:@"7:31", @"8:31", @"9:31", @"10:31", @"10:58", @"11:31", @"12:31", @"1:31", @"2:31", @"3:31", @"4:31", @"5:31", @"5:58", @"6:31", @"7:31", @"8:31", @"9:31", @"11:01", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Menlo Park", @"name", [NSArray arrayWithObjects:@"7:34", @"8:34", @"9:34", @"10:34", @"-", @"11:34", @"12:34", @"1:34", @"2:34", @"3:34", @"4:34", @"5:34", @"-", @"6:34", @"7:34", @"8:34", @"9:34", @"11:04", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Atherton", @"name", [NSArray arrayWithObjects:@"7:37", @"8:37", @"9:37", @"10:37", @"-", @"11:37", @"12:37", @"1:37", @"2:37", @"3:37", @"4:37", @"5:37", @"-", @"6:37", @"7:37", @"8:37", @"9:37", @"11:07", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Redwood City", @"name", [NSArray arrayWithObjects:@"7:41", @"8:41", @"9:41", @"10:41", @"11:04", @"11:41", @"12:41", @"1:41", @"2:41", @"3:41", @"4:41", @"5:41", @"6:04", @"6:41", @"7:41", @"8:41", @"9:41", @"11:11", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Carlos", @"name", [NSArray arrayWithObjects:@"7:45", @"8:45", @"9:45", @"10:45", @"-", @"11:45", @"12:45", @"1:45", @"2:45", @"3:45", @"4:45", @"5:45", @"-", @"6:45", @"7:45", @"8:45", @"9:45", @"11:15", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Belmont", @"name", [NSArray arrayWithObjects:@"7:48", @"8:48", @"9:48", @"10:48", @"-", @"11:48", @"12:48", @"1:48", @"2:48", @"3:48", @"4:48", @"5:48", @"-", @"6:48", @"7:48", @"8:48", @"9:48", @"11:18", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Hillsdale", @"name", [NSArray arrayWithObjects:@"7:51", @"8:51", @"9:51", @"10:51", @"11:10", @"11:51", @"12:51", @"1:51", @"2:51", @"3:51", @"4:51", @"5:51", @"6:10", @"6:51", @"7:51", @"8:51", @"9:51", @"11:21", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Hayward Park", @"name", [NSArray arrayWithObjects:@"7:54", @"8:54", @"9:54", @"10:54", @"-", @"11:54", @"12:54", @"1:54", @"2:54", @"3:54", @"4:54", @"5:54", @"-", @"6:54", @"7:54", @"8:54", @"9:54", @"11:24", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Mateo", @"name", [NSArray arrayWithObjects:@"7:57", @"8:57", @"9:57", @"10:57", @"11:14", @"11:57", @"12:57", @"1:57", @"2:57", @"3:57", @"4:57", @"5:57", @"6:14", @"6:57", @"7:57", @"8:57", @"9:57", @"11:27", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Burlingame", @"name", [NSArray arrayWithObjects:@"8:00", @"9:00", @"10:00", @"11:00", @"-", @"12:00", @"1:00", @"2:00", @"3:00", @"4:00", @"5:00", @"6:00", @"-", @"7:00", @"8:00", @"9:00", @"10:00", @"11:30", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Broadway", @"name", [NSArray arrayWithObjects:@"8:03", @"9:03", @"10:03", @"11:03", @"-", @"12:03", @"1:03", @"2:03", @"3:03", @"4:03", @"5:03", @"6:03", @"-", @"7:03", @"8:03", @"9:03", @"10:03", @"11:33", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Millbrae", @"name", [NSArray arrayWithObjects:@"8:08", @"9:08", @"10:08", @"11:08", @"11:21", @"12:08", @"1:08", @"2:08", @"3:08", @"4:08", @"5:08", @"6:08", @"6:21", @"7:08", @"8:08", @"9:08", @"10:08", @"11:38", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Bruno", @"name", [NSArray arrayWithObjects:@"8:12", @"9:12", @"10:12", @"11:12", @"-", @"12:12", @"1:12", @"2:12", @"3:12", @"4:12", @"5:12", @"6:12", @"-", @"7:12", @"8:12", @"9:12", @"10:12", @"11:42", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"So. San Francisco", @"name", [NSArray arrayWithObjects:@"8:17", @"9:17", @"10:17", @"11:17", @"-", @"12:17", @"1:17", @"2:17", @"3:17", @"4:17", @"5:17", @"6:17", @"-", @"7:17", @"8:17", @"9:17", @"10:17", @"11:47", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"Bayshore", @"name", [NSArray arrayWithObjects:@"8:23", @"9:23", @"10:23", @"11:23", @"-", @"12:23", @"1:23", @"2:23", @"3:23", @"4:23", @"5:23", @"6:23", @"-", @"7:23", @"8:23", @"9:23", @"10:23", @"11:53", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"22nd Street", @"name", [NSArray arrayWithObjects:@"8:28", @"9:28", @"10:28", @"11:28", @"-", @"12:28", @"1:28", @"2:28", @"3:28", @"4:28", @"5:28", @"6:28", @"-", @"7:28", @"8:28", @"9:28", @"10:28", @"11:58", nil], @"times", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"San Francisco", @"name", [NSArray arrayWithObjects:@"8:36", @"9:36", @"10:36", @"11:36", @"11:39", @"12:36", @"1:36", @"2:36", @"3:36", @"4:36", @"5:36", @"6:36", @"6:39", @"7:36", @"8:36", @"9:36", @"10:36", @"12:06", nil], @"times", nil],
                    nil];
    }

    int y = 0; int i = 0; int most_times = 0;
    for (NSDictionary *station in stations) {   
        NSArray *times = [station objectForKey:@"times"];
        NSString *name = [station objectForKey:@"name"];

        int height = [self heightForStation:name];
        
        StationName *sn = [[StationName alloc] initWithFrame:CGRectMake(0, y, 102, height)];
        sn.tag = i;
        sn.name = name;
        [self.scrollView addSubview:sn];
        [sn release];

        int yo = y+7;
        if (height > 31) {
            yo += 8;
        }

        StationTimes *st = [[StationTimes alloc] initWithFrame:CGRectMake(0, yo, 44*[times count], 16)];
        st.tag = 123;
        st.height = height;
        st.times = times;
        [self.timetable addSubview:st];
        [st release];

        most_times = MAX(most_times, [times count]);
        
        y += height; i++;
        
        [self.timetable setContentSize:CGSizeMake(44 * [times count], y)];

        UIView *stroke = [[UIView alloc] initWithFrame:CGRectMake(-999, y-2, 9999, 1)];
        stroke.tag = 123;
        [stroke setBackgroundColor:[UIColor colorWithWhite:.93f alpha:1.0f]];
        [timetable addSubview:stroke];
        [stroke release];
    }
    
    int x = 0;
    for (int ii = 1; ii < most_times; ii++) {
        UIView *stroke = [[UIView alloc] initWithFrame:CGRectMake(x + 44, -200, 1, 9999)];
        stroke.tag = 123;
        [stroke setBackgroundColor:[UIColor colorWithWhite:.93f alpha:1.0f]];
        [timetable addSubview:stroke];
        [stroke release];
        
        x += 44;
    }

    if (!weekday) {
        int y = -84; int x1 = 8; int x2 = self.timetable.contentSize.width-36;
        if (southbound) {
            x1 = x2 - 44;
        }

        UIImageView *sat_only = [[[UIImageView alloc] initWithFrame:CGRectMake(x1, y, 28, 88)] autorelease];
        sat_only.tag = 123;
        [sat_only setImage:[UIImage imageNamed:@"saturday_only.png"]];
        [timetable addSubview:sat_only];
        
        sat_only = [[[UIImageView alloc] initWithFrame:CGRectMake(x2, y, 28, 88)] autorelease];
        sat_only.tag = 123;
        [sat_only setImage:[UIImage imageNamed:@"saturday_only.png"]];
        [timetable addSubview:sat_only];
    }

    [self.scrollView setContentSize:CGSizeMake(102, y)];
    
    DebugLog(@".");
}

- (IBAction)showInfo:(id)sender {
    AboutViewController *ac = [[[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil] autorelease];
    UINavigationController *nc = [[[UINavigationController alloc] initWithRootViewController:ac] autorelease];
    [nc setNavigationBarHidden:YES animated:NO];
    [self.navigationController presentModalViewController:nc animated:YES];
}

- (int)heightForStation:(NSString *)stationName {
    if ([stationName isEqualToString:@"So. San Francisco"]) {
        return 46;
    }

    return 31;
}
                               
- (void)scrollViewDidScroll:(UIScrollView *)sv {
    if (sv == self.timetable) {
        [scrollView setContentOffset:CGPointMake(0, timetable.contentOffset.y)];
    } else {
        [timetable setContentOffset:CGPointMake(timetable.contentOffset.x, scrollView.contentOffset.y)];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
      return YES;
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
