//
//  DetailViewController.m
//  MyApp01
//
//  Created by Lacutos on 13/6/27.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
@interface DetailViewController ()
- (void)InitTopView;
- (void)InitMidView;
- (void)InitClinicDataView;
- (void)InitCommentView;
- (void)InitEvaluationView;
- (void)BtnFunction:(id)_Sender;
- (void)ShowConetent:(int)index;
@end

@implementation DetailViewController
@synthesize m_ClinicName;
@synthesize m_ClinicAddr;
@synthesize m_mtaComments;
@synthesize m_mtaEvaluation;
@synthesize m_selectedView;

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
    
    //測試碼
//    self.m_ClinicName = @"順暢腸胃科";
//    self.m_ClinicAddr = @"這是診所的地址，總共的長度是二十個中文字";
    //測試碼結束
    [self InitTopView];
    [self InitMidView];
    [self InitClinicDataView];
    [self InitCommentView];
    [self InitEvaluationView];
    [self ShowConetent:self.m_selectedView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//=================================================================================
- (void)dealloc
{
    [self.m_mtaComments release];
    [self.m_mtaEvaluation release];
    [super dealloc];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
//=================================================================================
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(1 == self.m_selectedView)
    {
        return [self.m_mtaComments count];
    }
    else if(2 == self.m_selectedView)
    {
        return [self.m_mtaEvaluation count];
    }
    return 0;
}
//=================================================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"LeftMenu";
	UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    for(UIView *view in cell.subviews)
    {
        if([view isKindOfClass:[UILabel class]])
        {
            [view removeFromSuperview];
        }
    }
    
    [cell setBackgroundColor:[UIColor grayColor]];
    
    if(1 == self.m_selectedView)
    {
        DetailCommentData *Data = [self.m_mtaComments objectAtIndex:indexPath.row];
        
        UILabel *lblType = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 160, 30)];
        [lblType setTextColor:[UIColor whiteColor]];
        [lblType setBackgroundColor:[UIColor clearColor]];
        if(0 == Data.m_Type)
            [lblType setText:@"看病紀錄"];
        else
            [lblType setText:@"推薦"];
        [cell addSubview:lblType];

        UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 240, 50)];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [lblTitle setTextColor:[UIColor whiteColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setText:Data.m_Description];
        [cell addSubview:lblTitle];
        
        UILabel *lblRecommand = [[UILabel alloc]initWithFrame:CGRectMake(280, 10, 40, 40)];
        [lblRecommand setBackgroundColor:[UIColor clearColor]];
        if(Data.m_Recommand)
            [lblRecommand setText:@"O"];
        else
            [lblRecommand setText:@"X"];
        [cell addSubview:lblRecommand];
        
    }
    else if(2 == self.m_selectedView)
    {
        DetailWeb  *Data = [self.m_mtaEvaluation objectAtIndex:indexPath.row];
        
        UILabel *lblFrom = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 160, 30)];
        [lblFrom setBackgroundColor:[UIColor clearColor]];
        [lblFrom setTextColor:[UIColor whiteColor]];
        [lblFrom setText:Data.m_From];
        [cell addSubview:lblFrom];
        
        UILabel *lblDesc = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 240, 90)];
        [lblDesc setNumberOfLines:0];
        [lblDesc setBackgroundColor:[UIColor clearColor]];
        [lblDesc setTextColor:[UIColor whiteColor]];
        [lblDesc setText:Data.m_Desc];
        [cell addSubview:lblDesc];        
    }
    
    return cell;

}
//=================================================================================
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor grayColor]];
}
//=================================================================================
#pragma mark - Customize Methods
//=================================================================================
//初始化上方的 view
- (void)InitTopView
{
    //上方的 View
    UIView* TopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 110)];
    TopView.tag = 101;
    
//    [TopView setBackgroundColor:[UIColor clearColor]];
    UIImage* BackGroundImg = [UIImage imageNamed:@"mainDownBlock.PNG"];
    
    UIImageView* imgView = [[UIImageView alloc]initWithImage:BackGroundImg];
    [TopView addSubview:imgView];
    [TopView sendSubviewToBack:imgView];
    [imgView release];
    
    
