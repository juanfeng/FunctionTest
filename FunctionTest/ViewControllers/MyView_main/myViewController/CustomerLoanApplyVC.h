//
//  CustomerLoanApplyVC.h
//  FunctionTest
//
//  Created by zzj on 15/10/28.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerLoanApplyVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewInfo;

@property (nonatomic, strong) NSString *titleStr;

@end
