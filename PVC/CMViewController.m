//
//  CMViewController.m
//  PVC
//
//  Created by TimD on 06/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CMViewController.h"
#import "ContentViewController.h"

@interface CMViewController ()

@property (nonatomic) NSUInteger currentPage;

@end

@implementation CMViewController

@synthesize pageViewController = _pageViewController;
@synthesize modelArray = _modelArray;

@synthesize currentPage = _currentPage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.modelArray = [[NSMutableArray alloc] init];
    
    for (NSInteger count = 0; count < 15; count ++) {
        NSString *pageString = [NSString stringWithFormat:@"Page %d", count + 1];
        [self.modelArray addObject:pageString];
    }
    
    // Instantiate PVC
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl 
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    [self.pageViewController setDelegate:self];
    [self.pageViewController setDataSource:self];
    
    // Set initial view controller
    ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    contentViewController.pageNumber = 0;
    
    contentViewController.labelContents = [self.modelArray objectAtIndex:self.currentPage];
    
    NSString *imageName = [NSString stringWithFormat:@"page_%d.jpg", contentViewController.pageNumber + 1];
    contentViewController.imageName = imageName;
    
    // Create array of pages for pvc
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:contentViewController, nil];
    
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward 
                                       animated:NO
                                     completion:nil];
    
    // Add the pvc as a child controller
    [self addChildViewController:self.pageViewController];
    
    // place the view on the page
    [self.view addSubview:self.pageViewController.view];
    
    // Tell the pvc that it's been moved to a parent
    [self.pageViewController didMoveToParentViewController:self];
    
    // Hook up the gesture recognizers
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    
}

    
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark PageViewController datasource methods

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    ContentViewController *currentContentController = (ContentViewController *)viewController;

    if (currentContentController.pageNumber == 0) {
        
        // At the beginning of the array, so cannot provide a previous page
        return nil;
        
    } else {
        
        ContentViewController *nextContentController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
        nextContentController.labelContents = [self.modelArray objectAtIndex:currentContentController.pageNumber - 1];

        nextContentController.pageNumber = currentContentController.pageNumber - 1;
        NSString *imageName = [NSString stringWithFormat:@"page_%d.jpg", nextContentController.pageNumber + 1];
        nextContentController.imageName = imageName;
        
        return nextContentController;
        
    }
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    ContentViewController *currentContentController = (ContentViewController *)viewController;
    
    if ( currentContentController.pageNumber == [self.modelArray count] - 1) {
        // At the end of the array, so cannot provide a next page
        return nil;
        
    } else {
        
        ContentViewController *nextContentController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
        nextContentController.labelContents = [self.modelArray objectAtIndex:currentContentController.pageNumber + 1];
        
        nextContentController.pageNumber = currentContentController.pageNumber + 1;
        NSString *imageName = [NSString stringWithFormat:@"page_%d.jpg", nextContentController.pageNumber + 1];
        nextContentController.imageName = imageName;

        return nextContentController;

    }
}

#pragma mark -
#pragma mark PageViewControllerDelegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {

    if(UIInterfaceOrientationIsPortrait(orientation)) {
        // In portrait orientation: 
        // Set the spine position to "min" 
        // Set page view controller's view controllers array to contain just one view controller.
        // Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation
        // Sets the doubleSided property to YES, so set it to NO here.
        
        UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        self.pageViewController.doubleSided = NO;
        
        return UIPageViewControllerSpineLocationMin;
        
    } else {
        
        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        NSArray *viewControllers = nil;
        ContentViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        
        if(currentViewController.pageNumber == 0 || currentViewController.pageNumber %2 == 0) {
            UIViewController *nextViewController = [self pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:currentViewController, nextViewController, nil];
        } else {
            UIViewController *previousViewController = [self pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:previousViewController, currentViewController, nil];
        }
        
        //Now, set the viewControllers property of UIPageViewController
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        return UIPageViewControllerSpineLocationMid;
    }
}
@end
