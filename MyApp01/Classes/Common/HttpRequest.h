//
//  HttpRequest.h
//
//

#import <Foundation/Foundation.h>

@class HttpRequest;

@protocol HttpRequestDelegate

-(void) HttpRequestDidFinished: (HttpRequest *) _httpRequest;
-(void) HttpRequest: (HttpRequest *) _httpRequest didError: (NSError *) _error;

@end


@interface HttpRequest: NSObject {
	NSObject <HttpRequestDelegate, NSObject> *httpRequestDelegate;
	NSString            *sRequestBody;
    NSData              *PostData;
	NSMutableData       *mtdaReceiveData;
	NSMutableURLRequest *mtuURLRequest;
	NSURLConnection     *urlConnection;
	NSTimeInterval       timeoutInterval;        // 因 HTTP POST Request 無法指定 timeout 時間 (預設 240 秒)，因此使用此參數設定 timeout 時間，單位：秒
	NSTimer             *timerTimeout;
	NSString			*sSessionID;
	NSString			*sSoapAction;
	NSInteger           iHTTPStatusCode;         // NSURLResponse 的 statusCode
	
	BOOL                isPost;
	BOOL                isDefaultAlertForError;  // 有錯誤發生時，是否要使用 UIAlertView 顯示整合後的錯誤訊息
}

@property (nonatomic, retain) NSObject <HttpRequestDelegate, NSObject> *httpRequestDelegate;
@property (nonatomic, retain) NSString* sRequestBody;
@property (nonatomic, retain) NSData*   PostData;
@property (nonatomic, retain) NSMutableData *mtdaReceiveData;
@property (nonatomic, retain) NSMutableURLRequest *mtuURLRequest;
@property (nonatomic, retain) NSURLConnection *urlConnection;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, retain) NSTimer *timerTimeout;
@property (nonatomic, retain) NSString *sSessionID;
@property (nonatomic, retain) NSString *sSoapAction;
@property (nonatomic, assign) NSInteger iHTTPStatusCode;

@property (nonatomic, assign) BOOL isPost;
@property (nonatomic, assign) BOOL isDefaultAlertForError;

-(void) checkTimeout;
-(id) initWithContentOfURL: (NSURL *) _url;
-(void) startRequest;

@end