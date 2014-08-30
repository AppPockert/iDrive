//
//  BaseModel.h
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//


/**
 * 共通数据模型
 */

@interface BaseModel : NSObject

/**
 *  根据字典生成Model对象实例
 *
 *  @param dic 数据源字典
 *
 *  @return Model对象实例
 */
- (instancetype)initWithDictionary:(NSDictionary *)dic;

/**
 *  分析数组内的内容，再将分析后的数组赋值给Model实例的属性
 *  默认是不做分析直接赋值，子类根据具体情况重写
 *
 *  @param array 需分析的数组
 *  @param key   Model实例的属性名
 */
- (void)parseArray:(NSArray *)array forKey:(NSString *)key;

/**
 *  将Model对象实例转化成字典
 *
 *  @return 转换后的字典
 */
- (NSDictionary *)convertModelToDictionary;

@end
