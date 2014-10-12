//
//  AutoInsuranceViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-25.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "AutoInsuranceViewController.h"

@interface AutoInsuranceViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation AutoInsuranceViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.identifer = kAutoInsurance;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAutoInsurance forIndexPath:indexPath];
	cell.textLabel.text = @"1";
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectObject:with:)]) {
		[self.delegate didSelectObject:@"1" with:self.identifer];

		[self.navigationController popViewControllerAnimated:YES];
	}
}

@end
