//
//  AboutViewController.h
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/13/11.
//  Copyright 2011 Little Big Things, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    
}

- (IBAction)cancel:(id)sender;
- (IBAction)twitterFollow:(id)sender;
- (IBAction)sendEmail:(id)sender;

@end
