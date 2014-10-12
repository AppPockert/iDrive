//
//  ModifyCarInfoRequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"

/**
 *  修改车辆信息
 */
@interface ModifyCarInfoRequestParameter : RequestParameter

@property (strong, nonatomic) NSString *carLicenseid;            // 车牌号
@property (strong, nonatomic) NSString *carDriver;               // 驾驶员
@property (strong, nonatomic) NSString *carModel;                // 车型
@property (strong, nonatomic) NSString *insuranceCompany;        // 保险公司
@property (strong, nonatomic) NSString *insuranceType;           // 保险类型
@property (strong, nonatomic) NSString *ciiInsurancetimeLeft;    // 保险到期日
@property (strong, nonatomic) NSString *ciiMaintaintimeLeft;     // 保养到期日
@property (strong, nonatomic) NSString *ciiMaintaindistanceLeft; // 保养到期里程
@property (strong, nonatomic) NSString *equipmentSNnum;          // SN设备号
@property (strong, nonatomic) NSString *userTelphone;            // 用户手机号


@end
