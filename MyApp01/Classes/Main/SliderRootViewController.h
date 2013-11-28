//
//  SliderRootViewController.h
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainNavigationController,MainViewController,LeftMenuViewController,RightMenuViewController;

@interface SliderRootViewController : UIViewController{

    MainNavigationController    *m_navVC;
    MainViewController          *m_mainVC;
    LeftMenuViewController      *m_leftVC;
    RightMenuViewController     *m_rightVC;
}
@property(nonatomic, retain)MainNavigationController    *m_navVC;
@property(nonatomic, retain)MainViewController          *m_mainVC;
@property(nonatomic, retain)LeftMenuViewController      *m_leftVC;
@property(nonatomic, retain)RightMenuViewController     *m_rightVC;



- (void)bringToFront:(BOOL)isLeft;
- (void)LeftBackToMain;
- (void)RightdidselectedRowAtIndexPath;
- (void)ShowChildeViews:(BOOL)bShow;
- (BOOL)MapOrList;


- (void)AddMainVCAnnotationData:(NSMutableArray*)DataArray;

@end
