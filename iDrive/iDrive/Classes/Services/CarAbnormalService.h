//
//  CarAbnormalService.h
//  iDrive
//
//  Created by 钱宇杰 on 14/10/19.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import <Foundation/Foundation.h>

// 检测车辆异动
@interface CarAbnormalService : NSObject

- (void)shouldCheckCarAbnormal:(BOOL)check;

- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;

@end
