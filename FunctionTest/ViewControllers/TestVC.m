//
//  TestVC.m
//  FunctionTest
//
//  Created by zzj on 15/11/2.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TestVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACK_COLOR;
    
    [self configuInitData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - private method

- (void)configuInitData{
    
    self.isRefresh = YES;
}

- (void)configUI{
    
    [self.view addSubview:self.tableViewInfo];
    [self.tableViewInfo addSubview:self.testActivityIndicator];
//    [self.tableViewInfo addSubview:self.refreshControl];
}

- (void)reloadRefreshControl:(id)sender{
    
    if (self.isRefresh) {
        [self.refreshControl endRefreshing];
    }else{
        self.isRefresh = !self.isRefresh;
    }
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [UITableViewCell new];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.isRefresh) {
        [self.testActivityIndicator startAnimating];
    }else{
        [self.testActivityIndicator stopAnimating];
    }
    
}

#pragma mark - event response

#pragma mark - getters and setters

- (UITableView *)tableViewInfo{
    
    if (!_tableViewInfo) {
        _tableViewInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableViewInfo.dataSource = self;
        _tableViewInfo.delegate = self;
        _tableViewInfo.backgroundColor = self.view.backgroundColor;
        _tableViewInfo.backgroundColor = self.view.backgroundColor;
        _tableViewInfo.separatorColor = [UIColor colorWithWhite:0.8f alpha:0.3f];
        _tableViewInfo.showsVerticalScrollIndicator = NO;
    }
    return _tableViewInfo;
}

- (UIRefreshControl *)refreshControl{
    
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        _refreshControl.center = CGPointMake(CGRectGetMaxX(self.tableViewInfo.frame)*2/3, 100.0f);
        _refreshControl.tintColor = [UIColor orangeColor];
        [_refreshControl addTarget:self action:@selector(reloadRefreshControl:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _refreshControl;
}

- (UIActivityIndicatorView *)testActivityIndicator{
    
    if (!_testActivityIndicator) {
        _testActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _testActivityIndicator.center = CGPointMake(80.0f, -10.0f);//只能设置中心，不能设置大小
        _testActivityIndicator.color = [UIColor redColor]; // 改变圈圈的颜色为红色； iOS5引入
        [_testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
    }
    
    return _testActivityIndicator;
}

@end
