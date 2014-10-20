//
//  AutoInsuranceViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-25.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "AutoInsuranceViewController.h"
#import "PlistFilePathManager.h"
#import "NSStringUtil.h"

#define FileName     @"InsuranceType.plist"

@interface AutoInsuranceViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSMutableArray *selectItems;

@end

@implementation AutoInsuranceViewController

- (void)viewDidLoad {
	[super viewDidLoad];

    NSString *path = [PlistFilePathManager getFullPath:FileName options:FilePathOptionTypeUserDocument | FilePathOptionTypeCopyFromBundle];
    
    _dataSource = [NSArray arrayWithContentsOfFile:path];
    
    if ([NSStringUtil isValidate:self.selectedItem]) {
        _selectItems = [NSMutableArray arrayWithArray:[self.selectedItem componentsSeparatedByString:@","]];
    } else {
        _selectItems = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
	self.identifer = kAutoInsurance;
}

-(IBAction)done:(id)sender {
    NSString *allItems;
    if ([self.selectItems count] > 0) {
        [self.selectItems sortUsingComparator:^(id obj1, id obj2){
            return [self.dataSource indexOfObject:obj1] > [self.dataSource indexOfObject:obj2];
        }];
        allItems = [self.selectItems componentsJoinedByString:@","];
    } else {
        allItems = @"";
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectObject:with:)]) {
        [self.delegate didSelectObject:allItems with:self.identifer];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAutoInsurance forIndexPath:indexPath];
	cell.textLabel.text = self.dataSource[indexPath.row];
    
    if ([self.selectItems containsObject:cell.textLabel.text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *item = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.selectItems containsObject:item]) {
        [self.selectItems removeObject:item];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [self.selectItems addObject:item];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

@end
