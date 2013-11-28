//
//  CustomAnnotation.m
//  MyTestApp
//
//  Created by Lacutos on 13/6/11.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "CustomAnnotation.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomAnnotation()

@end

@implementation CustomAnnotation
{
    
}
@synthesize coordinate;
//@synthesize imageName;
//@synthesize annotationType;
@synthesize subtitle;
@synthesize tag;
@synthesize title;
@synthesize ImgName;

-(id) initWithCoordinate:(CLLocationCoordinate2D) _coordinate title:(NSString*)_title subtitle:(NSString*)_subtitle
{
    if (self = [super init]) {
		coordinate            = _coordinate;
		self.title            = _title;
//		self.subtitle         = _subtitle;
	}
    return self;
}
//=================================================================================
-(id) initWithCoordinate:(CLLocationCoordinate2D) _coordinate  annotationType:(NSString*) _annotationType title:(NSString*)_title subtitle:(NSString*)_subtitle
{
    if (self = [super init]) {
		coordinate            = _coordinate;
		self.title            = _title;
//		self.subtitle         = _subtitle;
	}
    return self;
}
//=================================================================================
-(void) dealloc {
	[self.title    release];
	[self.subtitle release];
	[self.ImgName release];
	[super dealloc];
}

@end
//=================================================================================

#define kHeight 100
#define kWidth  50
#define kBorder 0

@implementation ImageAnnotationView
@synthesize imageView;
//=================================================================================
- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithAnnotation: annotation reuseIdentifier: reuseIdentifier];
	self.frame = CGRectMake(0, 0, kWidth, kHeight);
	self.backgroundColor = [UIColor clearColor];
	
	if ([annotation isKindOfClass: [CustomAnnotation class]]) {
		CustomAnnotation *Annotation = (CustomAnnotation*)annotation;
        
		if (![Annotation.ImgName isEqualToString: @""]) {
            UIImage *image = [UIImage imageNamed: Annotation.ImgName];
            CGRect imageRect = CGRectMake(kBorder, kBorder, image.size.width, image.size.height);
            imageView = [[UIImageView alloc] initWithFrame: imageRect];
            [imageView setImage:image];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview: imageView];
		}
	}
	return self;
}
//=================================================================================
-(void) dealloc
{
	[self.imageView release];
	[super dealloc];
}
//=================================================================================
@end



















