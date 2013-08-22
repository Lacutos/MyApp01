//
//  LeftMenuViewController.m
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "AppDelegate.h"
#import "MainNavigationController.h"
#import "SliderRootViewController.h"
#import "MainViewController.h"
#import "ListTableViewController.h"


@interface LeftMenuViewController ()
- (void)InitTableViewData;
- (void)InitTableView;
- (void)BackToMain;
@end

@implementation LeftMenuViewController
@synthesize m_TableViewDataList;
@synthesize m_TblView;

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
    
    //初始化 TableView
    [self InitTableView];
    //初始化 TableView 的資料
    [self InitTableViewData];
    //初始化 Navigator bar

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated
{
//    UITableViewCell *cell = [self.m_TblView cellForRowAtIndexPath:0];
//    cell.selectionStyle = UITableViewCellEditingStyleNone;

}
- (void)dealloc
{
    [self.m_TableViewDataList removeAllObjects];
    [self.m_TableViewDataList release];
    [self.m_TblView release];
    [super dealloc];
}
//=================================================================================
#pragma - 
#pragma - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.m_TableViewDataList count];
}
//=================================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"LeftMenu";
	UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    [cell.textLabel setText:[self.m_TableViewDataList objectAtIndex:indexPath.row]];
    
    return cell;
}
//=================================================================================
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(0 == indexPath.row % 2)
    {
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.textLabel setBackgroundColor:[UIColor whiteColor]];
        [cell.textLabel setTextColor:[UIColor blackColor]];
    }
    else
    {
        [cell setBackgroundColor:[UIColor grayColor]];
        [cell.textLabel setBackgroundColor:[UIColor grayColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
    }
}
//=================================================================================
#pragma -
#pragma - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SliderRootViewController *SliderRootViewControllerObj = (SliderRootViewController*)self.parentViewController;
    [SliderRootViewControllerObj LeftBackToMain];
    

    

    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"accountservice://mtest.esunbank.com.tw/m/max/vzf1.aspx"]];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"AccountService://mtest.esunbank.com.tw/m/max/V406.aspx"]];
//    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: SCHEMA_STOCKAPP]];
    
}
//=================================================================================
-(CGFloat) tableView: (UITableView *) tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}
//=================================================================================
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame: CGRectZero];
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame: CGRectMake(0.0f,0.0f, 320.0f, 44.0f)];
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle: appDelegate.m_Constants.m_LeftNavigationBarTitle];
    [navBar pushNavigationItem: navItem animated: YES];    
    [viewHeader addSubview: navBar];
    return viewHeader;
}
//=================================================================================

#pragma - 
#pragma - Custom Methods
//初始化 TableView 的資料
- (void)InitTableViewData
{
    self.m_TableViewDataList = [NSMutableArray array];
    //測試碼
    [self.m_TableViewDataList addObject:@"國國國國國一"];
    [self.m_TableViewDataList addObject:@"國國國國國二"];
    [self.m_TableViewDataList addObject:@"國國國國國三"];
    [self.m_TableViewDataList addObject:@"國國國國國四"];
    [self.m_TableViewDataList addObject:@"國國國國國五"];
    //測試碼結束
}
//=================================================================================
//初始化 TableView
- (void)InitTableView
{
    self.m_TblView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    [self.m_TblView setBackgroundColor:[UIColor clearColor]];
    [self.m_TblView setDataSource:self];
    [self.m_TblView setDelegate:self];
    self.view = self.m_TblView;
}
//=================================================================================
//當 View 離開時會做的事寫在這
- (void)Hidden
{
    for (NSIndexPath *indexPath in self.m_TblView.indexPathsForSelectedRows) {
        [self.m_TblView deselectRowAtIndexPath:indexPath animated:NO];
    }
}
//=================================================================================
- (void)BackToMain
{
    SliderRootViewController* SliderRootVC = (SliderRootViewController*)self.parentViewController;

    if([SliderRootVC.view isKindOfClass:[MainViewController class]])
    {
        [((MainViewController*)SliderRootVC.view) leftSelected];
    }
}
//=================================================================================
@end


















