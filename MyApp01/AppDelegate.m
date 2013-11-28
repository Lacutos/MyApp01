//
//  AppDelegate.m
//  MyApp01
//
//  Created by Lacutos on 13/6/14.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "AppDelegate.h"
#import "SliderRootViewController.h"
#import "MainNavigationController.h"
#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "DetailData.h"
#import "JSON.h"
@interface AppDelegate()<WebServiceClientDelegate>
- (void)InitLocationManager;
- (void)InitMap;

@end

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    [super dealloc];
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
//自定屬性
@synthesize m_SingletonMapView;
@synthesize m_Constants;
@synthesize m_locationManager;
@synthesize m_UserCoor;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    appDelegate = self;
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.m_Constants = [[Constants alloc]init];
    [self InitMap];
    [self InitLocationManager];
    
    SliderRootViewController *RootVC = [[SliderRootViewController alloc]init];
    [self.window setRootViewController:RootVC];
    [RootVC release];
    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyApp01" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyApp01.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma WebServiceClientDelegate
//============================================================================================================
-(void) WebServiceClient: (WebServiceClient *) _vwscClient didCompleteQueryNearByHostpitalWithResponseCode: (NSString *) _sResponseCode withResponseMessage: (NSString *) _sResponseMessage  withVersionControllerResponse: (NSString *) _sResponseData
{
    NSLog(@"responseString = %@",_sResponseData);
    id jsonObject = [_sResponseData JSONValue];
    
    NSMutableArray *mtaAllData = jsonObject;
    NSLog(@"mtaAllData = %@",mtaAllData);
    
    
    for(NSMutableDictionary *Dict in mtaAllData)
    {
        DetailData* DetailDataObj = [[DetailData alloc]Init];
        DetailDataObj.m_Distance = [Dict objectForKey:@"distance"];
        
        DetailDataObj.m_Addr = [Dict objectForKey:@"hospital_address"];
        

        [Dict objectForKey:@"hospital_id"];
        DetailDataObj.m_Name = [Dict objectForKey:@"hospital_name"];
        [Dict objectForKey:@"hospital_phone"];
        [Dict objectForKey:@"hospital_address"];
        [Dict objectForKey:@"latitude"];
        [Dict objectForKey:@"longitude"];
        
//        Data.m_Name = [Dict objectForKey:@"hospital_name"];
//        Data.m_Addr = [Dict objectForKey:@"hospital_address"];
//        Data.m_Latituted = [Dict objectForKey:@"latitude"];
//        Data.m_Longtututed = [Dict objectForKey:@"longitude"];
//        [Data.m_mtaDocNames addObject:[Dict objectForKey:@"doctor_name"]];
//        Data.m_bBefore = NO;
//        Data.m_bMagzie = NO;
////        [self.m_mtaTableViewData addObject:Data];
//        NSLog(@"Data.m_Name = %@",Data.m_Name);
    }
}
#pragma Custom Methods
//============================================================================================================
- (void)InitMap
{
    self.m_SingletonMapView = [[MKMapView alloc]initWithFrame:self.m_Constants.m_MapRect];
    [self.m_SingletonMapView setMapType:MKMapTypeStandard];
    
    [self.m_SingletonMapView setZoomEnabled:YES];
    [self.m_SingletonMapView setScrollEnabled:YES];
    [self.m_SingletonMapView setAutoresizesSubviews:YES];
    [self.m_SingletonMapView setUserInteractionEnabled:YES];
    [self.m_SingletonMapView setMultipleTouchEnabled:YES];
    [self.m_SingletonMapView setHidden:YES];
}
//============================================================================================================
- (void)InitLocationManager
{
    if(nil == self.m_locationManager)
    {
        self.m_locationManager = [[CLLocationManager alloc] init];
        self.m_locationManager.delegate = self;
        self.m_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.m_locationManager.distanceFilter = m_Constants.m_MAP_Distance;
    }
}
//============================================================================================================
- (void)QueryNearByHospitalDataWithSpecialtyID:(NSString*)ID withDelegate:(id)Delegate
{
    //    "specialty_id":id,
    //    "longitude":經度,
    //    "latitude":緯度,
    //    "o_udid":o_udid,
    //    "max_count":資料上限筆數
    //    "max_distance":半徑範圍
    WebServiceClient * WS = [[WebServiceClient alloc]init];
    WS.wscDelegate = Delegate;
    [WS setSHttpFunCode:appDelegate.m_Constants.m_HTTPREQEUST_NEARBY_HOSPITALS];
    
//    NSMutableDictionary *Dict = [NSfMutableDictionary dictionary];
    NSString *latitude = [NSString stringWithFormat:@"%f",appDelegate.m_UserCoor.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",appDelegate.m_UserCoor.coordinate.longitude];
    
//    [Dict setObject:ID forKey:@"specialty_id"];
//    [Dict setObject:longitude forKey:@"longitude"];
//    [Dict setObject:latitude forKey:@"latitude"];
//    [Dict setObject:@"12345" forKey:@"o_udid"];
//    [Dict setObject:@"30" forKey:@"max_count"];
//    [Dict setObject:@"5000" forKey:@"max_distance"];
    
    NSString *jsonString = [NSString stringWithFormat:@"{\"specialty_id\":\"%@\",\"longitude\":\"%@\",\"latitude\":\"%@\",\"o_udid\":\"%@\",\"max_count\":\"%@\",\"max_distance\":\"%@\"}", ID, longitude,latitude,@"12345",@"30",@"500"];
    NSLog(@"jsonString = %@",jsonString);
    NSData *requestdata = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString* sTemp = [[NSString alloc]initWithFormat:@"http://ireullin.asuscomm.com:10080/myclinic/mobile/query"];
    /** data is ready now, and you can use it **/
    [WS getHttpRequest:sTemp withPostData:requestdata withMethod:@"POST"];
}
//============================================================================================================
@end
