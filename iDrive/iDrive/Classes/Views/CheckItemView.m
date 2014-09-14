//
//  CheckItemView.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-14.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CheckItemView.h"
#import "GPLoadingView.h"

@interface CheckItemView ()

@property (weak, nonatomic) IBOutlet UIImageView *resultIcon;
@property (weak, nonatomic) IBOutlet GPLoadingView *loadingView;
@property (weak, nonatomic) IBOutlet UILabel *checkItemDescription;

@end

@implementation CheckItemView

- (id)check:(id)item {
	self.resultIcon.hidden = YES;
	[self.loadingView startAnimation];

	return nil;
}

@end
