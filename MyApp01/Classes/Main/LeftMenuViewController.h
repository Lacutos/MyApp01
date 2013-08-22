//
//  LeftMenuViewController.h
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController
<
UITableViewDataSource,
UITableViewDelegate
>
{
    NSMutableArray  *m_TableViewDataList;
    UITableView     *m_TblView;
}
@property(nonatomic, retain) NSMutableArray     *m_TableViewDataList;
@property(nonatomic, retain) UITableView        *m_TblView;
//當 View 離開時會做的事寫在這
- (void)Hidden;
@end
