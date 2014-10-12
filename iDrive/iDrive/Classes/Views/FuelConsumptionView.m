//
//  FuelConsumptionView.m
//  iDrive
//
//  Created by 钱宇杰 on 14-10-12.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "FuelConsumptionView.h"

@implementation FuelConsumptionView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 2.0);
	CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextMoveToPoint(context, -12, 56);
	CGContextAddArcToPoint(context, 10, 0, 420, 10, 170);
	CGContextStrokePath(context);
}

@end