//    [TopView setBackgroundColor:[UIColor clearColor]];
//    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"mainDownBlock.PNG"]];
//    TopView.backgroundColor = background;
//    [background release];
    //左上角關閉鈕
    UIButton    *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose setBackgroundColor:[UIColor clearColor]];
    [btnClose setTitle:@"X" forState:UIControlStateNormal];
    [btnClose.titleLabel setFont:appDelegate.m_Constants.m_FONT_19_BOLD];
    [btnClose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(BtnFunction:) forControlEvents:UIControlEventTouchUpInside];
    btnClose.frame = CGRectMake(5, 5, 20, 20);
    [btnClose setTag:1010];
    [TopView addSubview:btnClose];
    
    //打電話按鈕
    UIButton    *btnCall = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCall setImage:[UIImage imageNamed:@"btnCall.PNG"] forState:UIControlStateNormal];
    [btnCall setImage:[UIImage imageNamed:@"btnCallClick.PNG"] forState:UIControlStateHighlighted];    
    [btnCall setBackgroundColor:[UIColor clearColor]];
    [btnCall setTag:1011];
    btnCall.frame = CGRectMake(220, 5, 100, 100);
    [TopView addSubview:btnCall];
    //商週推薦標籤
    UILabel     *lblRecommand = [[UILabel alloc]initWithFrame:CGRectMake(190, 5, 30, 30)];
    [lblRecommand setBackgroundColor:[UIColor redColor]];
    [lblRecommand setTag:1012];
    [TopView addSubview:lblRecommand];
    [TopView addSubview:lblRecommand];
    //有去過標籤
    UILabel     *lblGone = [[UILabel alloc]initWithFrame:CGRectMake(160, 5, 30, 30)];
    [lblGone setBackgroundColor:[UIColor blueColor]];
    [lblGone setTag:1013];
    [TopView addSubview:lblGone];
    //我的最愛標籤
    UILabel     *lblFaverite = [[UILabel alloc]initWithFrame:CGRectMake(130, 5, 30, 30)];
    [lblFaverite setBackgroundColor:[UIColor orangeColor]];
    [lblFaverite setTag:1014];
    [TopView addSubview:lblFaverite];
    //診所名
    UILabel     *ClinicName = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 150, 60)];
    [ClinicName setBackgroundColor:[UIColor clearColor]];
    [ClinicName setTextColor:[UIColor whiteColor]];
    [ClinicName setTag:1015];
    [ClinicName setText:self.m_ClinicName];
    [TopView addSubview:ClinicName];
    [ClinicName setFont:appDelegate.m_Constants.m_FONT_24_BOLD];
    //診所地址
    UILabel     *ClinicAddr = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 200, 40)];
    [ClinicAddr setBackgroundColor:[UIColor clearColor]];
    [ClinicAddr setTextColor:[UIColor whiteColor]];
    [ClinicAddr setTag:1016];
    [ClinicAddr setNumberOfLines:0];
    [ClinicAddr setText:self.m_ClinicAddr];
    [ClinicAddr setFont:appDelegate.m_Constants.m_FONT_15_NONE];
    [TopView addSubview:ClinicAddr];
    
    [self.view addSubview:TopView];
    [TopView release];
    
}
//=================================================================================
- (void)InitMidView
{
    UIView  *MidView = [[UIView alloc]initWithFrame:CGRectMake(0, 110, 320, 60)];
    MidView.tag = 201;
    [MidView setBackgroundColor:[UIColor lightGrayColor]];
    
    UIButton    *btnClinicData = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClinicData setFrame:CGRectMake(40, 10, 80, 40)];
    [btnClinicData setTitle:appDelegate.m_Constants.m_DetailMainBtn_ClinicData forState:UIControlStateNormal];
    [btnClinicData setBackgroundColor:[UIColor whiteColor]];
    [btnClinicData setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnClinicData setTag:2011];
    [btnClinicData addTarget:self action:@selector(BtnFunction:) forControlEvents:UIControlEventTouchUpInside];
    [MidView addSubview:btnClinicData];
    
    
    UIButton    *btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnComment setFrame:CGRectMake(120, 10, 80, 40)];
    [btnComment setTitle:appDelegate.m_Constants.m_DetailMainBtn_Comment forState:UIControlStateNormal];
    [btnComment setBackgroundColor:[UIColor whiteColor]];
    [btnComment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnComment setTag:2012];
    [btnComment addTarget:self action:@selector(BtnFunction:) forControlEvents:UIControlEventTouchUpInside];
    [MidView addSubview:btnComment];
    
    UIButton    *btnEvaluate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnEvaluate setFrame:CGRectMake(200, 10, 80, 40)];
    [btnEvaluate setTitle:appDelegate.m_Constants.m_DetailMainBtn_Evaluate forState:UIControlStateNormal];
    [btnEvaluate setBackgroundColor:[UIColor whiteColor]];
    [btnEvaluate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnEvaluate setTag:2013];
    [btnEvaluate addTarget:self action:@selector(BtnFunction:) forControlEvents:UIControlEventTouchUpInside];
    [MidView addSubview:btnEvaluate];
    
    [self.view addSubview:MidView];
    [MidView release];
}
//=================================================================================
- (void)InitClinicDataView
{
    float Height = 480;
    if(appDelegate.m_Constants.m_bIsIPhone5)
    {
        Height = 564;
    }

    UITableView *CommentView = [[UITableView alloc]initWithFrame:CGRectMake(0, 170, 320, Height)];
    [CommentView setTag:301];
    
    [CommentView setDelegate:self];
    [CommentView setDataSource:self];
    
    
    [CommentView setHidden:YES];
    [self.view addSubview:CommentView];

}
//=================================================================================
- (void)InitCommentView
{
    float Height = 480;
    if(appDelegate.m_Constants.m_bIsIPhone5)
    {
        Height = 564;
    }
    self.m_mtaComments = [NSMutableArray array];
    
    //測試碼
    DetailCommentData *Data = [DetailCommentData alloc];
    Data.m_Description = @"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十";
    Data.m_Recommand = YES;
    Data.m_Type = 0;
    [self.m_mtaComments addObject:Data];
//    [Data release];
    
    Data = [DetailCommentData alloc];
    Data.m_Description = @"十九八七六五四三二一十九八七六五四三二一十九八七六五四三二一";
    Data.m_Recommand = NO;
    Data.m_Type = 1;    
    [self.m_mtaComments addObject:Data];
//    [Data release];

    //測試碼結束
    
    UITableView *CommentView = [[UITableView alloc]initWithFrame:CGRectMake(0, 170, 320, Height)];
    [CommentView setTag:401];
    
    [CommentView setDelegate:self];
    [CommentView setDataSource:self];
    
    
    [CommentView setHidden:YES];
    [self.view addSubview:CommentView];
    
}
//=================================================================================
- (void)InitEvaluationView
{
    float Height = 480;
    if(appDelegate.m_Constants.m_bIsIPhone5)
    {
        Height = 564;
    }
    self.m_mtaEvaluation = [NSMutableArray array];
    
    UITableView *EvaluationView = [[UITableView alloc]initWithFrame:CGRectMake(0, 170, 320, Height)];
    [EvaluationView setTag:501];
    
    [EvaluationView setDelegate:self];
    [EvaluationView setDataSource:self];
    
    [EvaluationView setHidden:YES];
    [self.view addSubview:EvaluationView];

    self.m_mtaEvaluation = [NSMutableArray array];
    
    //測試碼
    DetailWeb   *Data = [DetailWeb alloc];
    Data.m_From = @"PTT";
    Data.m_Desc = @"鄉民表示。。。";
    [self.m_mtaEvaluation addObject:Data];
    Data = [DetailWeb alloc];
    Data.m_From = @"google 大神";
    Data.m_Desc = @"大神表示。。。";
    [self.m_mtaEvaluation addObject:Data];
    //測試碼結束
}
//=================================================================================
- (void)BtnFunction:(id)_Sender
{
    UIButton*   btnSender = (UIButton*)_Sender;
    
    switch (btnSender.tag) {
        case 1010:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 2011:
            self.m_selectedView = 0;
            break;
        case 2012:
            self.m_selectedView = 1;
            break;
        case 2013:
            self.m_selectedView = 2;
            break;
        default:
            break;
    }
    [self ShowConetent:self.m_selectedView];
}
//=================================================================================
- (void)ShowConetent:(int)index
{
    [[self.view viewWithTag:301] setHidden:YES];
    [[self.view viewWithTag:401] setHidden:YES];
    [[self.view viewWithTag:501] setHidden:YES];
    switch (index) {
        case 0:
            [[self.view viewWithTag:301] setHidden:NO];
            break;
        case 1:
            [[self.view viewWithTag:401] setHidden:NO];
            [((UITableView*)[self.view viewWithTag:401]) reloadData];
            break;
        case 2:
            [[self.view viewWithTag:501] setHidden:NO];
            [((UITableView*)[self.view viewWithTag:501]) reloadData];
            break;
        default:
            break;
    }
}
//=================================================================================
@end




















