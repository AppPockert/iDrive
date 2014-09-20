//
//  ItineraryHistory.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

/**
 *  历史行程数据
 */
@interface ItineraryHistory : NSObject

@property (strong, nonatomic) NSString *time; // 时长
@property (strong, nonatomic) NSString *mileage; // 里程
@property (strong, nonatomic) NSString *fuelConsumption; // 油耗
@property (strong, nonatomic) NSArray *coordinates; // 历史坐标点

@end
