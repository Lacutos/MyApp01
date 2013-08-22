//
//  MainNavigationController.m
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "MainNavigationController.h"
#import "SliderRootViewController.h"
#import "Constants.h"

@implementation MainNavigationController
@synthesize m_rootVC;

- (void)moveViewFrom:(float)x
{
    CGRect frame = self.view.frame;
    if (x < kMainFrameXWhenRightToShow){
        frame.origin.x = kMainFrameXWhenRightIsShown;
    }
    else if (x > kMainFrameXWhenLeftToShow){
        frame.origin.x = kMainFrameXWhenLeftIsShown;
    }
    else
        frame.origin.x = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = frame;
    }];
}
//=================================================================================
- (void)moveOrResume:(float)x
{
    if (self.view.frame.origin.x == x)
        x = 0;
    [self moveViewFrom:x];
    if (x == kMainFrameXWhenLeftIsShown){
        [m_rootVC bringToFront:YES];
    }
    else if (x == kMainFrameXWhenRightIsShown){
        [m_rootVC bringToFront:NO];
    }
}
//=================================================================================
@end
