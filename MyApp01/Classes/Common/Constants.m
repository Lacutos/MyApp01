//
//  NATConstants.m
//  MyTestApp
//
//  Created by Lacutos on 13/6/6.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "Constants.h"


@implementation Constants
@synthesize m_MapRect;
@synthesize m_bIsIPhone5;
@synthesize m_MAP_Distance;
@synthesize m_UserLatitudeDeltaDefault;
@synthesize m_UserLongitudeDeltaDefault;
@synthesize m_LeftNavigationBarTitle;
@synthesize m_RightNavigationBarTitle;
@synthesize m_CLOSE;
@synthesize m_SHARE;
@synthesize m_SEARCHBTN_TITLE;
@synthesize m_FONT_19_BOLD;
@synthesize m_FONT_24_BOLD;
@synthesize m_FONT_15_NONE;

@synthesize m_DetailMainBtn_ClinicData;
@synthesize m_DetailMainBtn_Comment;
@synthesize m_DetailMainBtn_Evaluate;

@synthesize m_CONNECTION_NoInternet;
@synthesize m_CONNECTION_Timeout;
@synthesize m_CONNECTION_NoServer;
@synthesize m_CONNECTION_Unknown;
@synthesize m_ED_NoInternet;
@synthesize m_ED_TimeOut;
@synthesize m_ED_UnKnown;

@synthesize m_ISDISPLAYDEBUGLOG;



-(id) init
{
    self.m_bIsIPhone5 = ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON );
    
    self.m_MapRect = CGRectMake(0, 0, 320, 480);
    if(self.m_bIsIPhone5)
    {
        self.m_MapRect = CGRectMake(0, 0, 320, 568);
    }
    self.m_MAP_Distance = 1500;
    self.m_UserLatitudeDeltaDefault = 0.009;
    self.m_UserLongitudeDeltaDefault = 0.009;
    
    self.m_LeftNavigationBarTitle = @"...";    //科別
    self.m_RightNavigationBarTitle = @"...";   //選項
    self.m_CLOSE = @"關閉";
    self.m_SHARE = @"分享";
    self.m_SEARCHBTN_TITLE = @"搜尋";
    
    self.m_FONT_19_BOLD = [UIFont fontWithName: @"Helvetica-Bold" size: 19.0];
    self.m_FONT_24_BOLD = [UIFont fontWithName: @"Helvetica-Bold" size: 24.0];
    self.m_FONT_15_NONE = [UIFont fontWithName: @"Helvetica" size: 15.0];
    
    self.m_DetailMainBtn_ClinicData = @"門診資料";
    self.m_DetailMainBtn_Comment = @"註記";
    self.m_DetailMainBtn_Evaluate = @"網路評價";
    
    self.m_CONNECTION_NoInternet = @"-1009";
    self.m_CONNECTION_Timeout = @"-1001";
    self.m_CONNECTION_NoServer = @"-1004";
    self.m_CONNECTION_Unknown = @"UnKnow";
    
    self.m_ED_NoInternet = @"NO Internet Service";
    self.m_ED_TimeOut = @"TimeOut";
    self.m_ED_UnKnown = @"UnKnown";
    
    self.m_ISDISPLAYDEBUGLOG = YES;
    return self;
}

-(void)dealloc
{
    [self.m_LeftNavigationBarTitle release];
    [self.m_RightNavigationBarTitle release];
    [self.m_SEARCHBTN_TITLE release];
    [self.m_CLOSE release];
    [self.m_FONT_19_BOLD release];
    [self.m_FONT_24_BOLD release];
    [self.m_FONT_15_NONE release];
    [super dealloc];
}
@end

@implementation DetailCommentData

@synthesize m_Description;
@synthesize m_Recommand;
@synthesize m_Type;

@end

@implementation DetailWeb

@synthesize m_From;
@synthesize m_Desc;

@end












