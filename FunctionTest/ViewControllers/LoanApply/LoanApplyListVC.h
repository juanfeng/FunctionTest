//
//  LoanApplyListVC.h
//  FunctionTest
//
//  Created by zzj on 15/9/28.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "BaseViewController.h"

@interface LoanApplyListVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewInfo;

@end
