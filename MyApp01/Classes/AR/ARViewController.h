//
//  ARViewController.h
//  MyApp01
//
//  Created by Lacutos on 13/6/25.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARViewController : UIViewController
{
    UIImagePickerController *m_cameraController;
}
@property(nonatomic, retain)UIImagePickerController *m_cameraController;
@end
