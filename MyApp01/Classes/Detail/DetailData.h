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
    NSString        *m_hospital_id;
    NSString        *m_Name;
    NSString        *m_hospital_phone;
    NSString        *m_Addr;
    NSMutableArray  *m_mtaDocDatas;
    NSString        *m_Distance;
    
    BOOL            m_bBefore;          //去過
    BOOL            m_bMagzie;          //商周
    BOOL            m_bMyFavirite;
}
@property(nonatomic, retain) NSString           *m_Latituted;
@property(nonatomic, retain) NSString           *m_Longtututed;
@property(nonatomic, retain) NSString           *m_hospital_id;
@property(nonatomic, retain) NSString           *m_Name;
@property(nonatomic, retain) NSString        *m_hospital_phone;
@property(nonatomic, retain) NSString           *m_Addr;
@property(nonatomic, retain) NSMutableArray     *m_mtaDocDatas;
@property(nonatomic, assign) BOOL               m_bBefore;
@property(nonatomic, assign) BOOL               m_bMagzie;
@property(nonatomic, assign) BOOL               m_bMyFavirite;
@property(nonatomic, retain) NSString           *m_Distance;
- (id)Init;

@end



@interface DoctorData : NSObject
{
    NSString        *m_business_magazine_id;
    NSString        *m_doctor_experience;
    NSString        *m_doctor_id;
    NSString        *m_doctor_name;
    NSString        *m_doctor_professional;
    NSString        *m_specialty_id;
    NSString        *m_specialty_name;
    NSString        *m_subspecialty_id;
    NSString        *m_subspecialty_name;
    NSString        *m_summary_id;
}
@property(nonatomic, retain) NSString        *m_business_magazine_id;
@property(nonatomic, retain) NSString        *m_doctor_experience;
@property(nonatomic, retain) NSString        *m_doctor_id;
@property(nonatomic, retain) NSString        *m_doctor_name;
@property(nonatomic, retain) NSString        *m_doctor_professional;
@property(nonatomic, retain) NSString        *m_specialty_id;
@property(nonatomic, retain) NSString        *m_specialty_name;
@property(nonatomic, retain) NSString        *m_subspecialty_id;
@property(nonatomic, retain) NSString        *m_subspecialty_name;
@property(nonatomic, retain) NSString        *m_summary_id;

@end
