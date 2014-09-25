//
//  AddCarInfoRequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"
/**
 *  追加车辆信息
 */
@interface AddCarInfoRequestParameter : RequestParameter

@property (strong, nonatomic) NSString *carLicenseid;
@property (strong, nonatomic) NSString *carModel;
@property (strong, nonatomic) NSString *carMotorid;
@property (strong, nonatomic) NSString *carUsercompany;
@property (strong, nonatomic) NSString *carInsurancemaintainInfo;
@property (strong, nonatomic) NSString *carTestInfo;
@property (strong, nonatomic) NSString *carObdRt;
@property (strong, nonatomic) NSString *carDriver;

@end
