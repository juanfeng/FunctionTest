//
//  CustomerDetailVC.m
//  FunctionTest
//
//  Created by zzj on 15/10/26.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "CustomerDetailVC.h"
#import "MyScrollView.h"
#import "CustomerDetailVCTopCell.h"
#import "CustomerLoanApplyVC.h"

#define kSCROLL_H 100
#define kDEFAULTCELL_H 44
#define kTOPVIEW_H 120
@interface CustomerDetailVC ()

@property (nonatomic, strong) MyScrollView *applyTypeView;

@end

#pragma mark - life cycle

@implementation CustomerDetailVC{
    
    NSArray *titleNameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACK_COLOR;
    
    [self setNavigationBar];
    [self initData];
    [self setBodyUI];
    [self setBottomButton];
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

-(void)setNavigationBar{
    
    self.title = @"客户详情";
//    [Tool backButton:self btnText:@"客户详情" action:@selector(onClickPop) addTarget:self];

    self.extendedLayoutIncludesOpaqueBars = YES;
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [rightBtn addTarget:self action:@selector(onClickPhone) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"myscan"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",@"myscan"]] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)initData{
    
    titleNameArr = [[NSArray alloc] initWithObjects:@"借款申请",@"信用档案", nil];
}

- (void)setBodyUI{
    
    [self.view addSubview:self.tableViewInfo];
}

- (void)configularCell:(UITableViewCell*)cell andIndexPath:(NSIndexPath*)indexPath{
    
    //在cell上设置头部的cell
    [self setTopViewWithCell:cell andIndexPath:indexPath];
    
    //在cell上设置UIScrollView的cell
    [self setScrollViewWithCell:cell andIndexPath:indexPath];
    
    //设置左边图片右边文字的cell
    [self setLeftImgWithTitleCell:cell andIndexPath:indexPath];
    
}

- (void)setTopViewWithCell:(UITableViewCell*)cell andIndexPath:(NSIndexPath*)indexPath{
   
    if (0 == indexPath.section && 0 == indexPath.row) {
        CustomerDetailVCTopCell *topCell = [[[NSBundle mainBundle] loadNibNamed:@"CustomerDetailVCTopCell" owner:nil options:nil] lastObject];
        topCell.customerNameLabel.text = @"陈逸飞";
        topCell.customerAddressLabel.text = @"广东省 清远市";
        topCell.customerPhoneNumLabel.text = @"15000554815";
        topCell.customerCarIdLabel.text = @"44188119911053222";
        [cell.contentView addSubview:topCell];
    }
    
}

- (void)setLeftImgWithTitleCell:(UITableViewCell*)cell andIndexPath:(NSIndexPath*)indexPath{
    
    if (1 == indexPath.section) {
        
        UIImage *leftImg = [UIImage imageNamed:@"22222"];
        UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (kDEFAULTCELL_H - leftImg.size.height)/2, leftImg.size.width, leftImg.size.height)];
        leftImgView.image = leftImg;
        [cell.contentView addSubview:leftImgView];
        
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImgView.frame)+10, 0, kSCREENWIDTH-(CGRectGetMaxX(leftImgView.frame)+10), kDEFAULTCELL_H)];
        rightLabel.font = [UIFont systemFontOfSize:15];
        rightLabel.text = titleNameArr[indexPath.row];
        rightLabel.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:rightLabel];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
}

- (void)setScrollViewWithCell:(UITableViewCell*)cell andIndexPath:(NSIndexPath*)indexPath{
    
    if (0 == indexPath.section && 1 == indexPath.row) {
        
        _applyTypeView = [[MyScrollView alloc] init];
        _applyTypeView.frame = CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame), kSCROLL_H);
        _applyTypeView.myDataArr = [[NSMutableArray alloc] initWithObjects:@"编辑中的申请",@"成功的申请",@"失败的申请",@"融誉100审核中",@"网络公司审核中",@"金融机构跟踪审核",nil];
        _applyTypeView.myColorArr = [[NSMutableArray alloc] initWithObjects:
                                     COLOR(83, 203, 227, 1.0f),
                                     COLOR(129, 197, 121, 1.0f),
                                     COLOR(244, 115, 88, 1.0f),
                                     COLOR(39, 145, 199, 1.0f),
                                     COLOR(83, 203, 227, 1.0f),
                                     COLOR(252, 185, 98, 1.0f),
                                     nil];
        _applyTypeView.myDataColorArr = [[NSMutableArray alloc] init];
        
        for (int i=0; i<_applyTypeView.myDataArr.count; i++) {
            [_applyTypeView.myDataColorArr addObject: _applyTypeView.myColorArr[i]];
        }
        [_applyTypeView setViewUI];
        
        [cell.contentView addSubview:_applyTypeView];
        
    }
    
}

- (void)setBottomButton{
    
    UIButton *createApplyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kSCREENHEIGHT-44, kSCREENWIDTH, 44)];
    createApplyBtn.backgroundColor = COLOR(39, 145, 199, 1.0f);
    [createApplyBtn setTitle:@"创建借款申请" forState:UIControlStateNormal];
    [createApplyBtn setFont:[UIFont systemFontOfSize:15]];
    [createApplyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createApplyBtn addTarget:self action:@selector(onClickCreate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createApplyBtn];
    
}

#pragma mark - event response

//返回
- (void)onClickPop
{
    //    POP;
}

//拨打电话
- (void)onClickPhone{
    
    
}

- (void)onClickCreate{
    
    if (self.isCanCreate) {
        NSLog(@"能创建");
    }else{
        
        [self setAlertView:@"该客户当前还有未通过融誉100审核的信贷申请，请通过审核后再创建新的借款申请"];
    }
}

- (void)setAlertView:(NSString*)alertStr{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:alertStr delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (0 == section) {
        return 2;
    }
    
    return titleNameArr.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            
            return kTOPVIEW_H;
            
        }else if (1 == indexPath.row){
            
            return kSCROLL_H;
        }
    }
    
    return kDEFAULTCELL_H;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 15;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configularCell:cell andIndexPath:indexPath];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (1 == indexPath.section) {
        
        CustomerLoanApplyVC *customerLoanApplyVC = [[CustomerLoanApplyVC alloc] init];
        customerLoanApplyVC.titleStr = @"陈逸飞";
        [self.navigationController pushViewController:customerLoanApplyVC animated:NO];
        
    }
}

#pragma mark - getters and setters

- (UITableView *)tableViewInfo{
    
    if (!_tableViewInfo) {
        _tableViewInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableViewInfo.dataSource = self;
        _tableViewInfo.delegate = self;
        _tableViewInfo.backgroundColor = self.view.backgroundColor;
        _tableViewInfo.separatorColor = [UIColor colorWithWhite:0.8f alpha:0.3f];
        _tableViewInfo.showsVerticalScrollIndicator = NO;
    }
    return _tableViewInfo;
}

@end
