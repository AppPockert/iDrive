//
//  BaseViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "BaseViewController.h"
#import "RequestService.h"

#import <objc/runtime.h>

/**  RequestService Delegate Category  **/

@protocol RequestServiceDelegate <NSObject>

- (void)service:(RequestService *)service didCompleted:(id)result;

@end

@interface RequestService (Delegate)

@property (assign, nonatomic) id <RequestServiceDelegate> delegate;

- (void)callServiceWith:(RequestParameter *)parameter;

@end

@implementation RequestService (Delegate)

static char RequestServiceDelegate;

@dynamic delegate;

- (void)callServiceWith:(RequestParameter *)parameter {
	__block id result;

	dispatch_async(dispatch_get_global_queue(0, 0), ^{
	    result = [self beginDealWith:parameter];
	    dispatch_async(dispatch_get_main_queue(), ^{
	        if (self.delegate && [self.delegate respondsToSelector:@selector(service:didCompleted:)]) {
	            [self.delegate service:self didCompleted:result];
			}
		});
	});
}

- (void)setDelegate:(id <RequestServiceDelegate> )delegate {
	objc_setAssociatedObject(self,
	                         &RequestServiceDelegate,
	                         delegate,
	                         OBJC_ASSOCIATION_ASSIGN);
}

- (id <RequestServiceDelegate> )delegate {
	return objc_getAssociatedObject(self, &RequestServiceDelegate);
}

@end

/**  RequestService Delegate Category  **/


/**  ********************************  **/

@interface BaseViewController () <RequestServiceDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	HUD.opacity = .5f;
	[self.view addSubview:HUD];

	self.shouldAutoShowHUD = YES;
	self.shouldAutoHideHUD = YES;
}

- (void)sendRequestTo:(RequestService *)service with:(RequestParameter *)parameter {
	[HUD show:self.shouldAutoShowHUD];

	service.delegate = self;
	[service callServiceWith:parameter];
}

- (void)handleResult:(id)result of:(RequestService *)service {
	NSString *alram = [NSString stringWithFormat:@"Class \"%@\" had not override method:\"handleResult:(id)result of:(RequestService *)service\"", NSStringFromClass([self class])];

	NSAssert(NO, alram);
}

#pragma mark - RequestServiceDelegate

- (void)service:(RequestService *)service didCompleted:(id)result {
	[self handleResult:result of:service];

	[HUD hide:self.shouldAutoHideHUD];
}

@end
