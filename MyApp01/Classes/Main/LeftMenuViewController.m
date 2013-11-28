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
#import "WebServiceClient.h"
#import "JSON.h"

@interface LeftMenuViewController ()<WebServiceClientDelegate>
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
//    [self InitTableView];
    //初始化 TableView 的資料
//    [self InitTableViewData];
    //初始化 View
    [self InitView];
    //初始化 Navigator bar
    [self InitNavigationbar];

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
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [cell.textLabel setText:[self.m_TableViewDataList objectAtIndex:indexPath.row]];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    
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
//    SliderRootViewController *SliderRootViewControllerObj = (SliderRootViewController*)self.parentViewController;
//    [SliderRootViewControllerObj LeftBackToMain];    
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
#pragma -
#pragma - WebServiceClientDelegate Methods
//=================================================================================
-(void) WebServiceClient: (WebServiceClient *) _vwscClient didCompleteQueryNearByHostpitalWithResponseCode: (NSString *) _sResponseCode withResponseMessage: (NSString *) _sResponseMessage  withVersionControllerResponse: (NSString *) _sResponseData
{
//    NSLog(@"responseString = %@",_sResponseData);
    id jsonObject = [_sResponseData JSONValue];
    
    NSMutableArray *mtaAllData = jsonObject;
    NSLog(@"mtaAllData = %@",mtaAllData);
    
//    for(NSMutableDictionary *Dict in mtaAllData)
//    {
//        DetailData* Data = [[DetailData alloc]Init];
//        Data.m_Name = [Dict objectForKey:@"hospital_name"];
//        Data.m_Addr = [Dict objectForKey:@"hospital_address"];
//        Data.m_Latituted = [Dict objectForKey:@"latitude"];
//        Data.m_Longtututed = [Dict objectForKey:@"longitude"];
//        [Data.m_mtaDocNames addObject:[Dict objectForKey:@"doctor_name"]];
//        Data.m_bBefore = NO;
//        Data.m_bMagzie = NO;
//        [self.m_mtaTableViewData addObject:Data];
//        NSLog(@"Data.m_Name = %@",Data.m_Name);
//    }
//    [self LoadAnnotation];
    NSMutableArray* mtaData = [NSMutableArray array];
    for(NSMutableDictionary *Dict in mtaAllData)
    {
        DetailData* Data = [[DetailData alloc]Init];
        Data.m_Addr = [Dict objectForKey:@"hospital_address"];
        Data.m_hospital_id = [Dict objectForKey:@"hospital_id"];
        Data.m_Name = [Dict objectForKey:@"hospital_name"];
        Data.m_hospital_phone = [Dict objectForKey:@"hospital_phone"];
        Data.m_Latituted = [Dict objectForKey:@"latitude"];
        Data.m_Longtututed = [Dict objectForKey:@"longitude"];
        
        Data.m_bBefore = NO;
        Data.m_bMagzie = NO;
        [mtaData addObject:Data];
        [Data release];
    }
    
    if(self.parentViewController)
    {
        if([self.parentViewController isKindOfClass:[SliderRootViewController class]])
        {
            SliderRootViewController* SliderRootViewControllerTemp = (SliderRootViewController*)self.parentViewController;
            [SliderRootViewControllerTemp AddMainVCAnnotationData:mtaData];
//            [SliderRootViewControllerTemp.m_mainVC leftSelected];
        }
    }
    [mtaAllData removeAllObjects];
}
//=================================================================================
#pragma -
#pragma - Custom Methods
//初始化 TableView 的資料
- (void)InitTableViewData
{
    self.m_TableViewDataList = [NSMutableArray array];
    //測試碼
//    [self.m_TableViewDataList addObject:@"國國國國國一"];
//    [self.m_TableViewDataList addObject:@"國國國國國二"];
//    [self.m_TableViewDataList addObject:@"國國國國國三"];
//    [self.m_TableViewDataList addObject:@"國國國國國四"];
//    [self.m_TableViewDataList addObject:@"國國國國國五"];
    //測試碼結束
}
//=================================================================================
//初始化 TableView
- (void)InitTableView
{
    float Height = 480;
    if(appDelegate.m_Constants.m_bIsIPhone5)
    {
        Height = 568;
    }
    self.m_TblView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Height) style:UITableViewStylePlain];
    [self.m_TblView setBackgroundColor:[UIColor clearColor]];

    
    UIImage *backgourndImg = [[UIImage imageNamed:@"bgcolor.PNG"]stretchableImageWithLeftCapWidth:5 topCapHeight:568];
    UIImageView *backgourndview = [[UIImageView alloc]initWithImage:backgourndImg];
    CGRect frame = backgourndview.frame;
    frame.size.width = 320;
    [backgourndview setFrame:frame];
    [self.m_TblView setBackgroundView:backgourndview];
    [backgourndview release];
    
    [self.m_TblView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.m_TblView setDataSource:self];
    [self.m_TblView setDelegate:self];
    self.view = self.m_TblView;
}
//=================================================================================
- (void)InitView
{
    float Height = 480;
    if(appDelegate.m_Constants.m_bIsIPhone5)
    {
        Height = 568;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, Height)];

    //設定背景
    UIImage *backgourndImg = [[UIImage imageNamed:@"bgcolor.PNG"]stretchableImageWithLeftCapWidth:5 topCapHeight:568];
    UIImageView *backgourndview = [[UIImageView alloc]initWithImage:backgourndImg];
    CGRect frame = backgourndview.frame;
    frame.size.width = 320;
    [backgourndview setFrame:frame];
    [view addSubview:backgourndview];
    [backgourndview release];
    //加入背景 Logo
    UIImageView *BgLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgLogo.PNG"]];
    CGRect RectofBgLogo = BgLogo.frame;
    RectofBgLogo.origin.x = 135;
    RectofBgLogo.origin.y = Height - 115 - 30;
    [BgLogo setFrame:RectofBgLogo];
    [view addSubview:BgLogo];
    [BgLogo release];
    //加入按鈕
    UIButton *btn;    
    float StartX = 0;
    float StartY = 64;
    float GapX = 10;
    float GapY = 10;
    int iCount = 0;
    for(int i = 0 ; i < 3 ; i++)
    {
        for(int j = 0 ; j < 3 ; j++)
        {
            iCount++;
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(StartX + (j * GapX) + 80 * j, StartY + (i * GapY) + 100 * i, 80, 100)];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btnDivision0%d.PNG",iCount]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btnDivision0%dClick.PNG",iCount]] forState:UIControlStateHighlighted];
            btn.tag = iCount + 100;
            [btn addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
        }
    }
    

    
    self.view = view;
    [view setBackgroundColor:[UIColor clearColor]];
    [view release];

}
//=================================================================================
- (void)InitNavigationbar
{    
    UIView *viewHeader = [[UIView alloc] initWithFrame: CGRectZero];
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame: CGRectMake(0.0f,0.0f, 320.0f, 44.0f)];
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle: appDelegate.m_Constants.m_LeftNavigationBarTitle];
    [navBar pushNavigationItem: navItem animated: YES];
    [navBar setBackgroundImage:[UIImage imageNamed:@"Head02.PNG"] forBarMetrics:UIBarMetricsDefault];    
    [viewHeader addSubview:navBar];
    [navBar release];
    [self.view addSubview:viewHeader];
    [viewHeader release];
    }
