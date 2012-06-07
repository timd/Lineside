//
//  ContentViewController.m
//  PVC
//
//  Created by TimD on 06/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITapGestureRecognizer *tapCatcher;

@end

@implementation ContentViewController

@synthesize pageNumber = _pageNumber;
@synthesize imageName = _imageName;
@synthesize scrollView = _scrollView;

@synthesize imageView = _imageView;
@synthesize tapCatcher = _tapCatcher;

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
    // Do any additional setup after loading the view from its nib.
    UIImage *image = [UIImage imageNamed:self.imageName];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    
    [self.scrollView setZoomScale:0.5];
    [self.scrollView addSubview:self.imageView];
    
    self.tapCatcher = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCatchDoubleTap)];
    [self.tapCatcher setNumberOfTapsRequired:2];
    [self.tapCatcher setNumberOfTouchesRequired:1];
    [self.scrollView addGestureRecognizer:self.tapCatcher];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return self.imageView;
}

-(void)didCatchDoubleTap {
    
    if (self.scrollView.zoomScale <= 0.5) {
        // Zoom in
        [self.scrollView setZoomScale:1.0 animated:YES];
        
    } else if (self.scrollView.zoomScale >= 1.0) {
        
        [self.scrollView setZoomScale:0.5 animated:YES];
        
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return YES;
    
}

@end
