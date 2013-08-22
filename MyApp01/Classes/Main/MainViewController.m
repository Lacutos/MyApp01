//
//  MainViewController.m
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "MainViewController.h"
#import "MainNavigationController.h"
#import "Constants.h"
#import "CustomAnnotation.h"
#import "AppDelegate.h"
#import "DetailData.h"
#import "DetailViewController.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "SliderRootViewController.h"

#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)

@interface MainViewController ()
- (void)LoadAnnotation;
- (void)InitMap;
- (void)InitList;
- (void)AddRadar;
- (void)RotateRadar:(CLLocationDirection)Heading;
- (void)AddTestDatas;
@end

@implementation MainViewController
@synthesize m_bIsMap;
@synthesize m_TableView;
@synthesize m_mtaTableViewData;


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
    self.m_bIsMap = YES;
    self.navigationItem.title = @"地圖模式";
    //初始化地圖
    [self InitMap];
    //更新 GPS 位置
    [appDelegate.m_locationManager startUpdatingLocation];

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStyleBordered target:self action:@selector(leftSelected)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStyleBordered target:self action:@selector(rightSelected)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
//    [self AddRadar];
    
    //初始化列表
    [self InitList];
    
    //測試螞
    [self AddTestDatas];
    //測試碼結束
//    [appDelegate.m_locationManager startUpdatingHeading];
    
//    UIView *TestView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 320, 480)];
//    [TestView setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:TestView];
//    
//    
//    UILabel *TestLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 50, 50)];
//    [TestLabel1 setBackgroundColor:[UIColor redColor]];
//    [TestView addSubview:TestLabel1];
//    
//    UILabel *TestLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 50, 50)];
//    [TestLabel2 setBackgroundColor:[UIColor blueColor]];
//    [TestView addSubview:TestLabel2];
//    
//    UIView *TestView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 480)];
//    [TestView2 setBackgroundColor:[UIColor whiteColor]];
//
//    [TestView addSubview:TestView2];
//    [TestView sendSubviewToBack:TestView2];

}
- (void)dealloc
{
    [self.m_TableView release];
    if(nil != m_mtaTableViewData)
    {
        [m_mtaTableViewData removeAllObjects];
    }
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark CLLocationManagerDelegate methods
-(void) locationManager: (CLLocationManager *) manager didUpdateToLocation: (CLLocation *) newLocation fromLocation: (CLLocation *) oldLocation {
    [appDelegate.m_locationManager stopUpdatingLocation];
    
    MKCoordinateRegion regionCenter;
    regionCenter.center.latitude = newLocation.coordinate.latitude;
    regionCenter.center.longitude = newLocation.coordinate.longitude;
    regionCenter.span = MKCoordinateSpanMake(regionCenter.center.latitude, regionCenter.center.longitude);
    MKCoordinateSpan spanDefault;
    
    spanDefault.latitudeDelta = appDelegate.m_Constants.m_UserLatitudeDeltaDefault;
    spanDefault.longitudeDelta = appDelegate.m_Constants.m_UserLongitudeDeltaDefault;
    regionCenter.span = spanDefault;
    
    
    [appDelegate.m_SingletonMapView setShowsUserLocation:YES];
    [appDelegate.m_SingletonMapView setRegion:regionCenter];
    
    appDelegate.m_UserCoor = newLocation;
    
    
    [self LoadAnnotation];
}
//=================================================================================
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
//    [appDelegate.m_locationManager stopUpdatingHeading];
//    [self RotateRadar:newHeading.trueHeading];
}
//=================================================================================
#pragma mark - MKMapViewDelegate methods
-(void) mapView: (MKMapView *) mapView annotationView: (MKAnnotationView *) view calloutAccessoryControlTapped: (UIControl *) control {

    
    if([self.navigationController isKindOfClass:[MainNavigationController class]])
    {
        MainNavigationController *MainVC = (MainNavigationController*)self.navigationController;
        [MainVC.m_rootVC ShowChildeViews:NO];
    }
    DetailViewController   *DetailVC = [DetailViewController alloc];
    [self.navigationController pushViewController:DetailVC animated:YES];

    
//    LeftMenuViewController *LeftMenuVC = [MainVC.m_rootVC.childViewControllers objectAtIndex:1];
//    [LeftMenuVC.view setHidden:YES];
//    
//    RightMenuViewController *RightMenuVC = [MainVC.m_rootVC.childViewControllers objectAtIndex:2];
//    [RightMenuVC.view setHidden:YES];
    
//    [self.navigationController pushViewController:DetailVC animated:YES];

//    self.navigationController.vi
//    if([self.parentViewController isKindOfClass:[MainNavigationController class]])
//    {
//        NSLog(@"Test");
//    }
//    if([self.navigationController isKindOfClass:[MainNavigationController class]])
//    {
//        NSLog(@"Test");
//    }
    
//    [DetailVC release];
}
//=================================================================================
-(MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id <MKAnnotation>) annotation {
    if([annotation isKindOfClass:[MKUserLocation class]])
		return nil;
    MKPinAnnotationView *pinView = nil;
    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
		pinView = [[[MKPinAnnotationView alloc]
                    initWithAnnotation:annotation
                    reuseIdentifier:[NSString stringWithFormat:@"%d",((CustomAnnotation*) annotation).tag]] autorelease];
		pinView.pinColor = MKPinAnnotationColorGreen;
		pinView.animatesDrop = YES;
		pinView.canShowCallout = YES;
		pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	}
    return pinView;
}
//=================================================================================
#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor lightGrayColor]];
}
//=================================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.m_mtaTableViewData count];
}
//=================================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainCell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if(nil != cell)
    {
        for(UIView* view in cell.subviews)
        {
            [view removeFromSuperview];
        }
    }
    DetailData  *Data = [self.m_mtaTableViewData objectAtIndex:indexPath.row];
    UILabel *lblClinicName = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
    [lblClinicName setText:Data.m_Name];
    [lblClinicName setTextColor:[UIColor blackColor]];
    [lblClinicName setBackgroundColor:[UIColor clearColor]];
    [lblClinicName setFont:appDelegate.m_Constants.m_FONT_19_BOLD];
    [cell addSubview:lblClinicName];
    
    UILabel *lblAddr = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 240, 60)];
    [lblAddr setText:Data.m_Addr];
    [lblAddr setTextColor:[UIColor blackColor]];
    [lblAddr setBackgroundColor:[UIColor clearColor]];
    [lblAddr setFont:appDelegate.m_Constants.m_FONT_15_NONE];
    [cell addSubview:lblAddr];

    UILabel *lblDistance = [[UILabel alloc]initWithFrame:CGRectMake(270, 60, 300, 50)];

    CLLocation* TempLocation = [[CLLocation alloc]initWithLatitude:[Data.m_Latituted doubleValue] longitude:[Data.m_Longtututed doubleValue]];
    CLLocation* MyLocation = [[CLLocation alloc]initWithLatitude:appDelegate.m_UserCoor.coordinate.latitude longitude:appDelegate.m_UserCoor.coordinate.longitude];
    CLLocationDistance TempDistance = [MyLocation distanceFromLocation:TempLocation];
    
    TempDistance = (TempDistance / 1000.0f);
    TempDistance = (int)(TempDistance * 10);
    TempDistance = TempDistance / 10;
    
    NSString *KM = [NSString stringWithFormat:@"%0.1fKM",TempDistance];
    NSLog(@"sKM = %@",KM);
    
    [lblDistance setTextColor:[UIColor blackColor]];
    [lblDistance setBackgroundColor:[UIColor clearColor]];
    [lblDistance setFont:appDelegate.m_Constants.m_FONT_15_NONE];
    [lblDistance setText:KM];
    [cell addSubview:lblDistance];
    
