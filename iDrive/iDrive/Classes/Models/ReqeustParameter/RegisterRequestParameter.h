//
//  RegisterRequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"

/**
 *  注册请求参数
 */
@interface RegisterRequestParameter : RequestParameter

@property (strong, nonatomic) NSString *userCarlicense; // 用户车牌号
@property (strong, nonatomic) NSString *userIdcard; //用户身份证号
@property (strong, nonatomic) NSString *userPassword; //密码
@property (strong, nonatomic) NSString *userTelephone; //手机号码
@property (strong, nonatomic) NSString *userTianyitongid; //爱开车编号


@end
