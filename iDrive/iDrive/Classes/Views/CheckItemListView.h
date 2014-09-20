//
//  CheckItemListView.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-14.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

@protocol CheckItemListViewDelegate <NSObject>
// 所有检测完毕
- (void)allCheckDidCompleted:(id)result;

@end

/**
 *  车辆体检各检测项列表
 */

@interface CheckItemListView : UIView

@property (assign, nonatomic) id <CheckItemListViewDelegate> delegate;
@property (strong, nonatomic) NSArray *checkList; // 待检测列表

/**
 *  开始检测
 */
- (void)startCheck;

/**
 *  停止检测
 */
- (void)stopCheck;

@end
