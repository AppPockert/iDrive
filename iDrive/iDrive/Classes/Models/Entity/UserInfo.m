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
	[coder encodeObject:self.userTelephone forKey:@"userTelephone"];
	[coder encodeObject:self.userPassword forKey:@"userPassword"];
	[coder encodeObject:self.SN forKey:@"SN"];
	[coder encodeObject:self.carLicense forKey:@"carLicense"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	self = [super init];

	if (self) {
		self.userTelephone = [decoder decodeObjectForKey:@"userTelephone"];
		self.userPassword = [decoder decodeObjectForKey:@"userPassword"];
		self.SN = [decoder decodeObjectForKey:@"SN"];
		self.carLicense = [decoder decodeObjectForKey:@"carLicense"];
	}

	return self;
}

@end
