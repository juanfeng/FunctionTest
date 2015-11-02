//
//  FinanceProductDetailVC.m
//  FunctionTest
//
//  Created by zzj on 15/9/24.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "FinanceProductDetailVC.h"

#define kFOOTVIEW_HEIGHT 44
#define kICONBTN_FALSE 200
@interface FinanceProductDetailVC ()

@end

@implementation FinanceProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createFooterView];
}

- (void)createFooterView{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, kSCREENHEIGHT - kFOOTVIEW_HEIGHT, 0, kFOOTVIEW_HEIGHT)];
    footerView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:footerView];
    
    NSArray *iconNameArr = @[@"发送到QQ",@"发送到邮件",@"打开"];
    CGFloat iconBtnW = kSCREENWIDTH/3;
    CGFloat iconBtnH = CGRectGetHeight(footerView.frame);
    for (int j=0; j<iconNameArr.count; j++) {
        UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(iconBtnW*j, 0, iconBtnW, iconBtnH)];
        iconBtn.tag = kICONBTN_FALSE + j;
        [iconBtn setTitleColor:kWHOLE_COLOR forState:UIControlStateNormal];
        [iconBtn setTitle:iconNameArr[j] forState:UIControlStateNormal];
        [iconBtn setBackgroundColor:[UIColor whiteColor]];
        [iconBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [iconBtn addTarget:self action:@selector(onClickTo:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:iconBtn];
    }
}

//处理事件
- (void)onClickTo:(UIButton*)sender{
    
    switch (sender.tag) {
        case kICONBTN_FALSE + 0:
        {//发送到QQ
            
        }
            break;
        case kICONBTN_FALSE + 1:
        {//发送到邮件
            
        }
            break;
        case kICONBTN_FALSE + 2:
        {//打开
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