//    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    return cell;
}
//=================================================================================
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
//=================================================================================
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.navigationController isKindOfClass:[MainNavigationController class]])
    {
        MainNavigationController *MainVC = (MainNavigationController*)self.navigationController;
        [MainVC.m_rootVC ShowChildeViews:NO];
    }
    DetailViewController   *DetailVC = [DetailViewController alloc];
    [self.navigationController pushViewController:DetailVC animated:YES];
}
//=================================================================================
#pragma mark - Custom Methods
- (void)leftSelected
{
    MainNavigationController *nav = (MainNavigationController *)self.navigationController;
    [nav moveOrResume:kMainFrameXWhenLeftIsShown];
    
    [nav.m_rootVC bringToFront:YES];
//    [self.view setHidden:YES];
}
//=================================================================================
- (void)rightSelected
{
    MainNavigationController *nav = (MainNavigationController *)self.navigationController;
    [nav moveOrResume:kMainFrameXWhenRightIsShown];
}
//=================================================================================
//載入地圖大頭針
- (void)LoadAnnotation
{
    NSMutableArray *mtaAnnotations = [NSMutableArray array];
    for(DetailData *Data in self.m_mtaTableViewData)
    {        
        CLLocation *location = [[CLLocation alloc]initWithLatitude:[Data.m_Latituted floatValue]
                                                         longitude:[Data.m_Longtututed floatValue]];
        CustomAnnotation *annotation = [[CustomAnnotation alloc]
                                        initWithCoordinate:location.coordinate
                                        title:Data.m_Name
                                        subtitle:Data.m_Addr];
        [mtaAnnotations addObject:annotation];
//        [annotation release];
    }
    [appDelegate.m_SingletonMapView  addAnnotations:mtaAnnotations];
//    [mtaAnnotations removeAllObjects];
//    [mtaAnnotations release];
    
//    CLLocationCoordinate2D Coordinate;
//    Coordinate.latitude = 25.042322;
//    Coordinate.longitude = 121.533669;

//    CLLocation *location = [[CLLocation alloc]initWithLatitude:25.042322 longitude:121.533669];
//    CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithCoordinate:location.coordinate title:@"TestTitle" subtitle:@"TestSubTitle"];
//    [appDelegate.m_SingletonMapView addAnnotation:annotation];
//    [annotation release];
//    
//    [appDelegate.m_SingletonMapView addAnnotation:annotation];
}
//=================================================================================

