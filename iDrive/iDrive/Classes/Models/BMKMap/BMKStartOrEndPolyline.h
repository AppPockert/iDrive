//
//  BMKStartOrEndPolyline.h
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "BMKPolyline.h"

/**
 *  此类用于定义一段折线
 */
@interface BMKStartOrEndPolyline : BMKPolyline

@property (strong, nonatomic) NSString *startDate;
@property (strong, nonatomic) NSString *endDate;

@end
