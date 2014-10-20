//
//  GetMaintenanceInfoRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14/10/20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "GetMaintenanceInfoRequestParameter.h"
#import "UserInfo.h"

@implementation GetMaintenanceInfoRequestParameter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userTelephone = [[kAppDelegate getUserInfo] userTelephone];
    }
    return self;
}

- (NSString *)urlByAppendParameter {
    NSString *url = [NSString stringWithFormat:kGetMaintenanceInfoUrl, self.userTelephone];
    return [ServerURLUtil getFullURL:url];
}

@end
