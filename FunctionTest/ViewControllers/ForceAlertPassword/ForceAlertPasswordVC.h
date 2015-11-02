//
//  ForceAlertPasswordVC.h
//  FunctionTest
//
//  Created by zzj on 15/10/15.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForceAlertPasswordVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableViewInfo;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) UITextField *firstPasswordTF;
@property (nonatomic, strong) UITextField *secondPasswordTF;

@end
