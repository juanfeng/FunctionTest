//
//  ForgetPasswordVerificationVC.m
//  FunctionTest
//
//  Created by zzj on 15/9/18.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "ForgetPasswordVerificationVC.h"

@interface ForgetPasswordVerificationVC ()<UITableViewDataSource>

@property (nonatomic, strong) NSString *leftName;
@property (nonatomic, strong) NSString *rightPlaceHolder;
@property (nonatomic, assign) NSInteger second;
@property (nonatomic, assign) CGFloat rvfwidth;
@property (nonatomic, strong) UISwitch *switchBtn;

@end

#define kCELLHEIGHT 50
@implementation ForgetPasswordVerificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initData];
    [self setLeftBackButton];
    [self setBodyUI];
}

//初始化数据
- (void)initData{
    
    self.second = 60;
    
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
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setBodyUI{
    
    [self createTextField];
    [self.view addSubview:self.tableViewInfo];
    
    self.tableViewInfo.tableFooterView = [self createtableViewFooterView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.tableViewInfo addGestureRecognizer:tapGesture];
    [tapGesture addTarget:self action:@selector(onTapTouch)];
}

- (void)onTapTouch{
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.tableViewInfo.frame = CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 20;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.01;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kCELLHEIGHT;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 40)];
        
        _switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(kSCREENWIDTH-70, 5, 0, 0)];
        [_switchBtn setOn:YES];
        [_switchBtn addTarget:self action:@selector(onSwitch:) forControlEvents:UIControlEventValueChanged];
        [headerView addSubview:_switchBtn];
        
        return headerView;
    }
    
    return nil;
}

//选择是否是密文
- (void)onSwitch:(UISwitch*)switchBtn{
    
    BOOL isButtonOn = switchBtn.on;
    if (isButtonOn) {
        
        self.firstPasswordTF.secureTextEntry = YES;
        self.secondPasswordTF.secureTextEntry = YES;
        
    }else{
        
        self.firstPasswordTF.secureTextEntry = NO;
        self.secondPasswordTF.secureTextEntry = NO;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
        [self configularTableViewCell:cell andIndexPath:indexPath];
    }
    
    return cell;
}

- (void)configularTableViewCell:(UITableViewCell*)cell andIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *leftNameArr = @[@"新密码:",@"再次新密码:"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        self.leftName = @"验证码:";
        [cell.contentView addSubview:self.leftNameLabel];
        [cell.contentView addSubview:self.rVerificationBtn];
        self.verifiCationTF.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:self.verifiCationTF];
        
    }else{
        self.leftName = leftNameArr[indexPath.row];
        
        [cell.contentView addSubview:self.leftNameLabel];
        
        if (indexPath.row == 0) {
            
            self.firstPasswordTF.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:self.firstPasswordTF];
            
        }else{
            
            self.secondPasswordTF.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:self.secondPasswordTF];
        }
        
    }
}

//进行下一步操作
- (void)onNextClick{
  
    [self getRequestDataSure];
    
}

- (void)getRequestDataSure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"http://192.168.253.33:82/api_v2/User/ResetPassword?phoneNo=%@&verifyCode=%@&newPassword=%@",@"15555446189",self.verifiCationTF.text,self.secondPasswordTF.text] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary*)responseObject;
        NSString *status = [NSString stringWithFormat:@"%@",dict[@"Status"]];
        NSString *message = [NSString stringWithFormat:@"%@",dict[@"Message"]];
        if ([status intValue] == 1) {
           
            NSLog(@"密码修改成功");
            RYLoginViewController *ryLoginVC = [[RYLoginViewController alloc] init];
            [self presentViewController:ryLoginVC animated:NO completion:nil];
        }else{
            
            NSLog(@"message %@",message);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)createTextField{
    
    NSArray *rightPlaceholderArr = @[@"请输入验证码",@"请输入新密码",@"请再次输入新密码"];
    
    for (int i=0; i<3; i++) {
        i == 0 ? (self.rvfwidth = 70) : (self.rvfwidth = 0);
        UITextField *rightNameTF = [[UITextField alloc] initWithFrame:CGRectMake(115, 0, kSCREENWIDTH-15-115 - self.rvfwidth, kCELLHEIGHT)];
        [rightNameTF setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [rightNameTF setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        rightNameTF.placeholder = rightPlaceholderArr[i];
        rightNameTF.delegate = self;
        rightNameTF.secureTextEntry = YES;
        rightNameTF.tag = 100+i;
        i == 0 ? (self.verifiCationTF = rightNameTF):(i == 1 ? (self.firstPasswordTF = rightNameTF) : (self.secondPasswordTF =  rightNameTF));
    }
    
}

- (UIView *)createtableViewFooterView{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 44)];
    
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, kSCREENWIDTH - 30, 44)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn.layer setMasksToBounds:YES];
    [sureBtn.layer setCornerRadius:6];
    [sureBtn addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [sureBtn setBackgroundImage:[Tool createImageWithColor:[UIColor colorWithRed:24/255.0f green:143/255.0f blue:202/255.0f alpha:1.0f] rect:CGRectMake(0, 0, kSCREENWIDTH-30, 44)] forState:UIControlStateNormal];
    [footerView addSubview:sureBtn];
    return footerView;
}

//开始倒计时
- (void)startTimer{
    
    __block NSInteger timeout = self.second;//倒计时时间
     __block UIButton *verificationBtn = _rVerificationBtn;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                verificationBtn.userInteractionEnabled = YES;
                [verificationBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                [verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
            
        }else{
            NSString *strTime = [NSString stringWithFormat:@"%.2ld", (long)timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                verificationBtn.userInteractionEnabled = NO;
                [verificationBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [verificationBtn setTitle:strTime forState:UIControlStateNormal];
                
            });
            timeout--;
        }
        
    });
    dispatch_resume(_timer);
}

//获取验证码
- (void)onGetVerification{
    
    [self startTimer];
    [self getVerificationRequest];
    
}

//发送验证码请求
- (void)getVerificationRequest{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   [manager POST:[NSString stringWithFormat:@"http://192.168.253.33:82/api_v2/User/GetVerifyCode?phoneNo=%@",@"15555446189"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       NSLog(@"验证码发送成功！");
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"验证码发送失败error %@",[error description]);
    }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
   
    
    [UIView animateWithDuration:1.0 animations:^{
        
        if (textField == self.firstPasswordTF) {
            
            self.tableViewInfo.frame = CGRectMake(0, -20, kSCREENWIDTH, kSCREENHEIGHT);
            
        }else if (textField == self.secondPasswordTF){
            
            self.tableViewInfo.frame = CGRectMake(0, -50, kSCREENWIDTH, kSCREENHEIGHT);
        }else{
            
             textField.secureTextEntry = NO;
        }
        
    }];
    
    
    
}

- (UIButton *)rVerificationBtn{
    
    if (!_rVerificationBtn) {
        _rVerificationBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSCREENWIDTH - 70-15, 10, 70, kCELLHEIGHT-20)];
        [_rVerificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_rVerificationBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_rVerificationBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_rVerificationBtn setBackgroundColor:[UIColor purpleColor]];
        [_rVerificationBtn addTarget:self action:@selector(onGetVerification) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rVerificationBtn;
}

- (UILabel *)leftNameLabel{
    
    _leftNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, kCELLHEIGHT)];
    _leftNameLabel.text = self.leftName;
    _leftNameLabel.font = [UIFont systemFontOfSize:16];
    _leftNameLabel.textAlignment = NSTextAlignmentLeft;
    
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
