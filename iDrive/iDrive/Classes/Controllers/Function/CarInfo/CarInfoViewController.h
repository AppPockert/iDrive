//
//  CarInfoViewController.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-6.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

/**
 *  车辆信息
 */

@interface CarInfoViewController : BaseViewController

@property (assign, nonatomic) BOOL shouldUpdate;      // 是否是主页面过来，需要更新
@property (assign, nonatomic) BOOL isFirstTimeToFill; // 是否是第一次填写

@end
