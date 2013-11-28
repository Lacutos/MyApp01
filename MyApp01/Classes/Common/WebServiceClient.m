//
//  WebServicesCleint.m
//


#import <UIKit/UIKit.h>
#import "WebServiceClient.h"
#import "AppDelegate.h"
#import "Tools.h"
@implementation WebServiceClient

@synthesize wscDelegate, sHttpFunCode;

- (void) dealloc {
	[self.sHttpFunCode release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark WebServiceClient Class Methods
//-(void) getHttpRequest: (NSString *) _url withXml: (NSString *) _xml withMethod: (NSString *) _method;
-(void) getHttpRequest: (NSString *) _url withPostData: (NSData *) PostData withMethod: (NSString *) _method {
//-(void) getHttpRequest: (NSString *) _url withXml: (NSString *) _xml withMethod: (NSString *) _method {
	if (appDelegate.m_Constants.m_ISDISPLAYDEBUGLOG)
		NSLog(@"getHttpRequest:\n%@", [NSString stringWithFormat:@"%@",_url]);
	HttpRequest *httpRequest = [[HttpRequest alloc] initWithContentOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_url]]];
	httpRequest.httpRequestDelegate = self;
	httpRequest.isDefaultAlertForError = NO;
	httpRequest.isPost = NO;
	if ([[_method uppercaseString] isEqualToString: @"POST"]) {
		httpRequest.PostData = PostData;
        httpRequest.isPost = YES;
		httpRequest.timeoutInterval = appDelegate.m_Constants.m_HTTPConnectionTimeout;
	}
	[httpRequest startRequest];
	[httpRequest release];
}
-(void) getHttpRequestWithCookie: (NSString *) _url withXml: (NSString *) _xml withMethod: (NSString *) _method Cookie:(NSString*)Cookie {
	if (appDelegate.m_Constants.m_ISDISPLAYDEBUGLOG)
		NSLog(@"getHttpRequest:\n%@", _url);
	HttpRequest *httpRequest = [[HttpRequest alloc] initWithContentOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_url]]];
    
    [httpRequest.mtuURLRequest setValue:Cookie forHTTPHeaderField:@"Cookie"];
	httpRequest.httpRequestDelegate = self;
	httpRequest.isDefaultAlertForError = NO;
	httpRequest.isPost = NO;
	if ([[_method uppercaseString] isEqualToString: @"POST"]) {
		httpRequest.sRequestBody = _xml;
        //		httpRequest.sSessionID = [NSString stringWithFormat: @"0000%@:-1", [gWebServiceClient.mdtSession valueForKey: @"Session_id"]];
		httpRequest.timeoutInterval = appDelegate.m_Constants.m_HTTPConnectionTimeout;
	}
	[httpRequest startRequest];
	[httpRequest release];
}

#pragma mark -
#pragma mark WebServiceClient Intance Methods


#pragma mark -
#pragma mark ServiceSoapBindingResponseDelegate Methods

