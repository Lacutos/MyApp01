//
//  AppDelegate.h
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"
#import "WebServiceClient.h"


@class AppDelegate;
AppDelegate *appDelegate;


@interface AppDelegate : UIResponder
<
UIApplicationDelegate,
CLLocationManagerDelegate
>


@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//自定屬性
@property (nonatomic, retain) MKMapView         *m_SingletonMapView;
@property (nonatomic, retain) Constants         *m_Constants;
@property (nonatomic, retain) CLLocationManager *m_locationManager;
@property (nonatomic, retain) CLLocation        *m_UserCoor;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)QueryNearByHospitalDataWithSpecialtyID:(NSString*)ID withDelegate:(id)Delegate;

@end
