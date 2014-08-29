//
//  RegexHelper.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "RegexHelper.h"

#define kRegexs     @[@"1[0-9]{10}", @"[A-Z0-9a-z_]{4,20}"]
#define kErrMsgs    @[@"手机号码格式错误", @"密码格式错误"]

@implementation RegexHelper

+ (NSString *)check:(NSString *)content with:(RegexType)type {
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kRegexs[type]];
	if (![predicate evaluateWithObject:content]) {
		return kErrMsgs[type];
	}
	return nil;
}

@end
