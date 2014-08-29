//
//  UserInfo.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.account forKey:@"account"];
	[coder encodeObject:self.password forKey:@"password"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	self = [super init];

	if (self) {
		self.account = [decoder decodeObjectForKey:@"account"];
		self.password = [decoder decodeObjectForKey:@"password"];
	}

	return self;
}

@end
