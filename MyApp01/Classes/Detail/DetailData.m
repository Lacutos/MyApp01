//
//  DetailData.m
//  MyApp01
//
//  Created by Lacutos on 13/6/30.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "DetailData.h"

@implementation DetailData

@synthesize m_Latituted;
@synthesize m_Longtututed;
@synthesize m_Name;
@synthesize m_Addr;
@synthesize m_mtaDocNames;
@synthesize m_bBefore;
@synthesize m_bMagzie;
@synthesize m_bMyFavirite;

- (id)Init
{
    self.m_mtaDocNames = [NSMutableArray array];
    return self;
}
- (void)dealloc
{
    [self.m_mtaDocNames removeAllObjects];
    [self.m_mtaDocNames release];
        
    [super dealloc];
}
@end
