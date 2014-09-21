//
//  RequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

/**
 *  请求参数类
 */

#import "BaseModel.h"

@interface RequestParameter : BaseModel

/**
 *  以拼接字符串的形式获取请求URL，用于GET请求的时候需要子类重写
 *
 *  @return URL
 */
- (NSString *)urlByAppendParameter;

@end
