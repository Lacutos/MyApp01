//
//  HttpRequest.m
//
//

#import "HttpRequest.h"
#import "Tools.h"
#import "Constants.h"
#import "AppDelegate.h"
@implementation HttpRequest

@synthesize httpRequestDelegate, sRequestBody, mtdaReceiveData, mtuURLRequest, urlConnection;
@synthesize timeoutInterval, timerTimeout, sSessionID, sSoapAction, iHTTPStatusCode;
@synthesize isPost, isDefaultAlertForError;
@synthesize PostData;

-(void) dealloc {
	[self.httpRequestDelegate release];
	[self.sRequestBody release];
	[self.mtdaReceiveData release];
	[self.mtuURLRequest release];
	[self.urlConnection release];
	[self.timerTimeout release];
	[self.sSessionID release];
	[self.sSoapAction release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark HttpRequest instance methods

-(void) checkTimeout {
	if (([self.timerTimeout isValid]) && (! self.mtdaReceiveData)) {
		[self.urlConnection cancel];
		
		if ([self respondsToSelector: @selector(connection: didFailWithError:)])
			[self connection: self.urlConnection didFailWithError: [NSError errorWithDomain: @"NSURLErrorDomain" code: [appDelegate.m_Constants.m_CONNECTION_Timeout intValue] userInfo: nil]];
	}
}

-(id) initWithContentOfURL: (NSURL *) _url {
	if ((self = [super init]) != nil) {
		NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL: _url];
		[urlRequest setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
		self.mtuURLRequest = urlRequest;
		[urlRequest release];
		
		self.isPost = NO;                  // 預設使用 GET 方式
		self.isDefaultAlertForError = NO;  // 預設由開發者自行處理失敗的 method
	}
	
	return self;
}

-(void) startRequest {
	if (appDelegate.m_Constants.m_ISDISPLAYDEBUGLOG)
		NSLog(@"HttpRequest.startRequest--->%@", [[self.mtuURLRequest URL] absoluteString]);
	
	if (self.isPost) {
		[self.mtuURLRequest setHTTPMethod: @"POST"];
		[self.mtuURLRequest setHTTPBody: self.PostData];
		[self.mtuURLRequest setValue: [NSString stringWithFormat: @"%d", [self.sRequestBody length]] forHTTPHeaderField: @"Content-Length"];
        [self.mtuURLRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		
		if ((self.sSoapAction != nil) && (! [sSoapAction isEqualToString: @""]))
			[self.mtuURLRequest setValue: sSoapAction forHTTPHeaderField: @"Soapaction"];
		
		if ([self.sSessionID length] > 0)
			//[self.mtuURLRequest setValue: [NSString stringWithFormat: @"%@=%@", @"JSESSIONID", self.sSessionID] forHTTPHeaderField: @"Cookie"];
			[self.mtuURLRequest setValue: self.sSessionID forHTTPHeaderField: @"Cookie"];
	} else {
		[self.mtuURLRequest setHTTPMethod: @"GET"];
	}
	
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest: self.mtuURLRequest delegate: self];
	self.urlConnection = conn;
	[conn release];
	
	if (! self.urlConnection) {
		if (self.httpRequestDelegate && [self.httpRequestDelegate respondsToSelector: @selector(HttpRequest: didError:)])
            
			[self.httpRequestDelegate HttpRequest: self didError: [NSError errorWithDomain: appDelegate.m_Constants.m_ED_NoInternet code: [appDelegate.m_Constants.m_CONNECTION_NoInternet intValue] userInfo: nil]];
	}
}

#pragma mark -
#pragma mark NSURLConnection methods

-(NSURLRequest *) connection: (NSURLConnection *) connection willSendRequest: (NSURLRequest *) request redirectResponse: (NSURLResponse *) redirectResponse {
	if (appDelegate.m_Constants.m_ISDISPLAYDEBUGLOG)
		NSLog(@"HttpRequest.willSendRequest.url--->%f, %@", self.timeoutInterval, [request URL]);
	
	if (self.timeoutInterval > 0)
		self.timerTimeout = [NSTimer scheduledTimerWithTimeInterval: self.timeoutInterval target: self selector: @selector(checkTimeout) userInfo: nil repeats: NO];
	
	return request;
}

-(void) connection: (NSURLConnection *) connection didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *) challenge {
	/*
	 if ([challenge previousFailureCount] == 0) {
	 NSURLCredential *newCredential;
	 newCredential=[NSURLCredential credentialWithUser:[self username]
	 password:[self password]
	 persistence:NSURLCredentialPersistenceNone];
	 
	 [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
	 
	 } else {
	 [[challenge sender] cancelAuthenticationChallenge:challenge];
	 // inform the user that the user name and password
	 // in the preferences are incorrect
	 NSLog(@"帳號密碼有誤");
	 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"錯誤" message:@"帳號密碼有誤" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	 [alertView show];
	 [alertView release];
	 }
	 */
}

-(void) connection: (NSURLConnection *) connection didReceiveResponse: (NSURLResponse *) response {
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
	NSDictionary *fields = [httpResponse allHeaderFields];
	
	self.iHTTPStatusCode = [httpResponse statusCode];
	
	if (appDelegate.m_Constants.m_ISDISPLAYDEBUGLOG) {
		NSLog(@"HttpRequest didReceiveResponse");
		NSLog(@"%@", fields);
	}
	
	self.sSessionID = [fields valueForKey: @"Set-Cookie"];
}

-(void) connection: (NSURLConnection *) connection didReceiveData: (NSData *) data {
	if (self.mtdaReceiveData == nil)
		self.mtdaReceiveData = [NSMutableData dataWithData: data];
	else
		[self.mtdaReceiveData appendData: data];
}

-(void) connectionDidFinishLoading: (NSURLConnection *) connection {
	if ([self.timerTimeout isValid])
		[self.timerTimeout invalidate];
	
	if (self.httpRequestDelegate && [self.httpRequestDelegate respondsToSelector: @selector(HttpRequestDidFinished:)])
		[self.httpRequestDelegate HttpRequestDidFinished: self];
}

-(void) connection: (NSURLConnection *) connection didFailWithError: (NSError *) _error {
	if ([self.timerTimeout isValid])
		[self.timerTimeout invalidate];
	
	if (self.isDefaultAlertForError) {
		NSString *sErrorMessage = [Tools getHTTPConnectionErrorMessageWithError: _error];
		
		if (sErrorMessage != nil)
			[Tools showAlertWithTitle: @"訊息" withMsg: sErrorMessage withCancelButtonTitle: @"確定" withOtherButtonTitle: nil withDelegate: nil];
	}
	
	if (self.httpRequestDelegate && [self.httpRequestDelegate respondsToSelector: @selector(HttpRequest: didError:)])
		[self.httpRequestDelegate HttpRequest: self didError: _error];
}

@end