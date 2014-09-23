//
//  LoginRequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"

/**
 *  登录请求参数
 */
@interface LoginRequestParameter : RequestParameter

@property (strong, nonatomic) NSString *userTelephone;
@property (strong, nonatomic) NSString *userPassword;

@end
