//
//  SliderRootViewController.m
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "SliderRootViewController.h"
#import "MainNavigationController.h"
#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"

@interface SliderRootViewController ()

@end

@implementation SliderRootViewController

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
    
    m_mainVC = [[[MainViewController alloc] init] autorelease];
    m_navVC = [[[MainNavigationController alloc] initWithRootViewController:m_mainVC] autorelease];
    
    m_leftVC = [[[LeftMenuViewController alloc] init] autorelease];
    m_rightVC = [[[RightMenuViewController alloc] init] autorelease];
    
    [m_leftVC setWantsFullScreenLayout:YES];
    [m_rightVC setWantsFullScreenLayout:YES];
    
    [self addChildViewController:m_navVC];
    [self addChildViewController:m_leftVC];
    [self addChildViewController:m_rightVC];
    NSLog(@"[self.childViewControllers count] = %d",[self.childViewControllers count]);
    
    [self.view addSubview:m_leftVC.view];
    [self.view addSubview:m_rightVC.view];
    [self.view addSubview:m_navVC.view];

    m_navVC.m_rootVC = self;
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//=================================================================================
- (void)bringToFront:(BOOL)isLeft
{
    [m_leftVC.view setHidden:!isLeft];
//    if(isLeft)
//        [m_leftVC Hidden];
    
    
//    m_leftVC.view.frame = CGRectMake(-320, 0, m_leftVC.view.frame.size.width, m_leftVC.view.frame.size.height);
//    float x = 40.0;
//    CGRect frame = self.view.frame;
//    frame.origin.x = x;
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        m_leftVC.view.frame = frame;
//    }];

    
    [m_rightVC.view setHidden:!m_leftVC.view.hidden];
}
//=================================================================================
- (void)LeftBackToMain
{
    [m_mainVC leftSelected];
//    [m_mainVC SwitcToList];
}
//=================================================================================
- (void)ShowChildeViews:(BOOL)bShow
{
    NSLog(@"[self.childViewControllers count] = %d",[self.childViewControllers count]);
    for(UIViewController* vc in self.childViewControllers)
    {
        if([vc isKindOfClass:[MainNavigationController class]])
            continue;
        [vc.view setHidden:!bShow];
    }    
}
//=================================================================================
- (void)RightdidselectedRowAtIndexPath
{
    [m_mainVC rightSelected];
    [m_mainVC SwitchMapOrList];
}
//=================================================================================
- (BOOL)MapOrList
{
    return m_mainVC.m_bIsMap;
}
//=================================================================================
@end




































