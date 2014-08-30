//
//  RequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RequestParameter.h"
#import "ASIFormDataRequest.h"

@interface BaseModel ()

- (NSArray *)propertyKeys;

@end

@implementation RequestParameter

- (void)addPostValueTo:(ASIFormDataRequest *)request {
	for (NSString *key in[self propertyKeys]) {
		id objectValue = [self valueForKeyPath:key];

		[request setPostValue:objectValue forKey:key];
	}
}

@end
