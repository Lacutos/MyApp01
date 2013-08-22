//
//  RightMenuViewController.m
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "RightMenuViewController.h"
#import "AppDelegate.h"
#import "SliderRootViewController.h"
@interface RightMenuViewController ()
- (void)Init;
- (void)InitTableView;
- (void)InitTableViewData;
- (void)chick_Switch:(id) sender;
@end

@implementation RightMenuViewController
@synthesize m_TblView;
@synthesize m_TableViewDataList;
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
    
    [self Init];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.m_TblView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -
#pragma - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
//=================================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"RightMenu";
	UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    for(UIView *view in cell.subviews)
    {
        if([view isKindOfClass:[UISwitch class]])
        {
            [view removeFromSuperview];
        }
    }
    
    if(0 == indexPath.row)
    {
        
        SliderRootViewController* SliderRootVC = (SliderRootViewController*)self.parentViewController;
        if([SliderRootVC MapOrList])
            [cell.textLabel setText:@"          列表顯示"];
        else
            [cell.textLabel setText:@"          地圖顯示"];

        [cell.textLabel setFont:appDelegate.m_Constants.m_FONT_19_BOLD];
    }
    else if(1 == indexPath.row)
    {
        
        [cell.textLabel setText:@"          只顯示去過的"];
        [cell.textLabel setFont:appDelegate.m_Constants.m_FONT_19_BOLD];
        UISwitch *Switch = [[UISwitch alloc]initWithFrame:CGRectMake(220, 10, 40, 24)];
        [cell addSubview:Switch];
        Switch.tag = 301;
        cell.accessoryView = Switch;
        [Switch addTarget:self action:@selector(chick_Switch:) forControlEvents:UIControlEventValueChanged];
        [Switch release];
        
    }
    else if(2 == indexPath.row)
    {
        [cell.textLabel setText:@"          只顯示商周良醫"];
        [cell.textLabel setFont:appDelegate.m_Constants.m_FONT_19_BOLD];
        UISwitch *Switch = [[UISwitch alloc]initWithFrame:CGRectMake(220, 10, 40, 24)];
        [cell addSubview:Switch];        
        Switch.tag = 302;
        cell.accessoryView = Switch;
        [Switch addTarget:self action:@selector(chick_Switch:) forControlEvents:UIControlEventValueChanged];
        [Switch release];

    }
    cell.backgroundColor = [UIColor whiteColor];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
//    [cell.textLabel setText:[self.m_TableViewDataList objectAtIndex:indexPath.row]];
//    [cell.textLabel setTextAlignment:NSTextAlignmentRight];
    
    return cell;
}
//=================================================================================
#pragma -
#pragma - UITableViewDelegate
//=================================================================================
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(0 == indexPath.row)
    {
        [self.m_TblView deselectRowAtIndexPath:indexPath animated:NO];
        SliderRootViewController *SliderRootViewControllerObj = (SliderRootViewController*)self.parentViewController;
        [SliderRootViewControllerObj RightdidselectedRowAtIndexPath];
        
        [self.m_TblView reloadData];
    }
}
//=================================================================================
-(CGFloat) tableView: (UITableView *) tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}
//=================================================================================
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame: CGRectZero];
    //初始化 搜尋列
    UITextField *textFieldSearch = [[UITextField alloc]initWithFrame:CGRectMake(44, 6, 200, 28)];
    [textFieldSearch setBorderStyle:UITextBorderStyleRoundedRect];
    [textFieldSearch setPlaceholder:@"搜尋"];
    [textFieldSearch setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [textFieldSearch setDelegate:self];
    [viewHeader addSubview: textFieldSearch];
    [textFieldSearch release];
    //初始化 搜尋鈕
    UIButton    *btnSearch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSearch.frame = CGRectMake(250, 6, 60, 28);
    [btnSearch setTitle:appDelegate.m_Constants.m_SEARCHBTN_TITLE forState:UIControlStateNormal];
    [btnSearch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSearch setBackgroundColor:[UIColor clearColor]];
    [viewHeader addSubview: btnSearch];
    [btnSearch release];
    
    return viewHeader;
}
//=================================================================================
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    [cell.detailTextLabel setTextColor:[UIColor clearColor]];

    //設定 cell 黑灰交錯顯示
//    if(0 == indexPath.row % 2)
//    {
//        [cell setBackgroundColor:[UIColor whiteColor]];
//        [cell.textLabel setBackgroundColor:[UIColor whiteColor]];
//        [cell.textLabel setTextColor:[UIColor blackColor]];
//    }
//    else
//    {
//        [cell setBackgroundColor:[UIColor grayColor]];
//        [cell.textLabel setBackgroundColor:[UIColor grayColor]];
//        [cell.textLabel setTextColor:[UIColor whiteColor]];
//    }
}
//=================================================================================
#pragma mark -
#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];	
	return YES;
}

//=================================================================================
#pragma -
#pragma - Custom Methods
- (void)Init
{
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self InitTableView];
//    [self InitTableViewData];
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
//當 View 離開時會做的事寫在這
- (void)Hidden
{
    NSLog(@"Test");
}
//=================================================================================
//當點擊 Switch 時
- (void)chick_Switch:(id) _sender
{
    UISwitch* Switch = (UISwitch*)_sender;
    
    if(301 == Switch.tag)
    {
        //設定顯示去過的
    }
    else if(302 == Switch.tag)
    {
        //設定顯示商周良醫
    }
}
//=================================================================================
@end


































