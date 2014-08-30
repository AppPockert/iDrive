//
//  RequestService.h
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

/**
 *  请求服务
 */

@class RequestParameter;

@interface RequestService : NSObject

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *requestMethod;

@property (assign, nonatomic) int tag;
@property (assign, nonatomic, readonly) int resultCode;

/**
 *  开始处理请求，默认是做网络请求
 *
 *  以下情况需要子类重写此方法
 *  1.非网络请求操作，例如本地数据库存储
 *  2.网络请求后的追加操作，例如本地数据库存储、替Controller完成数据筛选等
 *
 *  @param parameter 请求参数
 *
 *  @return 请求结果
 */
- (id)beginDealWith:(RequestParameter *)parameter;

@end
