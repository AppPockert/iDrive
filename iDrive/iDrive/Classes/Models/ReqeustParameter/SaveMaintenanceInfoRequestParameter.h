//
//  SaveMaintenanceInfoRequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14/10/20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"

@interface SaveMaintenanceInfoRequestParameter : RequestParameter

@property (strong, nonatomic) NSString *insuranceCompany;        // 保险公司
@property (strong, nonatomic) NSString *insuranceType;           // 保险类型
@property (strong, nonatomic) NSString *ciiInsurancetimeLeft;    // 保险到期日
@property (strong, nonatomic) NSString *ciiMaintaintimeLeft;     // 保养到期日
@property (strong, nonatomic) NSString *ciiMaintaindistanceLeft; // 保养到期里程
@property (strong, nonatomic) NSString *userTelephone;

@end
