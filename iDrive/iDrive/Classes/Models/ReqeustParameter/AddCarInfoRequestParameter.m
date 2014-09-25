//
//  AddCarInfoRequestParameter.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-23.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "AddCarInfoRequestParameter.h"

@implementation AddCarInfoRequestParameter

- (NSString *)urlByAppendParameter {
	NSString *url = [NSString stringWithFormat:kSaveCarIno, self.carLicenseid, self.carModel, self.carMotorid, self.carUsercompany, self.carInsurancemaintainInfo, self.carTestInfo, self.carObdRt, self.carDriver];
	return [ServerURLUtil getFullURL:url];
}

@end
