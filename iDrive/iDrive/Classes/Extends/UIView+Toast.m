//
//  UIView+Toast.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "UIView+Toast.h"

@implementation UIView (Toast)

- (void)makeToast:(NSString *)message {
	UIView *oldBGView = [[self keyWindow] viewWithTag:550];

	if (oldBGView) {
		UILabel *oldToast = (UILabel *)[oldBGView viewWithTag:555];
		if (oldToast && [oldToast.text isEqualToString:message]) {
			return;
		}
	}

	float y = kScreenHeight - 88.f;

	UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, y, 320.0f, 44.0f)];
	bgView.backgroundColor = [UIColor clearColor];
	bgView.clipsToBounds = YES;
	bgView.tag = 550;

	[[self keyWindow] addSubview:bgView];
	[self createAndShowToastInBackgroundView:bgView message:message];
}

- (void)createAndShowToastInBackgroundView:(UIView *)bgView message:(NSString *)message {
	UILabel *toast = [[UILabel alloc] initWithFrame:CGRectMake(0, 44.0f, 320.0f, 44.0f)];
	[toast setBackgroundColor:[UIColor orangeColor]];
	[toast setText:message];
	[toast setTextAlignment:NSTextAlignmentCenter];
	[toast setTextColor:[UIColor whiteColor]];
	[toast setFont:[UIFont systemFontOfSize:13.0f]];
	[toast setTag:555];
	[bgView addSubview:toast];

	[UIView animateWithDuration:.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut
	                 animations: ^{
	    CGRect frame = toast.frame;
	    frame.origin.y -= 44.0f;
	    toast.frame = frame;
	}

	                 completion: ^(BOOL finished) {
	    [UIView animateWithDuration:.5f delay:1.5f options:UIViewAnimationOptionCurveEaseInOut animations: ^{
	        CGRect frame = toast.frame;
	        frame.origin.y += 44.0f;
	        toast.frame = frame;
		} completion: ^(BOOL finished) {
	        [toast removeFromSuperview];
	        [bgView removeFromSuperview];
		}];
	}];
}

- (UIWindow *)keyWindow {
	return [[[UIApplication sharedApplication] delegate] window];
}

@end
