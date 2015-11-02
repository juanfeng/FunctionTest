//
//  CustomerLoanApplyVC.m
//  FunctionTest
//
//  Created by zzj on 15/10/28.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "CustomerLoanApplyVC.h"

@interface CustomerLoanApplyVC ()

@end

@implementation CustomerLoanApplyVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACK_COLOR;
    
    [self setNavigationBar];
    [self initData];
    [self setBodyUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - private method

- (void)setNavigationBar{
    
    self.title = [NSString stringWithFormat:@"%@的借款申请",self.titleStr];
}

- (void)initData{
    
}

- (void)setBodyUI{
    
    [self.view addSubview:self.tableViewInfo];
}

- (void)configularCell:(UITableViewCell*)cell andIndexPath:(NSIndexPath *)indexPath{
    
    cell.textLabel.text = @"数据时间";
    
}

#pragma mark - event response


#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configularCell:cell andIndexPath:indexPath];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

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

@end
