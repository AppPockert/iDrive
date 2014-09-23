//
//  LoginRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "LoginRequestParameter.h"

@implementation LoginRequestParameter

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kLoginRequestUrl, self.userTelephone, self.userPassword];
	return [ServerURLUtil getFullURL:url];
}

@end
