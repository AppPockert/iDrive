//
//  TestLoginService.m
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "TestLoginService.h"

@implementation TestLoginService

- (instancetype)init {
	self = [super init];
	if (self) {
		self.url = @"http://www.weather.com.cn/data/cityinfo/101010100.html";
	}
	return self;
}

@end
