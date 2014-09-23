//
//  ItineraryHistoryRequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"

/**
 *  历史轨迹请求参数
 */
@interface ItineraryHistoryRequestParameter : RequestParameter

@property (strong, nonatomic) NSString *tdCarId; // 车辆ID
@property (strong, nonatomic) NSString *startTime; //起始时间
@property (strong, nonatomic) NSString *endTime; //结束时间

@end
