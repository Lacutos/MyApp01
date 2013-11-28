//
//  MainViewController.h
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ListTable.h"
#import "MAINBPickerView.h"
@interface MainViewController : UIViewController
<
MKMapViewDelegate,
CLLocationManagerDelegate,
UITableViewDataSource,
UITableViewDelegate
>
{
    BOOL                m_bIsMap;
    ListTable*          m_TableView;
    NSMutableArray*     m_mtaTableViewData;
    MainSliderView*     m_MainSliderView;
}
@property(nonatomic, assign)BOOL                m_bIsMap;
@property(nonatomic, retain)ListTable*          m_TableView;
@property(nonatomic, retain)NSMutableArray*     m_mtaTableViewData;
@property(nonatomic, retain)MainSliderView*     m_MainSliderView;
- (void)leftSelected;
- (void)rightSelected;
- (void)SwitchMapOrList;
- (void)SwitcToList;
- (void)LoadAnnotation;
@end
