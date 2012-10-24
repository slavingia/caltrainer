//
//  StationName.m
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/12/11.
//  Copyright 2011 Little Big Things, LLC. All rights reserved.
//

#import "StationTimes.h"

@implementation StationTimes

@synthesize times, height, y, trains;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTrains:(BOOL)t {
    self = [super initWithFrame:frame];
    if (self) {
        self.trains = t;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [[UIColor whiteColor] set];
    UIRectFill(rect);
    
    int x = 2;
    for (NSString *time in times) {
        if (trains) { //Train number.
            [[UIColor colorWithWhite:.7 alpha:1.0f] set];
            [time drawInRect:CGRectMake(x+3, 0, TIME_WIDTH-4, 16) withFont:[UIFont systemFontOfSize:12.0f] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
        } else { //Train times.
            [[UIColor colorWithWhite:.33 alpha:1.0f] set];
            CGSize s = [time drawInRect:CGRectMake(x+3, 0, TIME_WIDTH-4, 16) withFont:[UIFont boldSystemFontOfSize:12.0f] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];

            if ([time length] > 1) {
                [[UIColor whiteColor] set];
                NSString *am = [time substringFromIndex:[time length]-2];

                CGSize a = [am drawInRect:CGRectMake((TIME_WIDTH-4-s.width)/2+x+2, 0, s.width, 16) withFont:[UIFont boldSystemFontOfSize:12.0f] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentRight];

                UIRectFill(CGRectMake((TIME_WIDTH-4-s.width)/2+x+3 + s.width - a.width, 0, a.width, 16));
                
                [[UIColor colorWithWhite:.7 alpha:1.0f] set];
                [am drawInRect:CGRectMake((TIME_WIDTH-4-s.width)/2 + x + 4 + s.width - a.width, 3, s.width, 16) withFont:[UIFont boldSystemFontOfSize:8.0f] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentLeft];
            }
        }

        x += TIME_WIDTH;
    }
}

@end
