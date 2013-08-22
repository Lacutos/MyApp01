//
//  ListTableViewController.h
//  MyApp01
//
//  Created by Lacutos on 13/6/27.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewController : UITableViewController
//<
//UITableViewDataSource,
//UITableViewDelegate
//>
{
    NSMutableArray  *m_mtaData;
}
@property(nonatomic, retain)NSMutableArray  *m_mtaData;
@end
