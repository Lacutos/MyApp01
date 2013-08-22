//
//  Tools.m
//  MyApp01
//
//  Created by Lacutos on 13/7/29.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "Tools.h"
#import "AppDelegate.h"

@implementation Tools
+(NSString *) getHTTPConnectionErrorMessageWithError: (NSError *) _error {
	// 重新設定錯誤代碼及訊息
	NSString *sErrorCode = [NSString stringWithFormat: @"%d", [_error code]];
	NSString *sErrorMessage = nil;
	
	// 當 ResponseError 回傳「Error Domain=NSURLErrorDomain Code=0 "The operation couldn’t be completed. (NSURLErrorDomain error 0.)"」時，不予處理
	if (! ([sErrorCode isEqualToString: @"0"] && [[_error domain] isEqualToString: @"NSURLErrorDomain"])) {
        
		if ([sErrorCode isEqualToString: appDelegate.m_Constants.m_CONNECTION_NoInternet])
			sErrorMessage = appDelegate.m_Constants.m_ED_NoInternet;
		else if ([sErrorCode isEqualToString: appDelegate.m_Constants.m_CONNECTION_Timeout])
			sErrorMessage = appDelegate.m_Constants.m_ED_TimeOut;
		else
			sErrorMessage = appDelegate.m_Constants.m_ED_UnKnown;
	}
	
	return sErrorMessage;
}
+(void) showAlertWithTitle: (NSString *) _sTitle withMsg: (NSString *) _sMsg withCancelButtonTitle: (NSString *) _sCancelButtonTitle withOtherButtonTitle: (NSString *) _sOtherButtonTitle withDelegate: (id) _dDelegate {
    
    [self showAlertWithTitle:_sTitle withMsg:_sMsg withCancelButtonTitle:_sCancelButtonTitle withOtherButtonTitle:_sOtherButtonTitle withDelegate:_dDelegate withTag:-1];
}
+(void) showAlertWithTitle: (NSString *) _sTitle withMsg: (NSString *) _sMsg withCancelButtonTitle: (NSString *) _sCancelButtonTitle withOtherButtonTitle: (NSString *) _sOtherButtonTitle withDelegate: (id) _dDelegate withTag: (NSInteger) _iTag {
	UIAlertView *alvMessage = [[UIAlertView alloc] initWithTitle: _sTitle
														 message: _sMsg
														delegate: _dDelegate
											   cancelButtonTitle: _sCancelButtonTitle
											   otherButtonTitles: _sOtherButtonTitle, nil];
	alvMessage.tag = _iTag;
	
	[alvMessage show];
	[alvMessage release];
}
@end
