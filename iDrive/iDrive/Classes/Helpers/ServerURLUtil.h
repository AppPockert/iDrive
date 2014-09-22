//
//  ServerURLUtil.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-22.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

/**
 *  服务器地址工具类，获取实际/测试服务器URL
 */
@interface ServerURLUtil : NSObject

+ (NSString *)getFullURL:(NSString *)relativeURL;

@end
