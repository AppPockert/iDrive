//
//  SelectableViewController.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

@protocol SelectableViewControllerDelegate <NSObject>

- (void)didSelectObject:(id)object with:(NSString *)identifer;

@end

/**
 *  选择画面，用于各种需要用户做选择的画面
 */
@interface SelectableViewController : BaseViewController

@property (assign, nonatomic) id <SelectableViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *identifer; // 标识符，标识当前选择画面的类型

@end
