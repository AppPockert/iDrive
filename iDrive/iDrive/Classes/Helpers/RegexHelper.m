//
//  RegexHelper.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "RegexHelper.h"

#define kRegexs     @[@"1[0-9]{10}", @"[A-Z0-9a-z]{6,16}" /**TODO:验证爱开车编号格式有效性 */]
#define kErrMsgs    @[@"手机号码格式错误", @"密码格式错误，请输入6-16位字母或数字", @"设备编号格式错误", @"身份证号格式错误"]

@implementation RegexHelper

+ (NSString *)check:(NSString *)content with:(RegexType)type {
	BOOL isValid = YES;

	// 验证身份号
	if (type == RegexTypeICNo) {
		if (content.length == 15 || content.length == 18) {
			NSString *emailRegex = @"^[0-9]*$";
			NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
			BOOL sfzNo = [emailTest evaluateWithObject:[content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];

			if (content.length == 15) {
				if (!sfzNo) {
					isValid = NO;
				}
			}
			else if (content.length == 18) {
				BOOL sfz18NO = [self checkIdentityCardNo:content];
				if (!sfz18NO) {
					isValid = NO;
				}
			}
		}
		else {
			isValid = NO;
		}
	}
	// 其他
	else {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kRegexs[type]];
		isValid = [predicate evaluateWithObject:content];
	}

	if (isValid) {
		return nil;
	}
	else {
		return kErrMsgs[type];
	}
}

#pragma mark - 身份证识别
+ (BOOL)checkIdentityCardNo:(NSString *)cardNo {
	if (cardNo.length != 18) {
		return NO;
	}
	NSArray *codeArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
	NSDictionary *checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil]  forKeys:[NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil]];

	NSScanner *scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];

	int val;
	BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
	if (!isNum) {
		return NO;
	}
	int sumValue = 0;

	for (int i = 0; i < 17; i++) {
		sumValue += [[cardNo substringWithRange:NSMakeRange(i, 1)] intValue] * [[codeArray objectAtIndex:i] intValue];
	}

	NSString *strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d", sumValue % 11]];

	if ([strlast isEqualToString:[[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
		return YES;
	}
	return NO;
}

@end
