//
//  StationName.m
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/12/11.
//  Copyright 2011 Little Big Things, LLC. All rights reserved.
//

#import "StationName.h"

@implementation StationName

@synthesize name;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"station_background.png"] drawInRect:rect];

    [[UIImage imageNamed:@"divider.png"] drawInRect:CGRectMake(0, rect.size.height-2, 101, 2)];

    int y = 7; int x = y+1;

    [[UIColor colorWithWhite:1 alpha:1] set];
    [name drawInRect:CGRectMake(x, y+1, 102-2*x, 999) withFont:[UIFont boldSystemFontOfSize:12.0f] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
    [[UIColor colorWithWhite:.33 alpha:1] set];
    [name drawInRect:CGRectMake(x, y, 102-2*x, 999) withFont:[UIFont boldSystemFontOfSize:12.0f] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];

}

@end
