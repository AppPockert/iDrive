//
//  ItineraryHistoryViewController.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "ItineraryHistoryViewController.h"
#import "ItineraryDetailCell.h"
#import "ItineraryHistory.h"
#import "TrajectoryMapViewController.h"

@interface ItineraryHistoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation ItineraryHistoryViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ItineraryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItineraryDetailCell" forIndexPath:indexPath];
	cell.history = self.dataSource[indexPath.row];
	return cell;
}

#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	// 历史行程
	if ([segue.identifier isEqualToString:kItinerayDetial]) {
		TrajectoryMapViewController *trajector = segue.destinationViewController;
		trajector.trajectoryType = TrajectoryTypeHistory;
		trajector.history = ((ItineraryDetailCell *)sender).history;
	}
}

@end
