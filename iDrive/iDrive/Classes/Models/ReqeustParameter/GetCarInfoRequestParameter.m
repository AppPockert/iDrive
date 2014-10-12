//
//  GetCarInfoRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "GetCarInfoRequestParameter.h"
#import "UserInfo.h"

@implementation GetCarInfoRequestParameter

- (id)init {
	self = [super init];
	if (self) {
		self.userId = [[kAppDelegate getUserInfo] userTelephone];
	}
	return self;
}

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kCarInfoRequestUrl, self.userId];
	return [ServerURLUtil getFullURL:url];
}

@end
