//
//  RegisterRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RegisterRequestParameter.h"

@implementation RegisterRequestParameter

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kRegisterRequestUrl, self.userCarlicense, self.userIdcard, self.userPassword, self.userTelephone, self.userTianyitongid];
	return [ServerURLUtil getFullURL:url];
}

@end
