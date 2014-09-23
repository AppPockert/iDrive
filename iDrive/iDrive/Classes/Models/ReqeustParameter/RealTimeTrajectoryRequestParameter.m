//
//  RealTimeTrajectoryRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RealTimeTrajectoryRequestParameter.h"

@implementation RealTimeTrajectoryRequestParameter

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kRealTimeTrajectoryUrl, self.tdCarId];
	return [ServerURLUtil getFullURL:url];
}

@end
