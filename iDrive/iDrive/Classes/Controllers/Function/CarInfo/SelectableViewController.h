//
//  SelectableViewController.h
//  iDrive
//
//  Created by 钱宇杰 on 14-9-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

@protocol SelectableViewControllerDelegate <NSObject>

- (void)didSelectObject:(id)object with:(NSString *)identifer;

@end

@interface SelectableViewController : BaseViewController

@property (assign, nonatomic) id <SelectableViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *identifer;

@end
