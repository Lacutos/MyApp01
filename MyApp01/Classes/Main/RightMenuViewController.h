//
//  RightMenuViewController.h
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightMenuViewController : UIViewController
<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate
>
{
    NSMutableArray  *m_TableViewDataList;
    UITableView     *m_TblView;
}
@property(nonatomic, retain) NSMutableArray     *m_TableViewDataList;
@property(nonatomic, retain) UITableView        *m_TblView;
@end
