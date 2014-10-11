//
//  AddCarInfoRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "AddCarInfoRequestParameter.h"
#import "UserInfo.h"

@implementation AddCarInfoRequestParameter

- (id)init {
	self = [super init];
	if (self) {
		self.equipmentSNnum = [[kAppDelegate getUserInfo] SN];
	}
	return self;
}

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kSaveCarIno, self.insuranceCompany, self.insuranceType, self.ciiInsurancetimeLeft, self.ciiMaintaintimeLeft, self.ciiMaintaindistanceLeft, self.carLicenseid, self.carModel, self.carDriver, self.equipmentSNnum];
	return [ServerURLUtil getFullURL:url];
}

@end
