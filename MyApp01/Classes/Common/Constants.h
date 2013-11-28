//
//  NATConstants.h
//  MyTestApp
//
//  Created by Lacutos on 13/6/6.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

enum{
    kMainFrameXWhenRightIsShown = -280,
    kMainFrameXWhenRightToShow  = -100,
    kMainFrameXWhenLeftToShow = 100,
    kMainFrameXWhenLeftIsShown = 290
}kMainFrameX;

@interface DetailCommentData : NSObject
{
    NSString*   m_Description;
    BOOL        m_Recommand;
    int         m_Type; //0 = 看病記錄 1 = 推薦
}
@property(nonatomic, retain)NSString*   m_Description;
@property(nonatomic, assign)BOOL        m_Recommand;
@property(nonatomic, assign)int         m_Type;
@end

@interface DetailWeb : NSObject
{
    NSString*   m_From;
    NSString*   m_Desc;
}
@property(nonatomic, retain)NSString*   m_From;
@property(nonatomic, retain)NSString*   m_Desc;
@end

@interface Constants : NSObject
{
    BOOL        m_bIsIPhone5;
    CGRect      m_MapRect;
    // 設定使用者位置有效半徑，超過範圍需重新讀取座標（單位：公尺）
    int         m_MAP_Distance;
    float       m_UserLatitudeDeltaDefault;
    float       m_UserLongitudeDeltaDefault;
    NSString    *m_LeftNavigationBarTitle;
    NSString    *m_RightNavigationBarTitle;
    NSString    *m_CLOSE;
    NSString    *m_SHARE;
    NSString    *m_SEARCHBTN_TITLE;
    UIFont      *m_FONT_19_BOLD;
    UIFont      *m_FONT_24_BOLD;
    UIFont      *m_FONT_15_NONE;
    
    NSString    *m_DetailMainBtn_ClinicData;
    NSString    *m_DetailMainBtn_Comment;
    NSString    *m_DetailMainBtn_Evaluate;
    
    BOOL        m_ISDISPLAYDEBUGLOG;
}

@property(nonatomic, assign)CGRect          m_MapRect;
@property(nonatomic, assign)BOOL            m_bIsIPhone5;
@property(nonatomic, assign)int             m_MAP_Distance;
@property(nonatomic, assign)float           m_UserLatitudeDeltaDefault;
@property(nonatomic, assign)float           m_UserLongitudeDeltaDefault;
@property(nonatomic, retain)NSString        *m_LeftNavigationBarTitle;
@property(nonatomic, retain)NSString        *m_RightNavigationBarTitle;
@property(nonatomic, retain)NSString        *m_CLOSE;
@property(nonatomic, retain)NSString        *m_SHARE;
@property(nonatomic, retain)NSString        *m_SEARCHBTN_TITLE;
@property(nonatomic, retain)UIFont          *m_FONT_19_BOLD;
@property(nonatomic, retain)UIFont          *m_FONT_24_BOLD;
@property(nonatomic, retain)UIFont          *m_FONT_15_NONE;

@property(nonatomic, retain)NSString        *m_DetailMainBtn_ClinicData;
@property(nonatomic, retain)NSString        *m_DetailMainBtn_Comment;
@property(nonatomic, retain)NSString        *m_DetailMainBtn_Evaluate;

@property(nonatomic, retain)NSString        *m_CONNECTION_NoInternet;
@property(nonatomic, retain)NSString        *m_CONNECTION_Timeout;
@property(nonatomic, retain)NSString        *m_CONNECTION_NoServer;
@property(nonatomic, retain)NSString        *m_CONNECTION_Unknown;
@property(nonatomic, retain)NSString        *m_CONNECTION_Success;
@property(nonatomic, retain)NSString        *m_ED_NoInternet;
@property(nonatomic, retain)NSString        *m_ED_TimeOut;
@property(nonatomic, retain)NSString        *m_ED_UnKnown;

@property(nonatomic, assign)BOOL            m_ISDISPLAYDEBUGLOG;
@property(nonatomic, assign)CGFloat         m_HTTPConnectionTimeout;

@property(nonatomic, retain)NSString        *m_HTTPREQEUST_SPECIALTY;
@property(nonatomic, retain)NSString        *m_HTTPREQEUST_NEARBY_HOSPITALS;
@property(nonatomic, retain)NSString        *m_ALERT_TITLE;
@property(nonatomic, retain)NSString        *m_BTN_ALERTVIEW_CONFIRM;


//@property(nonatomic, retain)NSString *RM_Timeout;
//@property(nonatomic, retain)NSString *RM_Unknown;
//@property(nonatomic, retain)NSString *RM_NoServer;

@end