-(void) operation: (id) operation completedWithResponse: (id) _response {
//	if (IsDisplayDebugLog) {
//		NSLog(@"completedWithResponse starting");
//		NSLog(@"_response=%@",_response);
//	}
//	
//	NSArray *aryHeaders = nil;
//	NSArray *aryBodyParts = nil;
//	NSError *errResponse = nil;
//
//	if ([_response isKindOfClass:[BasicHttpBinding_IESBStoreServiceResponse class]]) {
//		aryHeaders = ((BasicHttpBinding_IESBStoreServiceResponse *) _response).headers;
//		aryBodyParts = ((BasicHttpBinding_IESBStoreServiceResponse *) _response).bodyParts;
//		errResponse = ((BasicHttpBinding_IESBStoreServiceResponse *) _response).error;
//	} else if ([_response isKindOfClass:[BasicHttpBinding_Im_rate_deposit_loanBindingResponse class]]) {
//		aryHeaders = ((BasicHttpBinding_Im_rate_deposit_loanBindingResponse *) _response).headers;
//		aryBodyParts = ((BasicHttpBinding_Im_rate_deposit_loanBindingResponse *) _response).bodyParts;
//		errResponse = ((BasicHttpBinding_Im_rate_deposit_loanBindingResponse *) _response).error;
//	}
//
//	NSInteger iResponseCode = [errResponse code];
//	NSString *sReturnCode = @"";
//	NSString *sResponseMessage = @"";
//	NSString *sHeaderRetCode = @"";
//
//	if (iResponseCode == 0 && [aryBodyParts count] >= 1) {
//		for (id header in aryHeaders) {
//			if (IsDisplayDebugLog)
//				NSLog(@"completedWithResponse.Header--->%@", header);
//		}
//		if ([aryBodyParts count] >= 1) {
//			sHeaderRetCode = [aryHeaders objectAtIndex: 0];
//		}
//		
//		if (IsDisplayDebugLog)
//			NSLog(@"completedWithResponse.aryBodyParts.size--->%i", [aryBodyParts count]);
//		
//		if ([aryBodyParts count] >= 1) {
//			id bodyPart = [aryBodyParts objectAtIndex: 0];
//			if ([bodyPart isKindOfClass: [SOAPFault class]]) {
//				if (IsDisplayDebugLog)
//					NSLog(@"completedWithResponse error--->%@", ((SOAPFault *) bodyPart).simpleFaultString);
//
//			} else if ([bodyPart isKindOfClass:[ESBStoreServiceSvc_GetStoresByLocationResponse class]]) {	//----依經緯度取得特店資訊
//				tns1_ArrayOfstoreLocation *locationResponse = ((ESBStoreServiceSvc_GetStoresByLocationResponse*) bodyPart).GetStoresByLocationResult;
//
//				sReturnCode = @"0000";
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"依經緯度取特店資訊成功！";
//					
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteLocationWithResponseCode: withResponseMessage: withLocationResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteLocationWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withLocationResponse: locationResponse];
//				}
//			} else if ([bodyPart isKindOfClass:[ESBStoreServiceSvc_GetStoresByRegionResponse class]]) {	//----依經地區取得特店列表
////				tns1_ArrayOfstoreList *regionResponse = ((ESBStoreServiceSvc_GetStoresByRegionResponse*) bodyPart).GetStoresByRegionResult;
////				NSInteger iTotalCount = [((ESBStoreServiceSvc_GetStoresByRegionResponse*) bodyPart).totolRows intValue];
//				ESBStoreServiceSvc_GetStoresByRegionResponse *regionResponse = bodyPart;
//				
//				sReturnCode = @"0000";
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"依地區取特店列表成功！";
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteRegionWithResponseCode: withResponseMessage: withRegionResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteRegionWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withRegionResponse: regionResponse];
//				}
//			} else if ([bodyPart isKindOfClass:[ESBStoreServiceSvc_GetMerchantDtlResponse class]]) {	//----依特店號碼取得特店明細
//				tns1_store *storeinfoResponse = ((ESBStoreServiceSvc_GetMerchantDtlResponse *) bodyPart).GetMerchantDtlResult;
//
//				sReturnCode = @"0000";
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"特店明細成功！";
//
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteStoreInfoWithResponseCode: withResponseMessage: withStoreInfoResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteStoreInfoWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withStoreInfoResponse: storeinfoResponse];
//				}
//			} else if ([bodyPart isKindOfClass:[ESBStoreServiceSvc_GetVersionIDResponse class]]) {	//----取得特店頪別和地區階層版本ID
//				tns1_ArrayOfversionID *versionidResponse = ((ESBStoreServiceSvc_GetVersionIDResponse *) bodyPart).GetVersionIDResult;
//				
//				sReturnCode = @"0000";
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"類別和地區階層成功！";
//					
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteVersionIdWithResponseCode: withResponseMessage: withVersionIdResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteVersionIdWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withVersionIdResponse: versionidResponse];
//				}
//			} else if ([bodyPart isKindOfClass:[ESBStoreServiceSvc_GetMerchantTypeResponse class]]) {	//----取得特店類別資訊
//				tns1_ArrayOfmerchantType *storetypeResponse = ((ESBStoreServiceSvc_GetMerchantTypeResponse *) bodyPart).GetMerchantTypeResult;
//				
//				sReturnCode = @"0000";
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"特店類別成功！";
//					
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteStoreTypeWithResponseCode: withResponseMessage: withStoreTypeResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteStoreTypeWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withStoreTypeResponse: storetypeResponse];
//				}
//			} else if ([bodyPart isKindOfClass:[ESBStoreServiceSvc_GetRegHierarchyResponse class]]) {	//----取得地區階層資訊
//				tns1_ArrayOfregion *regiontypeResponse = ((ESBStoreServiceSvc_GetRegHierarchyResponse *) bodyPart).GetRegHierarchyResult;
//				
//				sReturnCode = @"0000";
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"地區階層成功！";
//					
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteRegionTypeWithResponseCode: withResponseMessage: withRegionTypeResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteRegionTypeWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withRegionTypeResponse: regiontypeResponse];
//				}
//			} else if ([bodyPart isKindOfClass:[ESBStoreServiceSvc_ESBMobileResponse class]]) {	//----取得分行叫號機等待人數資訊
//				tns2_BranchResponse *branchwaitingResponse = ((ESBStoreServiceSvc_ESBMobileResponse *) bodyPart).details;
//				
//				sReturnCode = @"0000";
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"查詢分行叫號機等待人數 成功！";
//					
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteBranchWaitingWithResponseCode: withResponseMessage: withHeaderResponse: withBranchWaitingResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteBranchWaitingWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withBranchWaitingResponse: branchwaitingResponse];
//				}
//			} else if ([bodyPart isKindOfClass:[ESBStoreServiceSvc_ESBMobileCCYResponse class]] &&
//					   [sHeaderRetCode isEqualToString: @"0"]) {	//----取得即時匯率列表
//				tns2_CCYResponse *ccyratesResponse = ((ESBStoreServiceSvc_ESBMobileCCYResponse *) bodyPart).CCYRateList;
//				
//				sReturnCode = @"0000";
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"查詢即時匯率列表 成功！";
//					
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteCCYRatesWithResponseCode: withResponseMessage: withHeaderResponse: withCCYRatesResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteCCYRatesWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withCCYRatesResponse: ccyratesResponse];
//				}
//			} else if ([bodyPart isKindOfClass:[m_rate_deposit_loan_GetNBOBUDepositRatesResponse class]]) {	//----取得外幣存款利率
//				tns1_NBOBU_depositeRate *fcdepositrateResponse = ((m_rate_deposit_loan_GetNBOBUDepositRatesResponse *)bodyPart).GetNBOBUDepositRatesResult;
//				
//				sReturnCode = @"0000";
//				
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"查詢外幣存款利率成功！";
//					
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteFCDepositRateWithResponseCode: withResponseMessage: withHeaderResponse: withFCDepositRateResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteFCDepositRateWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withFCDepositRateResponse: fcdepositrateResponse];
//				}
//			} else if ([bodyPart isKindOfClass:[m_rate_deposit_loan_GetNBOBULoanRatesResponse class]]) {	//----取得外幣放款利率
//				tns1_NBOBU_loanRate *fcloanrateResponse = ((m_rate_deposit_loan_GetNBOBULoanRatesResponse *)bodyPart).GetNBOBULoanRatesResult;
//				
//				sReturnCode = @"0000";
//				
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"查詢外幣存款利率成功！";
//					
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteFCLoanRateWithResponseCode: withResponseMessage: withHeaderResponse: withFCLoanRateResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteFCLoanRateWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withFCLoanRateResponse: fcloanrateResponse];
//				}
//			} else if ([bodyPart isKindOfClass:[m_rate_deposit_loan_GetNTInterestRatesResponse class]]) {	//----取得台幣存放款利率
//				tns1_NTRate *twdepositloanrateResponse = ((m_rate_deposit_loan_GetNTInterestRatesResponse *)bodyPart).GetNTInterestRatesResult;
//				
//				sReturnCode = @"0000";
//				
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"查詢臺幣存放款利率成功！";
//					
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteTWDepositLoanRateWithResponseCode: withResponseMessage: withHeaderResponse: withTWDepositLoanRateResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteTWDepositLoanRateWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withTWDepositLoanRateResponse: twdepositloanrateResponse];
//				}
//			} else if ([bodyPart isKindOfClass:[m_rate_deposit_loan_GetNewsResponse class]]) {	//----取得最新消息列表
//				tns1_ArrayOfnews *newsResponse = ((m_rate_deposit_loan_GetNewsResponse *)bodyPart).GetNewsResult;
//				
//				sReturnCode = @"0000";
//				
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"查詢最新消息成功！";
//					
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteNewsWithResponseCode: withResponseMessage: withHeaderResponse: withNewsResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteNewsWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withNewsResponse: newsResponse];
//				}
//			}else if ([bodyPart isKindOfClass:[m_rate_deposit_loan_GetGoldPriceResponse class]]) {	//----取得黃金報價
//				tns2_ArrayOfGoldPrice *GoldPrice = ((m_rate_deposit_loan_GetGoldPriceResponse *)bodyPart).GetGoldPriceResult;				
//				sReturnCode = @"0000";
//				
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"查詢黃金報價成功！";
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteGoldPriceWithResponseCode: withResponseMessage: withHeaderResponse: withGoldPrice:)])
//                        
//                        [wscDelegate MMBWebServiceClient: self didCompleteGoldPriceWithResponseCode:sReturnCode withResponseMessage:sResponseMessage withHeaderResponse:aryHeaders withGoldPrice:GoldPrice];
//				}
//			}
//            else if([bodyPart isKindOfClass:[m_rate_deposit_loan_NewsResponse class]]) {	//----取得 HomeScreenNEWS
//                tns1_ArrayOfnews *News = ((m_rate_deposit_loan_NewsResponse *)bodyPart).NewsList;
//                if(IsDisplayDebugLog)
//                {
//                    NSLog(@"News = %@",News);
//                }
//                NSString *retCode = [NSString stringWithFormat:@"%@" ,[aryHeaders objectAtIndex:0]];
//                if([retCode isEqualToString:@"0"])
//                {
//                    sReturnCode = @"0000";
//                }
//                else
//                {
//                    sReturnCode = retCode;
//                }
//				
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"查詢 NewsList 成功！";
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteNewsWithResponseCode: withResponseMessage: withHeaderResponse: withNewsResponse:)])
//						[wscDelegate MMBWebServiceClient: self didCompleteNewsWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withNewsResponse: News];
//				}
//                else
//                {
////                    if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteNewsWithResponseCode: withResponseMessage: withHeaderResponse: withNewsResponse:)])
////                        [wscDelegate MMBWebServiceClient: self didCompleteNewsWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withNewsResponse: nil];
//                    return;
//                }
//
//            }
//            else if ([bodyPart isKindOfClass:[m_rate_deposit_loan_GetUbikeNewsResponse class]]) {	//----取得 UBikeNews
//                tns1_ArrayOfnews *News = ((m_rate_deposit_loan_GetUbikeNewsResponse *)bodyPart).GetUbikeNewsResult;
//                if(IsDisplayDebugLog)
//                {
//                    NSLog(@"News = %@",News);
//                }
//                
//                
////                NSString *retCode = [NSString stringWithFormat:@"%@" ,aryHeaders[0]];
////                [aryHeaders[0] isEqualToString:@"0"]
//                NSString *retCode = [NSString stringWithFormat:@"%@",[aryHeaders objectAtIndex:0]];
//                if([retCode isEqualToString:@"0"])
//                {
//                    sReturnCode = @"0000";
//                }
//                else
//                {
//                    sReturnCode = retCode;
//                }
//				
//				if ([sReturnCode isEqualToString: RC_Success]) {
//					sResponseMessage = @"查詢 UBikeNews 成功！";
//					if (wscDelegate != nil && [wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteUBikeNewsWithResponseCode: withResponseMessage: withHeaderResponse: withNews:)])
//                        
//                        [wscDelegate MMBWebServiceClient: self didCompleteUBikeNewsWithResponseCode:sReturnCode withResponseMessage:sResponseMessage withHeaderResponse:aryHeaders withNews:News];
//				}
//            }
//		}
//	} else {
//		if (IsDisplayDebugLog) {
//			NSLog(@"completedWithResponse Error Code--->%d", [errResponse code]);
//			NSLog(@"completedWithResponse Error Domain--->%@", [errResponse domain]);
//			NSLog(@"completedWithResponse Error userInfo--->%@", [errResponse userInfo]);
//			NSLog(@"completedWithResponse Error localizedDescription--->%@", [errResponse localizedDescription]);
//		}
//
//		sReturnCode = [NSString stringWithFormat: @"%d", [errResponse code]];
//        if(nil != errResponse)
//        {
//            sResponseMessage = [[[@"[" stringByAppendingString: sReturnCode] stringByAppendingString: @"]"] stringByAppendingString: [errResponse localizedDescription]];
//        }
//        else
//        {
//            sResponseMessage = [[[@"[" stringByAppendingString: sReturnCode] stringByAppendingString: @"]"] stringByAppendingString: @"errResponseIsNil"];
//        }
//	}
//
//	// 發生不明原因的錯誤，如：Soap 內容有誤等等，此時回應預設的訊息給使用者
//	if ([sReturnCode isEqualToString: @""]) {
//		sReturnCode = RC_Unknown;
//		sResponseMessage = RM_NAT_Unknown;
//	} else if ([sReturnCode isEqualToString: RC_Timeout]) {
//		sResponseMessage = RM_Timeout;
//	} else if ([sReturnCode isEqualToString: RC_NoInternet]) {
//		sResponseMessage = RM_NAT_NoInternet;
//	}
//	
//	if (IsDisplayDebugLog) {
//		NSLog(@"completedWithResponse.Return_code--->%@", sReturnCode);
//		NSLog(@"completedWithResponse.ResponseMessage--->%@", sResponseMessage);
//	}
//	
//	//----錯誤訊息處理
//	if ([sReturnCode isEqualToString: RC_SessionTimeout]) {
//		[MMBTools showAlertWithTitle: @"進程失效" withMsg: sResponseMessage withCancelButtonTitle: nil withOtherButtonTitle: @"確定" withDelegate: appDelegate];
//	} else if (! [sReturnCode isEqualToString: RC_Success]) {
//		if ([sReturnCode isEqualToString: RC_Unknown] || [sReturnCode isEqualToString: RC_Timeout] || [sReturnCode isEqualToString: RC_NoInternet]) {
//			if (! appDelegate.isNoInteret) {
//				[MMBTools showAlertWithTitle: TXT_ALERTVIEW_TITLE_MESSAGE withMsg: sResponseMessage withCancelButtonTitle: nil withOtherButtonTitle: @"確定" withDelegate: appDelegate];
//				appDelegate.isNoInteret = NO;
//			} else {
//				[MMBTools showAlertWithTitle: TXT_ALERTVIEW_TITLE_MESSAGE withMsg: sResponseMessage withCancelButtonTitle: nil withOtherButtonTitle: @"確定" withDelegate: appDelegate];
//			}
//		} else if ([_response isKindOfClass: [BasicHttpBinding_IESBStoreServiceResponse class]] ||
//                   [_response isKindOfClass: [BasicHttpBinding_Im_rate_deposit_loanBinding class]] ||
//                   [_response isKindOfClass:[BasicHttpBinding_Im_rate_deposit_loanBindingResponse class]]
//                   ) {
//			if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteLocationWithResponseCode: withResponseMessage: withLocationResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteLocationWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withLocationResponse: nil];
//			else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteRegionWithResponseCode: withResponseMessage: withRegionResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteRegionWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withRegionResponse: nil];
//			else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteStoreInfoWithResponseCode: withResponseMessage: withStoreInfoResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteStoreInfoWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withStoreInfoResponse: nil];
//			else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteVersionIdWithResponseCode: withResponseMessage: withVersionIdResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteVersionIdWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withVersionIdResponse: nil];
//			else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteStoreTypeWithResponseCode: withResponseMessage: withStoreTypeResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteStoreTypeWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withStoreTypeResponse: nil];
//			else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteRegionTypeWithResponseCode: withResponseMessage: withRegionTypeResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteRegionTypeWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withRegionTypeResponse: nil];
//			else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteBranchWaitingWithResponseCode: withResponseMessage: withHeaderResponse: withBranchWaitingResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteBranchWaitingWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withBranchWaitingResponse: nil];
//			else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteCCYRatesWithResponseCode: withResponseMessage: withHeaderResponse: withCCYRatesResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteCCYRatesWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withCCYRatesResponse: nil];
//			else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteFCDepositRateWithResponseCode: withResponseMessage: withHeaderResponse: withFCDepositRateResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteFCDepositRateWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withFCDepositRateResponse: nil];
//			else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteFCLoanRateWithResponseCode: withResponseMessage: withHeaderResponse: withFCLoanRateResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteFCLoanRateWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withFCLoanRateResponse: nil];
//			else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteTWDepositLoanRateWithResponseCode: withResponseMessage: withHeaderResponse: withTWDepositLoanRateResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteTWDepositLoanRateWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withTWDepositLoanRateResponse: nil];
//			else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteNewsWithResponseCode: withResponseMessage: withHeaderResponse: withNewsResponse:)])
//				[wscDelegate MMBWebServiceClient: self didCompleteNewsWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withNewsResponse: nil];
//            else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteGoldPriceWithResponseCode: withResponseMessage: withHeaderResponse: withNewsResponse:)])                
//				[wscDelegate MMBWebServiceClient: self didCompleteGoldPriceWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withGoldPrice: nil];            
//            else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteUBikeNewsWithResponseCode: withResponseMessage: withHeaderResponse: withNews:)])
//                [wscDelegate MMBWebServiceClient: self didCompleteUBikeNewsWithResponseCode:sReturnCode withResponseMessage:sResponseMessage withHeaderResponse:aryHeaders withNews:nil];
////            else if ([wscDelegate respondsToSelector: @selector(MMBWebServiceClient: didCompleteNewsWithResponseCode: withResponseMessage: withHeaderResponse: withNewsResponse:)])
////                [wscDelegate MMBWebServiceClient: self didCompleteNewsWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withHeaderResponse: aryHeaders withNewsResponse: nil];
//
//		} else
//			[MMBTools showAlertWithTitle:@"訊息提醒" withMsg:@"系統忙碌中，請稍後再試" withCancelButtonTitle: nil withOtherButtonTitle: @"確定" withDelegate: appDelegate];
//	}
}

