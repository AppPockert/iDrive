//
//  SaveMaintenanceInfoRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14/10/20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "SaveMaintenanceInfoRequestParameter.h"
#import "UserInfo.h"

@implementation SaveMaintenanceInfoRequestParameter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userTelephone = [[kAppDelegate getUserInfo] userTelephone];
    }
    return self;
}

- (NSString *)urlByAppendParameter {
    NSString *url = [NSString stringWithFormat:kSaveMaintenanceInfoUrl, self.userTelephone, self.insuranceCompany, self.insuranceType, self.ciiInsurancetimeLeft, self.ciiMaintaintimeLeft, self.ciiMaintaindistanceLeft];
    return [ServerURLUtil getFullURL:url];
}

@end
