//
//  LoginViewController.h
//  ZZAFNetworking
//
//  Created by zzj on 15/9/7.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYLoginViewController : UIViewController

@property (nonatomic, strong) UIImageView *logImageView;// log
@property (nonatomic, strong) UITextField *accountTextField;//账户名/手机号
@property (nonatomic, strong) UITextField *passwordTextField;//登录密码
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *fgPwButton;

//自定义清除按钮
@property (nonatomic, strong) UIButton *clearButton;


@end
