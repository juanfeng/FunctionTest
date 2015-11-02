//
//  ForgetPasswordVerificationVC.h
//  FunctionTest
//
//  Created by zzj on 15/9/18.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordVerificationVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableViewInfo;
@property (nonatomic, strong) UILabel *leftNameLabel;
//@property (nonatomic, strong) UITextField *rightNameTF;
@property (nonatomic, strong) UIButton *rVerificationBtn;

@property (nonatomic, strong) UITextField *verifiCationTF;
@property (nonatomic, strong) UITextField *firstPasswordTF;
@property (nonatomic, strong) UITextField *secondPasswordTF;

@end
