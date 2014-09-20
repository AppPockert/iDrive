//
//  TrajectoryMapViewController.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-8.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

/**
 *  轨迹地图：行程管理(历史轨迹)/实时轨迹
 */

typedef NS_ENUM (int, TrajectoryType) {
	TrajectoryTypeRealTime,
	TrajectoryTypeHistory
};

@interface TrajectoryMapViewController : BaseViewController

@property (assign, nonatomic) TrajectoryType trajectoryType; // 行程类型
@property (strong, nonatomic) NSArray *pointsForLine; // 轨迹点

@end
