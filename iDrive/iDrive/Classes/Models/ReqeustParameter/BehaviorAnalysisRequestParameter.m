//
//  BehaviorAnalysisRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-25.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "BehaviorAnalysisRequestParameter.h"

@implementation BehaviorAnalysisRequestParameter

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kBehaviorAnalysis, self.equipmentSNnum];
	return [ServerURLUtil getFullURL:url];
}

@end
