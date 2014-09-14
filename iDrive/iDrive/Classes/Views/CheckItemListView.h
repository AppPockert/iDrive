//
//  CheckItemListView.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-14.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

@protocol CheckItemListViewDelegate <NSObject>

- (void)allCheckDidCompleted:(id)result;

@end

/**
 *  车辆体检各检测项列表
 */

@interface CheckItemListView : UIView

@property (assign, nonatomic) id <CheckItemListViewDelegate> delegate;
@property (strong, nonatomic) NSArray *checkList;

- (void)startCheck;
- (void)stopCheck;

@end
