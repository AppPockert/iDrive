//
//  BMKStartOrEndPointAnnotation.h
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

// 点的类型
typedef NS_ENUM (int, PointType) {
	PointTypeStart,
	PointTypeEnd
};

#import "BMKPointAnnotation.h"

/**
 *  行程的起点或终点的Annotation
 */
@interface BMKStartOrEndPointAnnotation : BMKPointAnnotation

@property (assign, nonatomic) PointType type;

@end