#pragma mark -
#pragma mark MMBHttpRequestDelegate Methods

-(void) HttpRequestDidFinished: (HttpRequest *) _httpRequest {
	NSString *responseData = [[NSString alloc] initWithData: _httpRequest.mtdaReceiveData encoding: NSUTF8StringEncoding];
    
	if (appDelegate.m_Constants.m_ISDISPLAYDEBUGLOG) {
		NSLog(@"HttpRequestDidFinished");
		NSLog(@"responseData=%@",responseData);
		NSLog(@"sHttpFunCode=%@",sHttpFunCode);
	}	
//	NSString *sReturnCode = RC_Success;
	NSString *sReturnCode = appDelegate.m_Constants.m_CONNECTION_Success;
	NSString *sResponseMessage = @"";
	
    sResponseMessage = self.sHttpFunCode;
	if ([self.sHttpFunCode isEqualToString: appDelegate.m_Constants.m_HTTPREQEUST_SPECIALTY]){
		if (wscDelegate != nil) {
            if([wscDelegate respondsToSelector: @selector(WebServiceClient: didCompletespecialtyrWithResponseCode: withResponseMessage: withVersionControllerResponse:)])
            {
                [wscDelegate WebServiceClient: self didCompletespecialtyrWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withVersionControllerResponse: responseData];
            }
		}
	}
    else if([self.sHttpFunCode isEqualToString: appDelegate.m_Constants.m_HTTPREQEUST_NEARBY_HOSPITALS]){
		if (wscDelegate != nil) {
            if([wscDelegate respondsToSelector: @selector(WebServiceClient: didCompleteQueryNearByHostpitalWithResponseCode: withResponseMessage: withVersionControllerResponse:)])
            {
                [wscDelegate WebServiceClient: self didCompleteQueryNearByHostpitalWithResponseCode: sReturnCode withResponseMessage: sResponseMessage withVersionControllerResponse: responseData];
            }
		}        
    }
}

