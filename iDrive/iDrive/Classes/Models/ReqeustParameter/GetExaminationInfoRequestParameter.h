//
//  GetExaminationInfoRequestParameter.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"

/**
 *  获取车辆体检信息请求参数
 */
@interface GetExaminationInfoRequestParameter : RequestParameter

@property (strong, nonatomic) NSString *equipmentSNnum;

@end
