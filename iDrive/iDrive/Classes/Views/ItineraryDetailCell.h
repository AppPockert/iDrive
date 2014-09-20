//
//  ItineraryDetailCell.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-8.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

/**
 *  里程详情TableviewCell
 */

@class ItineraryHistory;

@interface ItineraryDetailCell : UITableViewCell

@property (strong, nonatomic) ItineraryHistory *history; // 历史行程的数据

@end
