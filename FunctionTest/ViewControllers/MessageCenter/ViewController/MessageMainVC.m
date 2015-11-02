
//
//  MessageMainVC.m
//  FunctionTest
//
//  Created by zzj on 15/10/10.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "MessageMainVC.h"
#import "MessageMainCell.h"
#import "KxMenu.h"

#define kBTNSELECTBACK_COLOR [UIColor orangeColor]
#define kBTNNORMALBACK_COLOR [UIColor darkGrayColor]
@interface MessageMainVC ()

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *botLine;

@end

@implementation MessageMainVC{
    
    CGFloat currentMoveY;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBar];
    
    [self initData];
    
    [self setBodyUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private method

- (void)setNavigationBar{
    
    UIImage *iconImg = [UIImage imageNamed:@"creditDetailBtn"];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, iconImg.size.width, iconImg.size.height)];
    [rightBtn setImage:iconImg forState:UIControlStateNormal];

    [rightBtn addTarget:self action:@selector(popIndefineView:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)initData{

}

- (void)setBodyUI{
    
    
    [self setHeadView:_headView];
    
    [self.view addSubview:self.tableViewInfo];
    
}

- (void)setHeadView:(UIView *)headView{
    
    if (!_headView) {
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kSCREENWIDTH, 44)];
        _headView.backgroundColor = [UIColor whiteColor];
        NSArray *btnTitleArr = @[@"全部",@"已读",@"未读"];
        CGFloat btnWidth = (kSCREENWIDTH-40)/btnTitleArr.count;
        
        for (int j = 0; j<btnTitleArr.count; j++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20+btnWidth*j, 0, btnWidth, CGRectGetHeight(_headView.frame)-2)];
            [btn setTitle:btnTitleArr[j] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(onSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 10+j;
            j == 0 ? ([btn setTitleColor:kBTNSELECTBACK_COLOR forState:UIControlStateNormal]) : ([btn setTitleColor:kBTNNORMALBACK_COLOR forState:UIControlStateNormal]);
            [_headView addSubview:btn];
        }
        
        self.lineView.frame = CGRectMake(20, CGRectGetHeight(_headView.frame)-2, btnWidth, 2);
        [_headView addSubview:self.lineView];
    }
    
    [self.view addSubview:_headView];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageMainCell *cell = [[NSBundle mainBundle] loadNibNamed:@"MessageMainCell" owner:self options:nil][0];
    
    return cell;
}

#pragma mark - event response

- (void)popIndefineView:(UIButton*)sender{
    
    if ([[KxMenu sharedMenu] isShowPopView]) {
        [KxMenu dismissMenu];
        [[KxMenu sharedMenu] setIsShowPopView:NO];
        return;
    }
    
    [[KxMenu sharedMenu] setIsShowPopView:YES];
    
    //选中状态
    BOOL isSelectFirstItem = NO;
    BOOL isSelectSecondItem = NO;
    BOOL isSelectThirdItem = NO;
    
    
    NSArray *menuItems = @[[KxMenuItem menuItem:@"消      息  " image:nil target:self action:@selector(pushMenuItem:) tag:1 isSelect:isSelectFirstItem],[KxMenuItem menuItem:@"同      行  " image:nil target:self action:@selector(pushMenuItem:) tag:2 isSelect:isSelectSecondItem],[KxMenuItem menuItem:@"客      户  " image:nil target:self action:@selector(pushMenuItem:) tag:3 isSelect:isSelectThirdItem]];
    
    
    CGRect rect = sender.frame;
    rect.origin.y = 62;
    
    [KxMenu showMenuInView:self.navigationController.view
                  fromRect:rect
                 menuItems:menuItems];
}

- (void)pushMenuItem:(id)sender{
    
    KxMenuItem *item = (KxMenuItem *)sender;
    [[KxMenu sharedMenu] setIsShowPopView:NO];
    
    switch (item.tag) {
        case 1:
            
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
    
}

#pragma mark 头部点击按钮事件

- (void)onSelectClick:(UIButton*)sender{
    
    [UIView animateWithDuration:0.1 animations:^{
        CGRect tampFrame = self.lineView.frame;
        tampFrame.origin.x = CGRectGetMinX(sender.frame);
        self.lineView.frame = tampFrame;
    }];
    
    [sender setTitleColor:kBTNSELECTBACK_COLOR forState:UIControlStateNormal];
    for (UIView *view in self.headView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)view;
            if (btn != sender) {
                [btn setTitleColor:kBTNNORMALBACK_COLOR forState:UIControlStateNormal];
            }
        }
    }
    
    switch (sender.tag) {
        case 10://全部
            
            
            break;
        case 11://已读
            
            break;
            
        case 12://未读
            
            break;
            
        default:
            break;
    }
    
}

#pragma mark - getters and setters

- (UITableView *)tableViewInfo{
    
    if (!_tableViewInfo) {
        _tableViewInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), kSCREENWIDTH, CGRectGetHeight(self.view.frame)-CGRectGetMaxY(_headView.frame)) style:UITableViewStyleGrouped];
        _tableViewInfo.backgroundColor = self.view.backgroundColor;
        _tableViewInfo.delegate = self;
        _tableViewInfo.dataSource = self;
        _tableViewInfo.showsVerticalScrollIndicator = NO;
    }
    
    return _tableViewInfo;
}

- (UIView *)lineView{
    
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = kBTNSELECTBACK_COLOR;
    }
    
    return _lineView;
}


@end
