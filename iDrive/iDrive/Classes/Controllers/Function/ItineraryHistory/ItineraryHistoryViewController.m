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
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ItineraryHistoryViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	_dataSource = [[NSMutableArray alloc] initWithCapacity:5];
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

- (void)handleResult:(id)result of:(RequestService *)service {
}

#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	// 历史行程
	if ([segue.identifier isEqualToString:kItinerayDetial]) {
		TrajectoryMapViewController *trajector = segue.destinationViewController;
		trajector.trajectoryType = TrajectoryTypeHistory;
		trajector.pointsForLine = ((ItineraryDetailCell *)sender).history.coordinates;
	}
}

@end
