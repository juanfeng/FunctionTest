//
//  TestVC.h
//  FunctionTest
//
//  Created by zzj on 15/11/2.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewInfo;

@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, strong) UIActivityIndicatorView *testActivityIndicator;

@end
