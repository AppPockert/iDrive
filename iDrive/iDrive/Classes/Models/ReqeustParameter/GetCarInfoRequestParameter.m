//
//  GetCarInfoRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "GetCarInfoRequestParameter.h"

@implementation GetCarInfoRequestParameter

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kCarInfoRequestUrl, self.userId];
	return [ServerURLUtil getFullURL:url];
}

@end
