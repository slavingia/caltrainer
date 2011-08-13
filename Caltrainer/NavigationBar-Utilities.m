//
//  CustomNavigationBar.m
//  Pinterest
//
//  Created by Sahil Lavingia on 2/9/10.
//  Copyright 2011 Cold Brew Labs, Inc. All rights reserved.
//

#import "NavigationBar-Utilities.h"

@implementation UINavigationBar (CustomImage)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"blank_header.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end

@implementation UIToolbar (CustomImage)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"blank_toolbar.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end