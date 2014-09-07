//
//  PlistFilePathManager.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

typedef NS_OPTIONS (int, FilePathOptionType) {
	FilePathOptionTypeBundle          = 1,      // 从Bundle读取文件
	FilePathOptionTypeUserDocument    = 1 << 1, // 从用户文档读取文件

	    FilePathOptionTypeCopyFromBundle  = 1 << 2, // 从Bundle拷贝
	    FilePathOptionTypeCreatIfNotExist = 1 << 3, // 直接创建
};

@interface PlistFilePathManager : NSObject

/**
 *  从Bundle获取完整目录
 *
 *  @param fileName 文件名
 *
 *  @return 文件路径
 */
+ (NSString *)getFullPath:(NSString *)fileName;

/**
 *  根据OptionType获取完整目录
 *
 *  @param fileName    文件名
 *  @param optionTypes 操作选项
 *
 *  @return 文件路径
 */
+ (NSString *)getFullPath:(NSString *)fileName options:(FilePathOptionType)optionTypes;

@end
