//
//  ContentViewPhoneControllerViewController.m
//  PVC
//
//  Created by TimD on 06/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContentViewPhoneController.h"

@interface ContentViewPhoneController ()

@end

@implementation ContentViewPhoneController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.scrollView setZoomScale:0.5];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.scrollView setZoomScale:0.25];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Check for orientation
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        // is landscape
        NSLog(@"iPhone - landscape");
        [self.scrollView setZoomScale:0.25];
        [self.scrollView setMinimumZoomScale:0.25];
    } else {
        // is portrait
        NSLog(@"iPhone - portrait");
        [self.scrollView setZoomScale:0.25];
        [self.scrollView setMinimumZoomScale:0.25];
    }
    
	return YES;
}

@end
