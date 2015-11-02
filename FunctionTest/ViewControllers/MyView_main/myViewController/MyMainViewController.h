//
//  MyMainViewController.h
//  FunctionTest
//
//  Created by zzj on 15/10/19.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHeadView.h"

@interface MyMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)MyHeadView *myheadView;

@property (nonatomic, strong) UITableView *tableViewInfo;

@property (nonatomic, strong) NSMutableDictionary *cellSectionDic;

@property (nonatomic, strong) NSArray *setSections;

@property (nonatomic, retain) UIImageView *imgProfile;

@end
