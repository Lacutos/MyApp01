//
//  Tools.h
//  MyApp01
//
//  Created by Lacutos on 13/7/29.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
+(NSString *) getHTTPConnectionErrorMessageWithError: (NSError *) _error;
+(void) showAlertWithTitle: (NSString *) _sTitle withMsg: (NSString *) _sMsg withCancelButtonTitle: (NSString *) _sCancelButtonTitle withOtherButtonTitle: (NSString *) _sOtherButtonTitle withDelegate: (id) _dDelegate;
+(void) showAlertWithTitle: (NSString *) _sTitle withMsg: (NSString *) _sMsg withCancelButtonTitle: (NSString *) _sCancelButtonTitle withOtherButtonTitle: (NSString *) _sOtherButtonTitle withDelegate: (id) _dDelegate withTag: (NSInteger) _iTag;
@end
