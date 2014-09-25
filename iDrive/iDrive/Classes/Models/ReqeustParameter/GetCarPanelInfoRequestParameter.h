//
//  GetCarPanelInfoRequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"

/**
 *  获取车辆面板信息请求参数
 */
@interface GetCarPanelInfoRequestParameter : RequestParameter

@property (strong, nonatomic) NSString *equipmentSNnum;

@end
