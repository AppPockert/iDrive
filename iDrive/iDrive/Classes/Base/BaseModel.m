//
//  BaseModel.m
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "BaseModel.h"

#import <objc/runtime.h>

@implementation BaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
	if (self) {
		NSArray *propertyKeys = [self propertyKeys];

		for (NSString *key in[dic allKeys]) {
			if (![propertyKeys containsObject:key]) {
				continue;
			}

			id obj = dic[key];
			if ([obj isKindOfClass:[NSArray class]]) {
				[self parseArray:obj forKey:key];
			}
			else if ([obj isKindOfClass:[NSDictionary class]]) {
				[self setValue:[[NSClassFromString(key) alloc] initWithDictionary:obj] forKeyPath:key];
			}
			else {
				if (![obj isKindOfClass:[NSNull class]]) {
					[self setValue:obj forKeyPath:key];
				}
			}
		}
	}
	return self;
}

- (void)parseArray:(NSArray *)array forKey:(NSString *)key {
	[self setValue:array forKeyPath:key];
}

- (NSDictionary *)convertModelToDictionary {
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];

	for (NSString *key in[self propertyKeys]) {
		id propertyValue = [self valueForKey:key];
		if (propertyValue) {
			[dic setObject:propertyValue forKey:key];
		}
	}

	return dic;
}

- (NSArray *)propertyKeys {
	NSMutableArray *propertyKeys = [[NSMutableArray alloc] initWithCapacity:5];

	unsigned int outCount, i;
	objc_property_t *properties = class_copyPropertyList([self class], &outCount);
	for (i = 0; i < outCount; i++) {
		objc_property_t property = properties[i];
		NSString *key = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];

		[propertyKeys addObject:key];
	}
	free(properties);

	return propertyKeys;
}

- (NSString *)description {
	NSString *className = NSStringFromClass([self class]);
	return [NSString stringWithFormat:@"<%@>%@</%@>", className, [self convertModelToDictionary], className];
}

@end
