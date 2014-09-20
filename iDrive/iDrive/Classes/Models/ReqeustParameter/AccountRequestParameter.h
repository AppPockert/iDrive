//
//  AccountRequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"

/**
 *  用户登陆/注册用请求参数
 */
@interface AccountRequestParameter : RequestParameter

@property (strong, nonatomic) NSString *account;  // 用户名
@property (strong, nonatomic) NSString *password; // 密码

@end
