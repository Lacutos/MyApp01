//
//  WebServicesCleint.h
//
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"

@class WebServiceClient;

@protocol WebServiceClientDelegate

@optional

// SOAP
//-(void) MMBWebServiceClient: (MMBWebServiceClient *) _vwscClient didCompleteLocationWithResponseCode: (NSString *) _sResponseCode withResponseMessage: (NSString *) _sResponseMessage  withLocationResponse: (tns1_ArrayOfstoreLocation *) _mbLocationResponse;


// Http
-(void) WebServiceClient: (WebServiceClient *) _vwscClient didCompletespecialtyrWithResponseCode: (NSString *) _sResponseCode withResponseMessage: (NSString *) _sResponseMessage  withVersionControllerResponse: (NSString *) _sResponseData;

-(void) WebServiceClient: (WebServiceClient *) _vwscClient didCompleteQueryNearByHostpitalWithResponseCode: (NSString *) _sResponseCode withResponseMessage: (NSString *) _sResponseMessage  withVersionControllerResponse: (NSString *) _sResponseData;
@end


@interface WebServiceClient : NSObject<UIAlertViewDelegate,HttpRequestDelegate> {
	NSObject <WebServiceClientDelegate, NSObject> *wscDelegate;
	NSString *sHttpFunCode;		// 定義使用Http的交易代碼

}

@property (nonatomic, assign) NSObject <WebServiceClientDelegate, NSObject> *wscDelegate;
@property (nonatomic, retain) NSString *sHttpFunCode;

//-(void) getHttpRequest: (NSString *) _url withXml: (NSString *) _xml withMethod: (NSString *) _method;
-(void) getHttpRequest: (NSString *) _url withPostData: (NSData *) PostData withMethod: (NSString *) _method;
-(void) getHttpRequestWithCookie: (NSString *) _url withXml: (NSString *) _xml withMethod: (NSString *) _method Cookie:(NSString*)Cookie;
@end
