//
//  CheckItemListView.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-14.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CheckItemListView.h"
#import "CheckItemView.h"

@interface CheckItemListView ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) BOOL shouldStop;

@end

@implementation CheckItemListView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		_scrollView = [[UIScrollView alloc] initWithFrame:frame];
		[self addSubview:_scrollView];

		self.scrollView.userInteractionEnabled = NO;
	}
	return self;
}

- (void)startCheck {
	if ([self.checkList count] == 0) {
		return;
	}

	// 遍历待检测项，如果不需要停止则继续，直到检测完毕
	for (int i = 0; i < [self.checkList count] && !_shouldStop; i++) {
		CheckItemView *checkItem = [[[NSBundle mainBundle] loadNibNamed:@"CheckItemView"
		                                                          owner:self options:nil] lastObject];

		CGRect frame = checkItem.frame;
		frame.origin.y = frame.size.height * i;
		checkItem.frame = frame;

//		id result = [checkItem check:self.checkList[i]];

		// 把待检测的项目的View加到scrollview里，并增加scrollview的contentsize
		[self.scrollView addSubview:checkItem];
		[self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, frame.size.height * (i + 1))];

		CGFloat contentSizeHeight = self.scrollView.contentSize.height;
		CGFloat heigth = self.scrollView.frame.size.height;
		// 添加待检测项目后，超出scrollview的显示范围则自动往下移
		if (contentSizeHeight > heigth) {
			[self.scrollView setContentOffset:CGPointMake(0.f, contentSizeHeight - heigth) animated:YES];
		}
	}

	if (_shouldStop) {
		return;
	}

#warning 返回检测结果
}

- (void)stopCheck {
	_shouldStop = YES;
}

@end
