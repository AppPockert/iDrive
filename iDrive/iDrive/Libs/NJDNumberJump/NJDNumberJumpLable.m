//
//  NJDNumberJumpLable.m
//  iDrive
//
//  Created by 钱宇杰 on 14-10-12.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "NJDNumberJumpLable.h"
#import "CATextLayer+NumberJump.h"

@interface NJDNumberJumpLable () {
	CATextLayer *textLayer;
}

@end

@implementation NJDNumberJumpLable

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setUp];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setUp];
	}
	return self;
}

- (void)setUp {
	textLayer = [[CATextLayer alloc] init];
	textLayer.string = @"0";
	textLayer.alignmentMode = @"right";
	textLayer.frame = self.frame;
	textLayer.backgroundColor = [UIColor blackColor].CGColor;
	[self.layer addSublayer:textLayer];
}

- (void)setValue:(float)value {
	[textLayer jumpNumberWithDuration:1 fromNumber:_value toNumber:value];
	_value = value;
}

- (void)setFontSize:(float)fontSize {
	textLayer.fontSize = fontSize;
}

- (float)fontSize {
	return textLayer.fontSize;
}

@end