-(void) HttpRequest: (HttpRequest *) _httpRequest didError: (NSError *) _error {
    
	if (appDelegate.m_Constants.m_ISDISPLAYDEBUGLOG)
		NSLog(@"WebServiceClient didError:%@", _error);
//	[appDelegate stopLoading];

	NSString *sReturnCode = [NSString stringWithFormat: @"%d", [_error code]];
	NSString *sResponseMessage = [_error description];
	NSLog(@"sReturnCode=%@", sReturnCode);
	NSLog(@"sResponseMessage=%@",sResponseMessage);
	
//	if ([self.sHttpFunCode isEqualToString: appDelegate.m_Constants.m_CONNECTION_NoInternet])
//		appDelegate.isNoInteret = YES;
	
	if (! ([sReturnCode isEqualToString: @"0"] && [[_error domain] isEqualToString: @"NSURLErrorDomain"])) {
		if ([sReturnCode isEqualToString: appDelegate.m_Constants.m_CONNECTION_NoInternet]) {
			sResponseMessage = appDelegate.m_Constants.m_ED_NoInternet;	// 改顯示自設的訊息
			return;
		} else if ([sReturnCode isEqualToString: appDelegate.m_Constants.m_CONNECTION_Timeout]) {
			sResponseMessage = appDelegate.m_Constants.m_ED_TimeOut;
		} else {
			sResponseMessage = appDelegate.m_Constants.m_ED_UnKnown;
		}
		if ([sResponseMessage length] > 0)
			[Tools showAlertWithTitle: appDelegate.m_Constants.m_ALERT_TITLE
                              withMsg: sResponseMessage
                withCancelButtonTitle: nil
                 withOtherButtonTitle: appDelegate.m_Constants.m_BTN_ALERTVIEW_CONFIRM
                         withDelegate: nil];
	}
	
} 

@end
