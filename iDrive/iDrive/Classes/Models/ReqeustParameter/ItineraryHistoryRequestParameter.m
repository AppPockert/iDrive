//
//  ItineraryHistoryRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "ItineraryHistoryRequestParameter.h"

@implementation ItineraryHistoryRequestParameter

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kItineraryHistoryUrl, self.tdCarId, self.startTime, self.endTime];
	return [ServerURLUtil getFullURL:url];
}

@end
