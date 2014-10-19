//
//  CarAbnormalService.m
//  iDrive
//
//  Created by 钱宇杰 on 14/10/19.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CarAbnormalService.h"
#import "ASIHTTPRequest.h"
#import "ServerURLUtil.h"
#import "UserInfo.h"

@interface CarAbnormalService () <ASIHTTPRequestDelegate> {
    BOOL _inBackGround;
}

@end

@implementation CarAbnormalService

#pragma mark - 检测车辆异动

- (void)shouldCheckCarAbnormal:(BOOL)check {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkCarAbnormal) object:nil];
    if (check) {
        [self checkCarAbnormal];
    }
}

- (void)checkCarAbnormal {
    NSURL *url = [NSURL URLWithString:[ServerURLUtil getFullURL:[NSString stringWithFormat:kCarAbnormalUrl,
                                                                 kAppDelegate.getUserInfo.SN]]];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:&error];
    if (!error && result) {
        //
    } else {
        NSLog(@"车辆异动检测失败！");
    }
    
    if (!_inBackGround) {
        [self performSelector:@selector(checkCarAbnormal) withObject:nil afterDelay:300.f];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"车辆异动检测失败！");
    
    if (!_inBackGround) {
         [self performSelector:@selector(checkCarAbnormal) withObject:nil afterDelay:300.f];
    }
}


#pragma mark

- (void)applicationDidEnterBackground:(UIApplication *)application {
    _inBackGround = YES;
    [application setKeepAliveTimeout:600.f handler:^{
        [self checkCarAbnormal];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    _inBackGround = NO;
    [application clearKeepAliveTimeout];
    [self checkCarAbnormal];
}

@end
