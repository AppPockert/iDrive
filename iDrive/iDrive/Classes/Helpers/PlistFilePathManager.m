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
	if (optionTypes & FilePathOptionTypeBundle) {
		return [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:fileName];
	}
	else if (optionTypes & FilePathOptionTypeUserDocument) {
		NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		NSString *plistPath = [rootPath stringByAppendingPathComponent:fileName];

		if (![[NSFileManager defaultManager]fileExistsAtPath:plistPath]) {
			NSError *error;

			if (optionTypes & FilePathOptionTypeCopyFromBundle) {
				NSString *bundlePath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:fileName];
				[[NSFileManager defaultManager] copyItemAtPath:bundlePath toPath:plistPath error:&error];
			}
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
