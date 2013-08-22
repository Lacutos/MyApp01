//
//  DetailViewController.h
//  MyApp01
//
//  Created by Lacutos on 13/6/27.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface DetailViewController : UIViewController
<
UITableViewDataSource,
UITableViewDelegate
>
{
    NSString        *m_ClinicName;
    NSString        *m_ClinicAddr;
    NSMutableArray  *m_mtaComments;
    NSMutableArray  *m_mtaEvaluation;
    int             m_selectedView;
}
@property(nonatomic, retain) NSString*      m_ClinicName;
@property(nonatomic, retain) NSString*      m_ClinicAddr;
@property(nonatomic, retain) NSMutableArray *m_mtaComments;
@property(nonatomic, retain) NSMutableArray *m_mtaEvaluation;
@property(nonatomic, assign) int            m_selectedView;
@end













