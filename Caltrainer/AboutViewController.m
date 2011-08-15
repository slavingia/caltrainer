//
//  AboutViewController.m
//  Caltrainer
//
//  Created by Sahil Lavingia on 8/13/11.
//  Copyright 2011 Little Big Things, LLC. All rights reserved.
//

#import "AboutViewController.h"
#import "CaltrainerAppDelegate.h"

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"red_color.png"]]];
}

- (IBAction)twitterFollow:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=slavingia"]];
}

- (IBAction)sendEmail:(id)sender {
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"Caltrainer!"];
    [controller setToRecipients:[NSArray arrayWithObject:@"sahil@slavingia.com"]];
    [controller setMessageBody:@"" isHTML:NO];
    
    if (controller) {
        [self.navigationController presentModalViewController:controller animated:YES];
    }
    [controller release];
}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error; {
    if (result == MFMailComposeResultSent) { }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
