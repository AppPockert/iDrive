//
//  RealTimeTrajectoryRequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"

/**
 *  实时轨迹请求参数
 */
@interface RealTimeTrajectoryRequestParameter : RequestParameter

@property (strong, nonatomic) NSString *tdCarId;

@end
