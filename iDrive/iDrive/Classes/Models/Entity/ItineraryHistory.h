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

@property (strong, nonatomic) NSString *startTime;       // 起始时间
@property (strong, nonatomic) NSString *endTime;         // 结束时间
@property (strong, nonatomic) NSString *mileage;         // 里程
@property (strong, nonatomic) NSString *fuelConsumption; // 油耗
@property (strong, nonatomic) NSArray *coordinates;      // 历史坐标点
@property (strong, nonatomic) NSString *avgSpeed;        // 平均速度
@property (strong, nonatomic) NSString *avgOilCost;      // 平均油耗

@end

#import <CoreLocation/CoreLocation.h>

@interface Coordinate : NSObject

@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;

- (CLLocationCoordinate2D)toCoordinate;

@end
