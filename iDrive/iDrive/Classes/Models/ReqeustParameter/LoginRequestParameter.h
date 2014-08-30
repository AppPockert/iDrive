//
//  LoginRequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"

@interface LoginRequestParameter : RequestParameter

@property (strong, nonatomic) NSString *account;
@property (strong, nonatomic) NSString *password;

@end
