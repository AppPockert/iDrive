//
//  ItineraryHistoryRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "ItineraryHistoryRequestParameter.h"
#import "UserInfo.h"

@implementation ItineraryHistoryRequestParameter

- (id)init {
	self = [super init];
	if (self) {
		self.equipmentSNnum = [[kAppDelegate getUserInfo] SN];
	}
	return self;
}

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kItineraryHistoryUrl, self.equipmentSNnum, self.startTime, self.endTime];
	return [ServerURLUtil getFullURL:url];
}

@end
