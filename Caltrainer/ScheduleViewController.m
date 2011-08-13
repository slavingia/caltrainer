//
//  ScheduleViewController.m
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScheduleViewController.h"
#import "StationName.h"

@implementation ScheduleViewController

@synthesize scrollView, timetable;

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
    
    //Southbound weekday.
    NSArray *stations = [NSArray arrayWithObjects:
                         [NSDictionary dictionaryWithObjectsAndKeys:@"San Francisco", @"name", [NSArray arrayWithObjects:@"4:55", @"5:25", @"6:11", @"6:24", @"6:44", @"6:59", @"7:14", @"7:19", @"7:24", @"7:44", @"7:59", @"8:14", @"8:19", @"8:24", @"8:44", @"8:59", @"9:07", @"10:07", @"11:07", @"12:07", @"1:07", @"2:07", @"3:07", @"3:37", @"4:09", @"4:19", @"4:27", @"4:33", @"4:56", @"5:14", @"5:20", @"5:27", @"5:33", @"5:56", @"6:14", @"6:27", @"6:33", @"6:56", @"7:30", @"8:40", @"9:40", @"10:40", @"12:01", nil], @"times", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"22nd Street", @"name", [NSArray arrayWithObjects:@"5:00", @"5:30", @"6:16", @"6:29", @"6:49", @"7:04", @"7:19", @"-", @"7:29", @"7:49", @"8:04", @"8:19", @"-", @"8:29", @"8:49", @"9:04", @"9:12", @"10:12", @"11:12", @"12:12", @"1:12", @"2:12", @"3:12", @"-", @"-", @"-", @"4:32", @"-", @"-", @"-", @"-", @"5:32", @"-", @"-", @"-", @"6:32", @"-", @"-", @"7:35", @"8:45", @"9:45", @"10:45", @"12:06", nil], @"times", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Bayshore", @"name", [NSArray arrayWithObjects:@"5:05", @"5:35", @"-", @"6:34", @"-", @"-", @"-", @"-", @"7:34", @"-", @"-", @"-", @"-", @"8:34", @"-", @"-", @"9:17", @"10:17", @"11:17", @"12:17", @"1:17", @"2:17", @"Bayshore", @"3:17", @"-", @"-", @"-", @"4:40", @"-", @"-", @"-", @"-", @"5:40", @"-", @"-", @"-", @"6:40", @"-", @"-", @"7:40", @"8:50", @"9:50", @"10:50", @"12:11", nil], @"times", nil],
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
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Lawrence", @"name", [NSArray arrayWithObjects:@"6:12", @"6:42", @"7:12", @"-", @"7:49*", @"-", @"-", @"8:16", @"-", @"8:49*", @"-", @"-", @"9:16", @"-", @"9:49*", @"-", @"10:24", @"11:24", @"12:24", @"1:24", @"2:24", @"3:24", @"4:24", @"4:46", @"-", @"-", @"-", @"-", @"6:01*", @"-", @"-", @"6:43", @"-", @"7:01*", @"-", @"-", @"-", @"7:59", @"8:47", @"9:57", @"10:57", @"11:57", @"1:18", nil], @"times", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Santa Clara", @"name", [NSArray arrayWithObjects:@"6:17", @"6:47", @"-", @"7:34", @"7:56*", @"-", @"-", @"-", @"8:34", @"8:56*", @"-", @"-", @"-", @"9:34", @"9:56*", @"-", @"10:29", @"11:29", @"12:29", @"1:29", @"2:29", @"3:29", @"4:29", @"4:51", @"-", @"-", @"5:47", @"-", @"6:08*", @"-", @"-", @"6:48", @"-", @"7:08*", @"-", @"7:47", @"-", @"8:04", @"8:52", @"10:02", @"11:02", @"12:02", @"1:23", nil], @"times", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"College Park", @"name", [NSArray arrayWithObjects:@"-", @"-", @"-", @"-", @"7:59*", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"4:32", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", @"-", nil], @"times", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"San Jose", @"name", [NSArray arrayWithObjects:@"6:26", @"6:56", @"7:24", @"7:43", @"8:06", @"7:58", @"8:13", @"8:28", @"8:43", @"9:05", @"8:58", @"9:13", @"9:28", @"9:43", @"10:05", @"9:58", @"10:38", @"11:38", @"12:38", @"1:38", @"2:38", @"3:38", @"4:39", @"5:00", @"5:06", @"5:27", @"5:55", @"5:32", @"6:16", @"6:11", @"6:28", @"6:56", @"6:32", @"7:16", @"7:11", @"7:55", @"7:32", @"8:12", @"9:01", @"10:11", @"11:11", @"12:11", @"1:32", nil], @"times", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Tamien", @"name", [NSArray arrayWithObjects:@" ", @"7:03", @" ", @"7:50", @"8:13", @" ", @"8:50", @"9:12", @" ", @"9:50", @"10:12", @" ", @"4:45", @"5:07", @" ", @"5:39", @"6:22", @" ", @"7:02", @"6:39", @"7:23", @" ", @"7:39", @"8:19", @" ", @"10:18", @"11:18", @" ", nil], @"times", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Capitol", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"4:52", @"", @"", @"", @"", @"", @"6:29", @"", @"", @"7:09", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Blossom Hill", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"4:58", @"", @"", @"", @"", @"", @"6:35", @"", @"", @"7:15", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Morgan Hill", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"5:11", @"", @"", @"", @"", @"", @"6:48", @"", @"", @"7:28", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"San Martin", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"5:17", @"", @"", @"", @"", @"", @"6:54", @"", @"", @"7:34", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Gilroy", @"name", [NSArray arrayWithObjects:@" ", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"5:30", @"", @"", @"", @"", @"", @"7:07", @"", @"", @"7:47", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil], @"times", nil],
                        nil];

    int y = 0; int i = 0;
    for (NSDictionary *station in stations) {
        int height = [self heightForStation:[station objectForKey:@"name"]];

        StationName *sn = [[[StationName alloc] initWithFrame:CGRectMake(0, y, 102, height)] autorelease];
        sn.tag = i;
        sn.name = [station objectForKey:@"name"];
        [self.scrollView addSubview:sn];
        
        NSArray *times = [station objectForKey:@"times"];
        
        int x = 0;
        for (NSString *time in times) {
            
            int yo = y+6;
            if (height > 31) {
                yo += 8;
            }
            
            int width = [self widthForTime:time];
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(x+1, yo, width, 16)] autorelease];
            [label setText:time];
            [label setTextAlignment:UITextAlignmentCenter];
            [label setTextColor:[UIColor colorWithWhite:.33 alpha:1.0f]];
            [label setFont:[UIFont boldSystemFontOfSize:12.0f]];
            [label setBackgroundColor:[UIColor clearColor]];
            [timetable addSubview:label];
        
            UIView *stroke = [[[UIView alloc] initWithFrame:CGRectMake(x + width, y-200, 1, height+400)] autorelease];
            [stroke setBackgroundColor:[UIColor colorWithWhite:.93f alpha:1.0f]];
            [timetable addSubview:stroke];

            x += width;
        }
        
        y += height; i++;

        [self.timetable setContentSize:CGSizeMake(x, y)];

        UIView *stroke = [[[UIView alloc] initWithFrame:CGRectMake(-999, y-2, 9999, 1)] autorelease];
        [stroke setBackgroundColor:[UIColor colorWithWhite:.93f alpha:1.0f]];
        [timetable addSubview:stroke];
    }
    
    [self.scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"station_background.png"]]];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setMaximumZoomScale:1.0f]; [self.scrollView setMinimumZoomScale:1.0f];
    [self.scrollView setContentSize:CGSizeMake(102, y)];

    [self.timetable setMaximumZoomScale:1.0f]; [self.timetable setMinimumZoomScale:1.0f];
}

- (int)heightForStation:(NSString *)stationName {
    int y = 7; int x = y+1;

    return [stationName drawInRect:CGRectMake(x, y, 102-2*x, 999) withFont:[UIFont boldSystemFontOfSize:12.0f] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight].height + 16;
}

- (int)widthForTime:(NSString *)time { 
    return 44;
    return [time drawInRect:CGRectMake(999, 999, 999, 999) withFont:[UIFont boldSystemFontOfSize:12.0f]].width + 16;
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
//      return YES;
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
