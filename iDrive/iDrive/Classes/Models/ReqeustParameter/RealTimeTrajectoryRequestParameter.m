//
//  RealTimeTrajectoryRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RealTimeTrajectoryRequestParameter.h"
#import "UserInfo.h"

@implementation RealTimeTrajectoryRequestParameter

- (id)init {
	self = [super init];
	if (self) {
		self.equipmentSNnum = [[kAppDelegate getUserInfo] SN];
	}
	return self;
}

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kRealTimeTrajectoryUrl, self.equipmentSNnum];
	return [ServerURLUtil getFullURL:url];
}

@end
