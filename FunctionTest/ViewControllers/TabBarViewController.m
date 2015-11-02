//
//  TabBarViewController.m
//  FunctionTest
//
//  Created by zzj on 15/9/14.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "TabBarViewController.h"
#import "PKProgressView.h"
#import "CustomerDetailVC.h"

#define kBTN_BASE_FLAG 100
@interface TabBarViewController ()

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLoginOutBtn];
    [self setBodyUI];
}

- (void)setBodyUI{
    
//    PKProgressView *pkprogressView = [[PKProgressView alloc] initWithFrame:CGRectMake(100, 200, 120, 40)];
//    
//    pkprogressView.pkpProgress = 1.0f;
//    
//    [self.view addSubview:[pkprogressView returnPKPViewType:pkprogressView]];
    
//    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 50)];
//    [self.view addSubview:_headView];
//    
//    [self.view addSubview:self.scrollView];
    
    NSArray *btnTitleArr = @[@"对讲",@"健康",@"足迹",@"安全区域",@"登陆",@"我",@"测试"];
    for (int i=0; i<btnTitleArr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 80+(35 + 10)*i, kSCREENWIDTH*3/5, 35)];
        [btn setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor orangeColor];
        btn.tag = kBTN_BASE_FLAG + i;
        [btn addTarget:self action:@selector(onClickTo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
//        [self.scrollView addSubview:btn];
        
    }
}

- (void)onClickTo:(UIButton*)sender{
    
    switch (sender.tag) {
        case kBTN_BASE_FLAG+0:
        {
            RYProfessionalKnowledgecellSeekVC *ryPKSeekVC = [[RYProfessionalKnowledgecellSeekVC alloc] init];
            [self.navigationController pushViewController:ryPKSeekVC animated:YES];
        }
            break;
        case kBTN_BASE_FLAG+1:
        {
            FinanceProductDetailVC *finacePDVC = [[FinanceProductDetailVC alloc] init];
            [self.navigationController pushViewController:finacePDVC animated:YES];
        }
            
            break;
        case kBTN_BASE_FLAG+2:
        {
            LoanApplyListVC *loanALVC = [[LoanApplyListVC alloc] init];
            [self.navigationController pushViewController:loanALVC animated:YES];
        }
            
            break;
        case kBTN_BASE_FLAG+3:
        {
            MessageMainVC *messageMainVC = [[MessageMainVC alloc] init];
            [self.navigationController pushViewController:messageMainVC animated:YES];
        }
            
            break;
        case kBTN_BASE_FLAG+4:
        {
//            ForceAlertPasswordVC *alertPasswordVC = [[ForceAlertPasswordVC alloc] init];
            ButlerForceAlertPasswordVC *alertPasswordVC = [[ButlerForceAlertPasswordVC alloc] init];
            [self presentViewController:alertPasswordVC animated:NO completion:nil];
        }
            
            break;
        case kBTN_BASE_FLAG+5:
        {
            /*
            MyMainViewController *myMainVC = [[MyMainViewController alloc] init];
            [self.navigationController pushViewController:myMainVC animated:YES];
             */
            CustomerDetailVC *customerDetailVC = [[CustomerDetailVC alloc] init];
            
            [self.navigationController pushViewController:customerDetailVC animated:NO];
        }
            
            break;
        case kBTN_BASE_FLAG+6:
        {
            TestVC *testVC = [[TestVC alloc] init];
            [self.navigationController pushViewController:testVC animated:YES];
        }
            
            break;
            
        default:
            break;
    }
    
}

- (void)presentLoginVC{
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    RYLoginViewController *ryLoginVC = [[RYLoginViewController alloc] init];
    [delegate.window setRootViewController:ryLoginVC];
}

//退出登录
- (void)onloginOut{
   
   //清除cookies
    [Tool clearCookies];
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"password"];
    [setting synchronize];
    
    [self performSelector:@selector(presentLoginVC) withObject:nil afterDelay:0.1];
}

- (void)setLoginOutBtn{
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightBtn setTitle:@"退出" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [rightBtn addTarget:self action:@selector(onloginOut) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), kSCREENWIDTH, kSCREENHEIGHT - CGRectGetMaxY(_headView.frame))];
    }
    
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
