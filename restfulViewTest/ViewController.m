//
//  ViewController.m
//  restfulViewTest
//
//  Created by 唐 梦韵 on 12-3-23.
//  Copyright (c) 2012年 kingtrust. All rights reserved.
//

#import "ViewController.h"
#import "SplitScrollView.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *leftImage = [UIImage imageNamed:@"left.jpg"];
    UIImage *rightImage = [UIImage imageNamed:@"00.jpg"];
//    SplitScrollView *ssv = [[SplitScrollView alloc] 
//                            initWithFrame:CGRectMake(20, 20, 600, 600) 
//                            LeftImage:leftImage 
//                            RightImage:rightImage];
    UIImageView *leftIV = [[UIImageView alloc] initWithImage:leftImage];
    UIImageView *rightIV = [[UIImageView alloc] initWithImage:rightImage];
    
    SplitScrollView *ssv = [[SplitScrollView alloc] 
                            initWithFrame:CGRectMake(20, 20, 600, 600) 
                            LeftSize:CGSizeMake(200, 1000) 
                            RightSize:CGSizeMake(400, 1200)];
    [ssv addSubviewIntoLeftScrollView:leftIV];
    [ssv addSubviewIntoRightScrollView:rightIV];
    [self.view addSubview:ssv];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
