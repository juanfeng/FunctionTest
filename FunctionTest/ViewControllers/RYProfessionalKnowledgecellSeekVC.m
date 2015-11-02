//
//  RYProfessionalKnowledgecellSeekVC.m
//  FunctionTest
//
//  Created by zzj on 15/9/16.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "RYProfessionalKnowledgecellSeekVC.h"

@interface RYProfessionalKnowledgecellSeekVC ()

@end

#define kCELLHEIGHT 50
@implementation RYProfessionalKnowledgecellSeekVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [Tool backButton:self btnText:@"业务知识查询" action:@selector(onClickPop) addTarget:self];
}

- (void)onClickPop
{
//    POP;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setBodyUI];
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

- (UIView *)createtableViewFooterView{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 44)];
    
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *seekBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, kSCREENWIDTH - 30, 44)];
    [seekBtn setTitle:@"立即查询" forState:UIControlStateNormal];
    [seekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seekBtn.layer setMasksToBounds:YES];
    [seekBtn.layer setCornerRadius:6];
    [seekBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [seekBtn setBackgroundImage:[Tool createImageWithColor:[UIColor colorWithRed:24/255.0f green:143/255.0f blue:202/255.0f alpha:1.0f] rect:CGRectMake(0, 0, kSCREENWIDTH-30, 44)] forState:UIControlStateNormal];
    [footerView addSubview:seekBtn];
    return footerView;
}

-(UITextField *)rightNameTF{
    
    if (!_rightNameTF) {
        _rightNameTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftNameLabel.frame), 0, kSCREENWIDTH-15-CGRectGetMaxX(self.leftNameLabel.frame), kCELLHEIGHT)];
        _rightNameTF.placeholder = @"请输入查询名称";
        [_rightNameTF setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_rightNameTF setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        _rightNameTF.textAlignment = NSTextAlignmentRight;
    }
    
    return _rightNameTF;
}

- (UILabel *)leftNameLabel{
    
    if (!_leftNameLabel) {
        _leftNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, kCELLHEIGHT)];
        _leftNameLabel.text = @"名称";
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