//初始化地圖
- (void)InitMap
{
    MKCoordinateRegion regionCenter;
    regionCenter.center.latitude = 25.045578;
    regionCenter.center.longitude = 121.523324;
    [appDelegate.m_SingletonMapView setRegion:regionCenter];
    [self.view addSubview:appDelegate.m_SingletonMapView];
    [appDelegate.m_SingletonMapView setHidden:NO];
    [appDelegate.m_SingletonMapView setDelegate:self];
    [appDelegate.m_locationManager setDelegate:self];
}
//=================================================================================
//測試加入雷達圖
- (void)AddRadar
{
    UIImageView *Radar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"map_direction_bg"]];
    Radar.frame = CGRectMake(Radar.frame.origin.x,
                             Radar.frame.origin.y,
                             Radar.frame.size.width / 2,
                             Radar.frame.size.height / 2);
    

//    CGAffineTransform transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));
//    Radar.transform = transform;

    
    Radar.tag = 201;
    [self.view addSubview:Radar];
    [Radar release];
}
//=================================================================================
//測試旋轉雷達圖
- (void)RotateRadar:(CLLocationDirection)Heading
{
    UIImageView *Radar = (UIImageView*)[self.view viewWithTag:201];
    if(nil == Radar)return;
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(Heading));
    Radar.transform = transform;
}
//=================================================================================
- (void)RotateRadarBG:(CLLocationDirection)Heading
{
//    CGAffineTransform transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(Heading));
//    Radar.transform = transform;

}
//=================================================================================
- (void)SwitchMapOrList
{
    if(self.m_bIsMap)
    {
        //列表
        self.m_bIsMap = NO;
        [self.m_TableView reloadData];
        self.navigationItem.title = @"列表模式";        
    }
    else
    {
        //地圖
        self.m_bIsMap = YES;
        self.navigationItem.title = @"地圖模式";
        
    }
    
    // 處理「地圖」、「列表」動畫
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations: nil context: context];
    
    if (self.m_bIsMap)
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView: self.view cache: YES];
    else
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView: self.view cache: YES];
    
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.8];
    
    appDelegate.m_SingletonMapView.hidden = ! appDelegate.m_SingletonMapView.hidden;
    self.m_TableView.hidden = !self.m_TableView.hidden;
    
    [UIView commitAnimations];

}
//=================================================================================
- (void)SwitcToList
{
    if(!self.m_bIsMap)return;
    self.m_bIsMap = NO;
    [self.m_TableView reloadData];
    self.navigationItem.title = @"列表模式";

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations: nil context: context];
    
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView: self.view cache: YES];
    
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.8];
    
    appDelegate.m_SingletonMapView.hidden = ! appDelegate.m_SingletonMapView.hidden;
    self.m_TableView.hidden = !self.m_TableView.hidden;
    
    [UIView commitAnimations];
}
//=================================================================================
- (void)InitList
{
    if(nil == self.m_mtaTableViewData)
    {
        self.m_mtaTableViewData = [NSMutableArray array];
    }
    float fHeight = 480;
    if(appDelegate.m_Constants.m_bIsIPhone5)
        fHeight = 596;
    self.m_TableView = [[ListTable alloc]initWithFrame:CGRectMake(0, 0, 320, fHeight)];
    [self.view addSubview:self.m_TableView];
    self.m_TableView.hidden = YES;
    [self.m_TableView setDelegate:self];
    [self.m_TableView setDataSource:self];
}
//=================================================================================
- (void)AddData:(DetailData*)Data
{
    if(nil == self.m_mtaTableViewData)
        return;
    [self.m_mtaTableViewData addObject:Data];
}
//=================================================================================
- (void)AddTestDatas
{
    DetailData* Data = [[DetailData alloc]Init];
    Data.m_Name = @"第一耳鼻喉科";
    Data.m_Addr = @"台北市中山北路一段123號";
    Data.m_Latituted = @"25.042322";
    Data.m_Longtututed = @"121.533669";
    
    [Data.m_mtaDocNames addObject:[NSString stringWithFormat:@"%@",@"金城武"]];
    [Data.m_mtaDocNames addObject:[NSString stringWithFormat:@"%@",@"梁家輝"]];
    
    Data.m_bBefore = NO;
    Data.m_bMagzie = NO;
    
    [self.m_mtaTableViewData addObject:Data];
    [Data release];
    
    Data = [[DetailData alloc]Init];
    
    Data.m_Name = @"第二眼科";
    Data.m_Addr = @"台北市林森北路二段456號";
    Data.m_Latituted = @"25.043605";
    Data.m_Longtututed = @"121.533151";
    
    [Data.m_mtaDocNames addObject:[NSString stringWithFormat:@"%@",@"金士傑"]];
    [Data.m_mtaDocNames addObject:[NSString stringWithFormat:@"%@",@"顧寶明"]];
    
    Data.m_bBefore = YES;
    Data.m_bMagzie = NO;
    [self.m_mtaTableViewData addObject:Data];
    [Data release];

}
//=================================================================================
@end