//=================================================================================
//當 View 離開時會做的事寫在這
//- (void)Hidden
//{
//    for (NSIndexPath *indexPath in self.m_TblView.indexPathsForSelectedRows) {
//        [self.m_TblView deselectRowAtIndexPath:indexPath animated:NO];
//    }
//}
//=================================================================================
//- (void)BackToMain
//{
//    SliderRootViewController* SliderRootVC = (SliderRootViewController*)self.parentViewController;
//
//    if([SliderRootVC.view isKindOfClass:[MainViewController class]])
//    {
//        [((MainViewController*)SliderRootVC.view) leftSelected];
//    }
//}
//=================================================================================
- (void)ButtonClicked:(id)_Sender
{
    UIButton* TempBtn = (UIButton*)_Sender;
    NSLog(@"TempBtn.tag = %d",TempBtn.tag);
    switch (TempBtn.tag) {
        case 101:
        {
            //內/家醫科
            [self QueryNearByHospitalDataWithSpecialtyID:@"1"];
        }
            break;
        case 102:
        {
            //外科
            [self QueryNearByHospitalDataWithSpecialtyID:@"2"];
        }
            break;
        case 103:
        {
            //耳鼻喉科
            [self QueryNearByHospitalDataWithSpecialtyID:@"3"];
        }
            break;
        case 104:
        {
            //皮膚醫美科
            [self QueryNearByHospitalDataWithSpecialtyID:@"4"];
        }
            break;
        case 105:
        {
            //眼科
            [self QueryNearByHospitalDataWithSpecialtyID:@"5"];
        }
            break;

        case 106:
        {
            //骨科
            [self QueryNearByHospitalDataWithSpecialtyID:@"6"];
        }
            break;
        case 107:
        {
            //婦兒科
            [self QueryNearByHospitalDataWithSpecialtyID:@"7"];
        }
        case 108:
        {
            //牙科
            [self QueryNearByHospitalDataWithSpecialtyID:@"8"];
        }
        case 109:
        {
            //中醫科
            [self QueryNearByHospitalDataWithSpecialtyID:@"9"];
        }

        default:
            break;
    }
}
//=================================================================================
- (void)QueryNearByHospitalDataWithSpecialtyID:(NSString*)ID
{
    [appDelegate QueryNearByHospitalDataWithSpecialtyID:ID withDelegate:self];
    
    SliderRootViewController* SliderRootViewControllerTemp = (SliderRootViewController*)self.parentViewController;
    [SliderRootViewControllerTemp.m_mainVC leftSelected];
}
//=================================================================================

@end


















