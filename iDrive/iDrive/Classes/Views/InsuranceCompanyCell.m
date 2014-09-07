//
//  InsuranceCompanyCell.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "InsuranceCompanyCell.h"

@implementation InsuranceCompanyCell

- (void)setCompanyInfo:(NSDictionary *)companyInfo {
	_companyInfo = companyInfo;

	self.textLabel.text = companyInfo[@"name"];
	self.detailTextLabel.text = companyInfo[@"phone"];
}

- (IBAction)call:(id)sender {
	NSString *telUrl = [NSString stringWithFormat:@"tel://%@", _companyInfo[@"phone"]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];

	NSLog(@"%@", telUrl);
}

@end
