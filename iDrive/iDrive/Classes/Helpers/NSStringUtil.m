//
//  NSStringUtil.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "NSStringUtil.h"

@implementation NSStringUtil

+ (BOOL)isValidate:(NSString *)string {
	BOOL flag = NO;
	if (string) {
		NSString *temp = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		if (![temp isEqualToString:@""]) {
			flag = YES;
		}
	}
	return flag;
}

@end
