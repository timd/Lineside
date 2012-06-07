//
//  ContentViewPadController.m
//  PVC
//
//  Created by TimD on 06/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContentViewPadController.h"

@interface ContentViewPadController ()

@end

@implementation ContentViewPadController

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Check for orientation
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        // is landscape
        NSLog(@"iPad - landscape");
        [self.scrollView setZoomScale:0.25 animated:YES];
        [self.scrollView setMinimumZoomScale:0.25];
        
    } else {
        
        // is portrait
        NSLog(@"iPad - portrait");
        [self.scrollView setZoomScale:0.5 animated:YES];
        [self.scrollView setMinimumZoomScale:0.5];
    }
    
	return YES;
}

@end
