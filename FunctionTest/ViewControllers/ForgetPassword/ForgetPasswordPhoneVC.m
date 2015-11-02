//
//  ForgetPasswordPhoneVC.m
//  FunctionTest
//
//  Created by zzj on 15/9/18.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "ForgetPasswordPhoneVC.h"

@interface ForgetPasswordPhoneVC ()<UITableViewDataSource>

@end

#define kCELLHEIGHT 50
@implementation ForgetPasswordPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBackButton];
    [self setBodyUI];
}

- (void)setLeftBackButton{
    
  UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [backBtn setTitle:@"< 返回" forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(onBackVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
}

- (void)onBackVC{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)setBodyUI{
    
    [self.view addSubview:self.tableViewInfo];
    
    self.tableViewInfo.tableFooterView = [self createtableViewFooterView];
    self.tableViewInfo.scrollEnabled = NO;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.tableViewInfo addGestureRecognizer:tapGesture];
    [tapGesture addTarget:self action:@selector(onTapTouch)];
}

- (void)onTapTouch{
    
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kCELLHEIGHT;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
    [cell.contentView addSubview:self.leftNameLabel];
    [cell.contentView addSubview:self.rightNameTF];
    
    return cell;
}

//进行下一步操作
- (void)onNextClick{
    
    ForgetPasswordVerificationVC *fpvVC = [[ForgetPasswordVerificationVC alloc] init];
    [self.navigationController pushViewController:fpvVC animated:YES];
}

- (UIView *)createtableViewFooterView{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 44)];
    
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, kSCREENWIDTH - 30, 44)];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn.layer setCornerRadius:6];
    [nextBtn addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [nextBtn setBackgroundImage:[Tool createImageWithColor:[UIColor colorWithRed:24/255.0f green:143/255.0f blue:202/255.0f alpha:1.0f] rect:CGRectMake(0, 0, kSCREENWIDTH-30, 44)] forState:UIControlStateNormal];
    [footerView addSubview:nextBtn];
    return footerView;
}

-(UITextField *)rightNameTF{
    
    if (!_rightNameTF) {
        _rightNameTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftNameLabel.frame), 0, kSCREENWIDTH-15-CGRectGetMaxX(self.leftNameLabel.frame), kCELLHEIGHT)];
        _rightNameTF.placeholder = @"请输入手机号码";
        [_rightNameTF setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_rightNameTF setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        _rightNameTF.textAlignment = NSTextAlignmentRight;
    }
    
    return _rightNameTF;
}

- (UILabel *)leftNameLabel{
    
    if (!_leftNameLabel) {
        _leftNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, kCELLHEIGHT)];
        _leftNameLabel.text = @"手机号码";
        _leftNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _leftNameLabel;
}

- (UITableView *)tableViewInfo{
    
    if (!_tableViewInfo) {
        _tableViewInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableViewInfo.dataSource = self;
        _tableViewInfo.delegate = self;
    }
    
    return _tableViewInfo;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
