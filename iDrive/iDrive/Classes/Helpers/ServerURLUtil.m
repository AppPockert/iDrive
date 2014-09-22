//
//  ServerURLUtil.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-22.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "ServerURLUtil.h"

@implementation ServerURLUtil

+ (NSString *)getFullURL:(NSString *)relativeURL {
	NSString *testServer = [[NSUserDefaults standardUserDefaults] objectForKey:TestServer];

	if (testServer) {
		return [NSString stringWithFormat:@"%@/%@", testServer, relativeURL];
	}
	else {
		return [NSString stringWithFormat:@"%@/%@", kBaseURL, relativeURL];
	}
}

@end
