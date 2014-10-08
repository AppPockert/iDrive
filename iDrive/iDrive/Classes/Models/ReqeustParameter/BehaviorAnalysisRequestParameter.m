//
//  BehaviorAnalysisRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-25.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "BehaviorAnalysisRequestParameter.h"
#import "UserInfo.h"

@implementation BehaviorAnalysisRequestParameter

- (id)init {
	self = [super init];
	if (self) {
		self.equipmentSNnum = [[kAppDelegate getUserInfo] SN];
	}
	return self;
}

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kBehaviorAnalysis, self.equipmentSNnum];
	return [ServerURLUtil getFullURL:url];
}

@end
