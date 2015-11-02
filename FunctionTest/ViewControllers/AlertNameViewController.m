//
//  AlertNameViewController.m
//  FunctionTest
//
//  Created by zzj on 15/9/14.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "AlertNameViewController.h"

@interface AlertNameViewController ()<UITableViewDataSource>

@end

@implementation AlertNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setBodyUI];
}

- (void)setBodyUI{
    
    [self.view addSubview:self.tableViewInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableViewInfo{
    
    if (!_tableViewInfo) {
        _tableViewInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH,kSCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableViewInfo.dataSource = self;
    }
    
    return _tableViewInfo;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"数据统一";
    return cell;
}

@end
