//
//  PlistFilePathManager.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "PlistFilePathManager.h"

@implementation PlistFilePathManager

+ (NSString *)getFullPath:(NSString *)fileName {
	return [self getFullPath:fileName options:FilePathOptionTypeBundle];
}

+ (NSString *)getFullPath:(NSString *)fileName options:(FilePathOptionType)optionTypes {
	// 从Bundle读取
	if (optionTypes & FilePathOptionTypeBundle) {
		return [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:fileName];
	}
	// 从UserDocument读取
	else if (optionTypes & FilePathOptionTypeUserDocument) {
		NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		NSString *plistPath = [rootPath stringByAppendingPathComponent:fileName];

		// 指定路径不存在
		if (![[NSFileManager defaultManager]fileExistsAtPath:plistPath]) {
			NSError *error;

			// 指定从Bundle拷贝相同文件名的文件
			if (optionTypes & FilePathOptionTypeCopyFromBundle) {
				NSString *bundlePath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:fileName];
				[[NSFileManager defaultManager] copyItemAtPath:bundlePath toPath:plistPath error:&error];
			}
			// 默认是直接在UserDocument下创建
			else {
				[[NSFileManager defaultManager] createDirectoryAtPath:plistPath withIntermediateDirectories:YES attributes:nil error:&error];
			}

			if (error) {
				NSLog(@"%@", error);
				plistPath = nil;
			}
		}

		return plistPath;
	}
	else {
		return nil;
	}
}

@end
