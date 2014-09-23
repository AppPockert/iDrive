//
//  GetExaminationInfoRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "GetExaminationInfoRequestParameter.h"

@implementation GetExaminationInfoRequestParameter

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kExaminationInfoUrl, self.carId];
	return [ServerURLUtil getFullURL:url];
}

@end
