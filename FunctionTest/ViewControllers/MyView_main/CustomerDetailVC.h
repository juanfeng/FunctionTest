//
//  CustomerDetailVC.h
//  FunctionTest
//
//  Created by zzj on 15/10/26.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong)UIView *headView;

@property (nonatomic, strong) UITableView *tableViewInfo;

@property (nonatomic, assign) BOOL isCanCreate;

@end
