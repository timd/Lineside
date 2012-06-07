//
//  ContentViewController.h
//  PVC
//
//  Created by TimD on 06/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic ) int pageNumber;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end
