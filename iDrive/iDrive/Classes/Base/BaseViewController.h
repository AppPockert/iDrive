//
//  BaseViewController.h
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

/**
 *  共通视图控制类
 */

#import "MBProgressHUD.h"

@class RequestService;
@class RequestParameter;

@interface BaseViewController : UIViewController {
	@protected
	MBProgressHUD *HUD;
}

@property (assign, nonatomic) BOOL shouldAutoShowHUD; // 是否请求开始时自动显示HUD，默认是YES
@property (assign, nonatomic) BOOL shouldAutoHideHUD; // 是否请求结束时自动隐藏HUD，默认是YES

/**
 *  发送处理请求
 *
 *  @param service   请求服务
 *  @param parameter 请求参数
 */
- (void)sendRequestTo:(RequestService *)service with:(RequestParameter *)parameter;

/**
 *  处理请求结果，子类需要重写以处理各种请求回来的结果
 *
 *  @param result  请求结果
 *  @param service 请求服务
 */
- (void)handleResult:(id)result of:(RequestService *)service;

- (IBAction)popAction:(id)sender;

@end
