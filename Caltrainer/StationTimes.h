//
//  StationTimes.h
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/12/11.
//  Copyright 2011 Little Big Things, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StationTimes : UIView {
    NSArray *times;
    int height;
    int y;
    BOOL trains;
}

@property BOOL trains;
@property int height;
@property int y;
@property (nonatomic, retain) NSArray *times;

- (id)initWithFrame:(CGRect)frame andTrains:(BOOL)t;

@end
