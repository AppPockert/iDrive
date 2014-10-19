//
//  FliterCoordinateService.h
//  iDrive
//
//  Created by 钱宇杰 on 14/10/19.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import <Foundation/Foundation.h>

// 筛选GPS点
@interface FliterCoordinateService : NSObject

+ (NSArray *)fliterCoordinates:(NSArray *)gpsList;

@end
