//
//  MainNavigationController.h
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SliderRootViewController;

@interface MainNavigationController : UINavigationController{
    float originX;
    CGRect originFrame, runningFrame;

}

@property (nonatomic, assign) SliderRootViewController *m_rootVC;

- (void)moveViewFrom:(float)x;
- (void)moveOrResume:(float)x;


@end
