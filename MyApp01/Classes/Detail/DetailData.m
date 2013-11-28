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
@synthesize m_hospital_id;
@synthesize m_Name;
@synthesize m_Addr;
@synthesize m_hospital_phone;
@synthesize m_mtaDocDatas;
@synthesize m_bBefore;
@synthesize m_bMagzie;
@synthesize m_bMyFavirite;
@synthesize m_Distance;

- (id)Init
{
    self.m_mtaDocDatas = [NSMutableArray array];
    return self;
}
- (void)dealloc
{
    [self.m_mtaDocDatas removeAllObjects];
    [self.m_mtaDocDatas release];
        
    [super dealloc];
}
@end


@implementation DoctorData

@synthesize m_business_magazine_id;
@synthesize m_doctor_experience;
@synthesize m_doctor_id;
@synthesize m_doctor_name;
@synthesize m_doctor_professional;
@synthesize m_specialty_id;
@synthesize m_specialty_name;
@synthesize m_subspecialty_id;
@synthesize m_subspecialty_name;
@synthesize m_summary_id;

@end
