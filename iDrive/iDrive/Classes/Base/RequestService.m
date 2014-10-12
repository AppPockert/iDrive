//
//  RequestService.m
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestService.h"
#import "ASIFormDataRequest.h"
#import "RequestParameter.h"

@interface RequestParameter ()

- (void)addPostValueTo:(ASIFormDataRequest *)request;

@end

@implementation RequestService

- (id)beginDealWith:(RequestParameter *)parameter {
	if (!self.url) {
		self.url = [parameter urlByAppendParameter];
		if (!self.url) {
			NSLog(@"Request URL or parameter is nil!");
			return nil;
		}
		self.requestMethod = @"GET";
	}

	NSString *encodeUrl = [self.url stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)];
	NSURL *requestURL = [NSURL URLWithString:encodeUrl];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:requestURL];
	request.timeOutSeconds = 5.f;

	if (self.requestMethod) {
		request.requestMethod = self.requestMethod;
	}
	else {
		request.requestMethod = @"GET";
	}

	if (parameter) {
		[parameter addPostValueTo:request];
	}


	NSLog(@"Send request with url: %@\n RequestParameter:\n%@", encodeUrl, parameter ? parameter : @"nil");
//	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//	[request setStringEncoding:enc];
	[request startSynchronous];

	_resultCode = request.responseStatusCode;

	NSData *response = request.responseData;

	if (response) {
		NSError *error = nil;
		id JSON = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];

		if (error) {
			NSLog(@"%@", error);

			_resultCode = error.code;
			return nil;
		}

		NSLog(@"Response:%@ for '%@'", JSON, self.url);
		return JSON;
	}
	else {
		return nil;
	}
}

@end
