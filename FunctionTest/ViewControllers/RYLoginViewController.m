//
//  LoginViewController.m
//  ZZAFNetworking
//
//  Created by zzj on 15/9/7.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "RYLoginViewController.h"

@interface RYLoginViewController ()<UITextFieldDelegate>

@end

#define kSCROLLTIME 0.5
@implementation RYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0f green:248/255.0f blue:251/255.0f alpha:1.0f];
    
    [self getBodyUI];
   
}

//构建UI
- (void)getBodyUI{
    
    [self.view addSubview:self.logImageView];
    self.accountTextField = nil;
    self.passwordTextField = nil;
    
    [self setTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.lineView];//忘记密码下面的横线
    [self.view addSubview:self.fgPwButton];
    
    //添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [tapGesture addTarget:self action:@selector(onTapTouch:)];
    [self.view addGestureRecognizer:tapGesture];
}

//触摸事件
- (void)onTapTouch:(UITapGestureRecognizer*)tapGesture{
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:kSCROLLTIME animations:^{
        self.view.frame = CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setTextField{
    
    
    NSArray *phArr = @[@"账号名/手机号",@"登录密码"];
    for (int i=0; i<phArr.count; i++) {
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.logImageView.frame)+35 + i*(45-2), kSCREENWIDTH-30, 45)];
        [textField.layer setMasksToBounds:YES];
        textField.backgroundColor = [UIColor whiteColor];
        [textField.layer setCornerRadius:1.0f];
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [UIColor colorWithWhite:200/255.0f alpha:0.4].CGColor;
        textField.tag = 110+i;
        textField.placeholder = phArr[i];
        [textField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];//修改placeholder字体颜色
        [textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];//修改placeholder字体大小
        textField.returnKeyType = UIReturnKeyNext;
        
        //设置左边空白
        textField.textColor = kWHOLE_COLOR;
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 0)];
        textField.leftViewMode = UITextFieldViewModeAlways;
        
//        //设置右边清除
//        textField.rightView = self.clearButton;
//        textField.rightView.tag = 210+i;
//        textField.rightViewMode = UITextFieldViewModeWhileEditing;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        //设置代理
        textField.delegate = self;
        
        if (i == 0) {
            self.accountTextField = textField;
        }else
            self.passwordTextField = textField;
        
        [self.view addSubview:textField];
    }
}

//清除文字
- (void)onClickClearText:(UIButton*)sender{
    
    if (sender.tag == 210) {//账号
        self.accountTextField.text = nil;
    }else if (sender.tag == 211){//密码
        self.passwordTextField.text = nil;
    }
    
}

//登录
- (void)onClickLogin:(UIButton*)sender{
    
    /*
    if ([Tool IsNoNetworkConnection]) {
        
        [Tool showHudLoadingWithString:@"正在加载" andStatus:MMProgressHUDPresentationStyleNone];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager POST:api_login_on parameters:[NSDictionary dictionaryWithObjectsAndKeys:@"15812345678",@"userName",@"11",@"password", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [MMProgressHUD dismiss];
            
            NSDictionary *responseDict = (NSDictionary*)responseObject;
            NSLog(@"responseObject %@",responseObject);
            NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"Status"]];
             NSString *message = [NSString stringWithFormat:@"%@",responseDict[@"Message"]];
             NSString *result = [NSString stringWithFormat:@"%@",responseDict[@"Result"]];
            
            if ([status boolValue]) {//登录成功
                
                [Tool setCookies];
                
                [self saveSettingData:result];
                [self turnPage];
                
                
            }else{//登录失败
                
                [Tool showAlertViewWithTitle:nil andMessage:message anddelegate:nil andcancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [Tool showHudErrorWithDelay:0.5];
        }];
        
    }else{
        
        NSLog(@"无法连接网络，请稍候重试！");
        
    }
     */
    
    [self turnPage];
    
}

- (void)saveSettingData:(NSString*)result{//对密码加密，保存数据
    
    //对密码加密，保存数据
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setObject:@"15812345678" forKey:@"userName"];
    [settings setObject:[AESCrypt encrypt:@"11" password:@"password"] forKey:@"password"];
    [settings setObject:result forKey:@"result"];
    //同步磁盘
    [settings synchronize];
    
}

