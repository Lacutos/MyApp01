//
//  ListData.h
//  MyApp01
//
//  Created by Lacutos on 13/6/27.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ListData : NSObject
{
    NSString                *m_Name;
    NSString                *m_Addr;
    CLLocationCoordinate2D  m_Coordinate;
}
@property(nonatomic ,retain)NSString    *m_Name;
@property(nonatomic ,retain)NSString    *m_Addr;
@property(nonatomic ,assign)CLLocationCoordinate2D  m_Coordinate;
@end
