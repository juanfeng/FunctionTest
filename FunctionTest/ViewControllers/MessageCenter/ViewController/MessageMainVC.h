//
//  MessageMainVC.h
//  FunctionTest
//
//  Created by zzj on 15/10/10.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "BaseViewController.h"

@interface MessageMainVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewInfo;

@end
