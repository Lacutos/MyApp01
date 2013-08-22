//
//  CustomAnnotation.h
//  MyTestApp
//
//  Created by Lacutos on 13/6/11.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;      //大頭針的座標(MKAnnotation:coordinate)
    NSString *title;                        //大頭針的標題(MKAnnotation:title)
    NSString *subtitle;                     //大頭針的子標題(MKAnnotation:subtitle)
    NSString *ImgName;                      //圖片名
    int tag;                                //編號
}
@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, retain) NSString               *title;
@property(nonatomic, retain) NSString               *subtitle;
@property(nonatomic, retain) NSString               *ImgName;
@property(nonatomic, assign) int                    tag;

-(id) initWithCoordinate:(CLLocationCoordinate2D) _coordinate title:(NSString*)_title subtitle:(NSString*)_subtitle;
@end

@interface ImageAnnotationView : MKAnnotationView
{
	UIImageView* imageView;
}

@property (nonatomic, retain) UIImageView* imageView;
@end

