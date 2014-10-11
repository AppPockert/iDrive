//
//  CDTouchUpGestureRecognizer.m
//  iDrive
//
//  Created by 钱宇杰 on 14-10-10.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CDTouchUpGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "CDCircle.h"

@interface CDTouchUpGestureRecognizer ()

@property (assign, nonatomic) BOOL moved;

@end

@implementation CDTouchUpGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	// 两个手指及以上时，手势失败
	if ([[event touchesForGestureRecognizer:self] count] > 1) {
		[self setState:UIGestureRecognizerStateFailed];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	self.moved = YES;
	// 手势移动时，手势失败
	[self setState:UIGestureRecognizerStateFailed];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (self.moved) {
		[self setState:UIGestureRecognizerStateFailed];
	}
	else {
		[self setState:UIGestureRecognizerStateEnded];
	}
	self.moved = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self setState:UIGestureRecognizerStateFailed];
	self.moved = NO;
}

@end
