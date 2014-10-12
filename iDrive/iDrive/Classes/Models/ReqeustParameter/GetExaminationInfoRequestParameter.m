//
//  GetExaminationInfoRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "GetExaminationInfoRequestParameter.h"
#import "UserInfo.h"

@implementation GetExaminationInfoRequestParameter

- (id)init {
	self = [super init];
	if (self) {
		self.equipmentSNnum = [[kAppDelegate getUserInfo] SN];
	}
	return self;
}

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kExaminationInfoUrl, self.equipmentSNnum];
	return [ServerURLUtil getFullURL:url];
}

@end
