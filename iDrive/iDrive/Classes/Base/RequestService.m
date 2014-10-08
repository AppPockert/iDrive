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

	NSURL *requestURL = [NSURL URLWithString:self.url];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:requestURL];
	request.timeOutSeconds = 10.f;
	if (self.requestMethod) {
		request.requestMethod = self.requestMethod;
	}
	else {
		request.requestMethod = @"GET";
	}

	if (parameter) {
		[parameter addPostValueTo:request];
	}


	NSLog(@"Send request with url: %@\n RequestParameter:\n%@", self.url, parameter ? parameter : @"nil");
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
