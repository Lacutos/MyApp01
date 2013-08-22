//
//  ARViewController.m
//  MyApp01
//
//  Created by Lacutos on 13/6/25.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "ARViewController.h"
#import "AppDelegate.h"
#import "SliderRootViewController.h"
@interface ARViewController ()

@end

@implementation ARViewController
@synthesize m_cameraController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//=================================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
//=================================================================================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//=================================================================================
#pragma -
#pragma Custom Methods
- (void)OpenCamera
{
    if (self.m_cameraController == nil) {
		self.m_cameraController = [[[UIImagePickerController alloc] init] autorelease];	// 初始化UIImagePickerController
		self.m_cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;		// 設定成照像機模式
		self.m_cameraController.cameraViewTransform = CGAffineTransformScale(self.m_cameraController.cameraViewTransform, 1.25f, 1.252f);//可以隠藏因設定showsCameraControls=NO時，會出現一行空白的bar, y=1.13剛好可以放大填滿視窗
        self.m_cameraController.showsCameraControls = NO;		// 是否顯示照像機下方的controller，可做cancel和picture
        self.m_cameraController.wantsFullScreenLayout = YES;
	}
    SliderRootViewController *RootVC = (SliderRootViewController*)appDelegate.window.rootViewController;
    [RootVC presentViewController:self.m_cameraController animated:YES completion:nil];
}
//=================================================================================
@end
























