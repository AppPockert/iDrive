//
//  RegexHelper.h
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

typedef NS_ENUM (int, RegexType) {
	RegexTypePhone,
	RegexTypePassword,
};

@interface RegexHelper : NSObject

/**
 *  Check文本格式
 *
 *  @param content 文本内容
 *  @param type    check类型
 *
 *  @return ErrMsg, 符合格式则为nil
 */
+ (NSString *)check:(NSString *)content with:(RegexType)type;

@end
