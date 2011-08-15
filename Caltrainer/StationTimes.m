//
//  StationName.m
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/12/11.
//  Copyright 2011 Little Big Things, LLC. All rights reserved.
//

#import "StationTimes.h"

@implementation StationTimes

@synthesize times, height, y;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [[UIColor whiteColor] set];
    UIRectFill(rect);
    
    int x = 0;
    for (NSString *time in times) {        
        [[UIColor colorWithWhite:.33 alpha:1.0f] set];
        [time drawInRect:CGRectMake(x+3, 0, 40, 16) withFont:[UIFont boldSystemFontOfSize:12.0f] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];

        x += 44;
    }
}

@end
