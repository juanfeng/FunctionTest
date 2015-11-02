//
//  ButlerForceAlertPasswordVC.m
//  FunctionTest
//
//  Created by zzj on 15/10/19.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "ButlerForceAlertPasswordVC.h"

#define kTEXT_FONT [UIFont systemFontOfSize:13]
#define kHEAD_VIEW_H 615.0/1335*kSCREENHEIGHT
#define kHEIGHT_CELL 40
@interface ButlerForceAlertPasswordVC ()

@property (nonatomic, strong) NSMutableArray *leftNameArr;
@property (nonatomic, strong) NSString *rightPlaceholderStr;

//密码是否是明文
@property (nonatomic, assign) BOOL isExist;

@end

@implementation ButlerForceAlertPasswordVC{
    CGFloat topBackViewW;
    CGFloat topBackViewH;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBACK_COLOR;
    
    [self initData];
    [self setBodyUI];

}

- (void)viewDidLayoutSubviews{
    
    if ([self.tableViewInfo respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableViewInfo setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableViewInfo respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableViewInfo setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private method

//初始化数据
- (void)initData{
    
    self.leftNameArr = [[NSMutableArray alloc] initWithObjects:@"新登录密码",@"再次输入密码", nil];
    self.rightPlaceholderStr = @"6到18位字母与数字组合";
     _isExist = YES;//密码默认是暗文
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap addTarget:self action:@selector(resumeView)];
    [self.tableViewInfo addGestureRecognizer:tap];
    
}

- (void)setBodyUI{
    
    [self.view addSubview:self.tableViewInfo];
    
}

- (void)configularCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath{
    
    if (1 == indexPath.section) {
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, kHEIGHT_CELL)];
        leftLabel.text = self.leftNameArr[indexPath.row];
        leftLabel.font = kTEXT_FONT;
        [cell.contentView addSubview:leftLabel];
        
        UITextField *rightTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftLabel.frame)+10, 0, kSCREENWIDTH-(CGRectGetMaxX(leftLabel.frame)+10)-60, kHEIGHT_CELL)];
        rightTextField.delegate = self;
        rightTextField.font = kTEXT_FONT;
        rightTextField.tag = indexPath.row + 1;
        rightTextField.secureTextEntry = self.isExist;
        rightTextField.placeholder = self.rightPlaceholderStr;
        [rightTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];//监听输入框
        [cell.contentView addSubview:rightTextField];
        
        0 == indexPath.row ? (self.firstPasswordTF = rightTextField) : (self.secondPasswordTF = rightTextField);
        
        if (0 == indexPath.row) {
            
            UISwitch *rightSwitch = [[UISwitch alloc] init];
            CGFloat switchW = CGRectGetWidth(rightSwitch.frame);
            CGFloat switchH = CGRectGetHeight(rightSwitch.frame);
            
            rightSwitch.frame = CGRectMake(kSCREENWIDTH-switchW-10, (kHEIGHT_CELL - switchH)/2, switchW,switchH);
            rightSwitch.on = self.isExist;
            [rightSwitch addTarget:self action:@selector(onSelectPasswordStyle:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:rightSwitch];
        }
    }else{
        topBackViewW = kSCREENWIDTH;
        topBackViewH = kHEAD_VIEW_H;
        UIView *topBagView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, topBackViewW, topBackViewH)];
        topBagView.backgroundColor = self.tableViewInfo.backgroundColor;
        [cell.contentView addSubview:topBagView];
        
        UIImage *centerImg = [UIImage imageNamed:@"forcepw_butler"];
        CGFloat centerImgW = centerImg.size.width;
        CGFloat centerImgH = centerImg.size.height;
        
        UIImageView *centerImgView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(topBagView.frame)-centerImgW)/2, (CGRectGetHeight(topBagView.frame)-30 - centerImgH)/2+10, centerImgW, centerImgH)];
        centerImgView.image = centerImg;
        [topBagView addSubview:centerImgView];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(centerImgView.frame)+10, CGRectGetWidth(topBagView.frame), 20)];
        tipLabel.textColor = [UIColor blackColor];
        tipLabel.font = [UIFont systemFontOfSize:16];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"为了您的信息安全请立即设定新的密码!";
        [topBagView addSubview:tipLabel];
    }
    
}

- (void)textFieldDidChange:(UITextField*)textField{
    
    if (self.firstPasswordTF.text.length>0 && self.secondPasswordTF.text.length>0) {//确定按钮可点击
        
        self.sureButton.backgroundColor = kWHOLE_COLOR;
        [self.sureButton setEnabled:YES];
        
    }else{//确定按钮不可点击
        
        self.sureButton.backgroundColor = [UIColor lightGrayColor];
        [self.sureButton setEnabled:NO];
    }
}

//判断正则
- (BOOL)checkRegular:(NSString*)text{
    
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:text];
    
    return isMatch;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (0 == section) {
        return 1;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (1 == section) {
        return 100;
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (0 == indexPath.section && 0 == indexPath.row) {
        return kHEAD_VIEW_H;
    }
    return kHEIGHT_CELL;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (1 == section) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 100)];
        UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, kSCREENWIDTH-30, 44)];
        bottomBtn.backgroundColor = [UIColor lightGrayColor];;
        [bottomBtn.layer setMasksToBounds:YES];
        [bottomBtn.layer setCornerRadius:4];
        bottomBtn.enabled = NO;
        [bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
        [bottomBtn addTarget:self action:@selector(onClickSureBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.sureButton = bottomBtn;
        [footerView addSubview:bottomBtn];
        return footerView;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [self configularCell:cell indexPath:indexPath];
    }

    
    return cell;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tableViewInfo.frame = CGRectMake(0, -(40 + 50*textField.tag), kSCREENWIDTH, kSCREENHEIGHT);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self resumeView];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //不能输入空格
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

#pragma mark - getters and setters

- (UITableView *)tableViewInfo{
    
    if (!_tableViewInfo) {
        _tableViewInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableViewInfo.dataSource = self;
        _tableViewInfo.delegate = self;
        _tableViewInfo.backgroundColor = self.view.backgroundColor;
        _tableViewInfo.scrollEnabled = NO;
        _tableViewInfo.separatorColor = [UIColor colorWithWhite:0.70f alpha:0.2f];
    }
    return _tableViewInfo;
}

#pragma mark - event response

//确定按钮
- (void)onClickSureBtn:(UIButton*)sender{
    
    if ([self.firstPasswordTF.text isEqualToString:self.secondPasswordTF.text]){
        
        if ([self checkRegular:self.firstPasswordTF.text] && [self checkRegular:self.secondPasswordTF.text]) {
            
            NSLog(@"确定修改密码");
            
        }else{
            [self setAlertView:@"密码为6到18位的字母与数字组合"];
        }
        
    }else{
        
        [self setAlertView:@"两次密码输入不一致"];
    }
}

- (void)setAlertView:(NSString*)alertStr{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:alertStr delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)onSelectPasswordStyle:(UISwitch*)sender{
    
    if (sender.on) {//明文
        self.firstPasswordTF.secureTextEntry = YES;
        self.secondPasswordTF.secureTextEntry = YES;
    }else{//暗文
        self.firstPasswordTF.secureTextEntry = NO;
        self.secondPasswordTF.secureTextEntry = NO;
    }
    
}

//恢复视图
- (void)resumeView{
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.tableViewInfo.frame = CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT);
    }];
}

@end
