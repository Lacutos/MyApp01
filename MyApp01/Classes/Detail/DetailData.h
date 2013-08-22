//
//  DetailData.h
//  MyApp01
//
//  Created by Lacutos on 13/6/30.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailData : NSObject
{
    NSString        *m_Latituted;
    NSString        *m_Longtututed;
    NSString        *m_Name;
    NSString        *m_Addr;
    NSMutableArray  *m_mtaDocNames;
    
    BOOL            m_bBefore;          //去過
    BOOL            m_bMagzie;          //商周
    BOOL            m_bMyFavirite;
}
@property(nonatomic, retain) NSString           *m_Latituted;
@property(nonatomic, retain) NSString           *m_Longtututed;
@property(nonatomic, retain) NSString           *m_Name;
@property(nonatomic, retain) NSString           *m_Addr;
@property(nonatomic, retain) NSMutableArray     *m_mtaDocNames;
@property(nonatomic, assign) BOOL               m_bBefore;
@property(nonatomic, assign) BOOL               m_bMagzie;
@property(nonatomic, assign) BOOL               m_bMyFavirite;
- (id)Init;

@end