//界面跳转
- (void)turnPage{
    
    TabBarViewController  *tabBarVC = [[TabBarViewController alloc] init];
    UINavigationController *NaTabBarVC = [[UINavigationController alloc] initWithRootViewController:tabBarVC];
    [self presentViewController:NaTabBarVC animated:NO completion:nil];
}

//忘记密码
- (void)onClickFgPw:(UIButton*)sender{
    
    ForgetPasswordPhoneVC *fppVC = [[ForgetPasswordPhoneVC alloc] init];
    UINavigationController *navfppVC = [[UINavigationController alloc] initWithRootViewController:fppVC];
    [self presentViewController:navfppVC animated:NO completion:nil];
    
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == self.accountTextField) {
        [UIView animateWithDuration:kSCROLLTIME animations:^{
            self.view.frame = CGRectMake(0, -60, kSCREENWIDTH, kSCREENHEIGHT+60);
        }];
    }else{
        
        [UIView animateWithDuration:kSCROLLTIME animations:^{
            self.view.frame = CGRectMake(0, -100, kSCREENWIDTH, kSCREENHEIGHT+100);
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    [self.passwordTextField becomeFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@" "]) {//禁止输入空格
        return NO;
    }
    
    return YES;
}

- (UIImageView *)logImageView{
    
    UIImage *logImg = [UIImage imageNamed:@"loginLog"];
    CGFloat imgHeight = 70;//logImg.size.height;
    CGFloat imgWidth = logImg.size.width/logImg.size.height * imgHeight;//logImg.size.width;
   
    if (!_logImageView) {
        _logImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kSCREENWIDTH-imgWidth)/2, 320.0/1330*kSCREENHEIGHT, imgWidth, imgHeight)];
        _logImageView.backgroundColor = [UIColor clearColor];
        _logImageView.image = logImg;
    }
    
    return _logImageView;
}

- (UIButton *)loginButton{
    
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.passwordTextField.frame)+30, kSCREENWIDTH-30, 44)];
        _loginButton.backgroundColor = kWHOLE_COLOR;
        [_loginButton.layer setMasksToBounds:YES];
        [_loginButton.layer setCornerRadius:4];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_loginButton addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _loginButton;
}

- (UIView *)lineView{
    
    if (!_lineView) {
        //忘记密码下面的横线
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.fgPwButton.frame)-CGRectGetHeight(self.fgPwButton.frame)/2, kSCREENWIDTH-40, 0.5)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        _lineView.alpha = 0.15;
        [_fgPwButton insertSubview:_lineView belowSubview:_fgPwButton];
        
        //网址
        UILabel *websiteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kSCREENHEIGHT-80.0/1330*kSCREENHEIGHT, kSCREENWIDTH, 10)];
        websiteLabel.text = @"http://www.rongyu100.com";
        websiteLabel.font = [UIFont systemFontOfSize:10];
        websiteLabel.textColor = [UIColor lightGrayColor];
        websiteLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:websiteLabel];
    }
    
    return _lineView;
}

- (UIButton *)fgPwButton{
    
    if (!_fgPwButton) {
        _fgPwButton = [[UIButton alloc] initWithFrame:CGRectMake((kSCREENWIDTH-100)/2, kSCREENHEIGHT - 160.0/1330*kSCREENHEIGHT, 100, 20)];
        [_fgPwButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_fgPwButton setTitleColor:kWHOLE_COLOR forState:UIControlStateNormal];
        _fgPwButton.backgroundColor = self.view.backgroundColor;
        _fgPwButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_fgPwButton addTarget:self action:@selector(onClickFgPw:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fgPwButton;
}

- (UIButton *)clearButton{
    
//    UIImage *btnImg = [UIImage imageNamed:@"tFTextClear"];
//    CGFloat btnHeight = 50;
//    CGFloat btnWidth = btnImg.size.width/btnImg.size.height * btnHeight;
//    _clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
//    _clearButton.imageView.frame = CGRectMake(0, 0, 30, 10);
//    [_clearButton setImage:btnImg forState:UIControlStateNormal];
//    [_clearButton addTarget:self action:@selector(onClickClearText:) forControlEvents:UIControlEventTouchUpInside];
    return _clearButton;
}

@end
