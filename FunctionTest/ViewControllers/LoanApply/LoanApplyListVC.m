//
//  LoanApplyListVC.m
//  FunctionTest
//
//  Created by zzj on 15/9/28.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "LoanApplyListVC.h"
#import "LoanApplyListCell.h"
#import "KxMenu.h"

#define kFOOTERVIEW_H 44
@interface LoanApplyListVC ()

@end

@implementation LoanApplyListVC{
    
    //状态
    NSString *_statusStr;
}

- (void)setNavigationItem{
    
    UIImage *rightImg = [UIImage imageNamed:@"ic_apply_selectStatus"];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, rightImg.size.width, rightImg.size.height)];
    [rightBtn setImage:rightImg forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(popIndefineView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItem];
    [self setBodyUI];
}

- (void)setBodyUI{
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.tableViewInfo];
    
    
    //创建下面的button
    [self createFooterViewWithButton];
}

//创建借款申请
- (void)onClickCreateApply{
    
    NSLog(@"创建借款申请");
}

//选择状态
- (void)popIndefineView:(UIButton*)sender{
    
    if ([[KxMenu sharedMenu] isShowPopView]) {
        [KxMenu dismissMenu];
        //        _isRefreshControlRefreshed = NO;
        [[KxMenu sharedMenu] setIsShowPopView:NO];
        return;
    }
    
    [[KxMenu sharedMenu] setIsShowPopView:YES];
    
    //    count = 0;
    
    //选中状态
    BOOL isSelectFirstItem = NO;
    BOOL isSelectSecondItem = NO;
    BOOL isSelectThirdItem = NO;
    BOOL isSelectFourthItem = NO;
    
    if ([_statusStr isEqualToString:@""]) {
        isSelectFirstItem = YES;
    }else if([_statusStr isEqualToString:@"0,1,2,3,4,5,6,-2,-3"]){
        isSelectSecondItem = YES;
    }else if([_statusStr isEqualToString:@"7"]){
        isSelectThirdItem = YES;
    }else{
        isSelectFourthItem = YES;
    }
    
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@" 全   部 "
                     image:[UIImage imageNamed:@"ic_apply_pop_all"]
                    target:self
                    action:@selector(pushMenuItem:) tag:1 isSelect:isSelectFirstItem],
      
      [KxMenuItem menuItem:@" 未完成 "
                     image:[UIImage imageNamed:@"ic_apply_pop_no_finish"]
                    target:self
                    action:@selector(pushMenuItem:) tag:2 isSelect:isSelectSecondItem],
      
      [KxMenuItem menuItem:@" 已通过 "
                     image:[UIImage imageNamed:@"ic_apply_pop_pass"]
                    target:self
                    action:@selector(pushMenuItem:) tag:3 isSelect:isSelectThirdItem],
      
      [KxMenuItem menuItem:@" 已作废 "
                     image:[UIImage imageNamed:@"ic_apply_pop_no"]
                    target:self
                    action:@selector(pushMenuItem:) tag:4 isSelect:isSelectFourthItem]
      
      ];
    
    CGRect rect = sender.frame;
    rect.origin.y = 62;
    [KxMenu showMenuInView:self.navigationController.view
                  fromRect:rect
                 menuItems:menuItems];
    
}

- (void)pushMenuItem:(id)sender{
    
    [[KxMenu sharedMenu] setIsShowPopView:NO];
    
    KxMenuItem *item = (KxMenuItem *)sender;
    
    switch (item.tag) {
        case 1:
            _statusStr = @"";break;
        case 2:
            _statusStr = @"0,1,2,3,4,5,6,-2,-3";break;
        case 3:
            _statusStr = @"7";break;
        case 4:
            _statusStr = @"-1,-5,-6";break;
        default:
            break;
    }
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 105;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LoanApplyListCell *listCell = [[[NSBundle mainBundle] loadNibNamed:@"LoanApplyListCell" owner:self options:nil] lastObject];
    [listCell configularCell:listCell andRowWithIndexPath:indexPath];
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return listCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableView *)tableViewInfo{
    
    if (!_tableViewInfo) {
        _tableViewInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT - kFOOTERVIEW_H) style:UITableViewStyleGrouped];
        _tableViewInfo.showsVerticalScrollIndicator = NO;
        _tableViewInfo.dataSource = self;
        _tableViewInfo.delegate = self;
        _tableViewInfo.backgroundColor = self.view.backgroundColor;
    }
    
    return _tableViewInfo;
    
}

- (void)createFooterViewWithButton{
    
    UIButton *footerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kSCREENHEIGHT-kFOOTERVIEW_H, kSCREENWIDTH, kFOOTERVIEW_H)];
    footerBtn.backgroundColor = [UIColor colorWithRed:76/255.0f green:176/255.0f blue:252/255.0f alpha:1.0f];
    
//    footerBtn.backgroundColor = [UIColor colorWithRed:219/255.0f green:219/255.0f blue:219/255.0f alpha:1.0f];
//    footerBtn.userInteractionEnabled = NO;
    [footerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footerBtn setTitle:@"创建借款申请" forState:UIControlStateNormal];
    [footerBtn addTarget:self action:@selector(onClickCreateApply) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:footerBtn];
}

@end
