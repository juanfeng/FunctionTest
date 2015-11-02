//
//  MyMainViewController.m
//  FunctionTest
//
//  Created by zzj on 15/10/19.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "MyMainViewController.h"
#import "MyScrollView.h"
#import "MyCustomerScrollView.h"
#import "DragonTigerCell.h"
#import "CustomerDetailVC.h"

static CGFloat ImageWidth  = 320.0;

#define kTOP_H 25
#define kLEFT_MAR 10
#define kSCROLL_H 100
#define kSECTION_HVH 30
#define kTOPVIEW_H 490.0f/1335*kSCREENHEIGHT
@interface MyMainViewController ()

@property (nonatomic, strong) UIScrollView *customerScroll;

@property (nonatomic, strong) NSMutableArray *leftImgArr;

@property (nonatomic, strong) MyScrollView *applyTypeView;

@property (nonatomic, strong) MyCustomerScrollView *myCustomerScrollView;

@end

@implementation MyMainViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = kBACK_COLOR;
    
    [self setMyheadView];
    
    [self setNavigationBar];
    
    [self initData];
    [self reloadDataSource];
    [self setBodyUI];
    
    
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
    
    //    [Tool backButton:self btnText:@"我" action:@selector(popClick) addTarget:self];
    
    //navigationController与navigationBar之间的横线置空
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.backgroundColor = [UIColor purpleColor];
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [leftBtn addTarget:self action:@selector(onBackClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"ryback_main_topBar_Icon"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",@"ryback_main_topBar_Icon"]] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [rightBtn addTarget:self action:@selector(onClickToScan) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"myscan"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",@"myscan"]] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.title = @"我";
}

- (void)setMyheadView{
    
    self.myheadView = [[MyHeadView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 300)];
    self.myheadView.backgroundColor = [UIColor clearColor];
     self.tableViewInfo.tableHeaderView  = self.myheadView;
}


//初始化数据
- (void)initData{
    
    NSArray *firstSectionArr = [[NSArray alloc] initWithObjects:@"", nil];
    NSArray *secondSectionArr = [[NSArray alloc] initWithObjects:@"", nil];
    NSArray *thirdSectionArr = [[NSArray alloc] initWithObjects:@"",@"", nil];
    NSArray *fourSectionArr = [[NSArray alloc] initWithObjects:@"",@"", nil];
    
    self.setSections = [[NSArray alloc] initWithObjects:@"firstSectionArr",@"secondSectionArr",@"thirdSectionArr",@"fourSectionArr", nil];
    
    self.cellSectionDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:firstSectionArr,@"firstSectionArr",secondSectionArr,@"secondSectionArr",thirdSectionArr,@"thirdSectionArr",fourSectionArr,@"fourSectionArr",nil];
    
    self.leftImgArr = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"", nil];
    
}

- (void)setBodyUI{
    
    
    UIImage *image = [UIImage imageNamed:@"green_my_backGround.png"];
    self.imgProfile = [[UIImageView alloc] initWithImage:image];
    self.imgProfile.frame = CGRectMake(0, 0, ImageWidth, kSCREENHEIGHT);
    
    [self.view addSubview:self.imgProfile];
    
    [self.view addSubview:self.tableViewInfo];
}

//请求数据
- (void)reloadDataSource{
    
    NSMutableArray *againFourSectionArr = [[NSMutableArray alloc] initWithArray:[self.cellSectionDic objectForKey:@"fourSectionArr"]];
    [againFourSectionArr addObjectsFromArray:[[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E", nil]];
    [self.cellSectionDic setObject:[againFourSectionArr copy] forKey:@"fourSectionArr"];
    
    [self.tableViewInfo reloadData];
}

- (void)setLeftImgWithTitleCell:(UITableViewCell*)cell andIndexPath:(NSIndexPath*)indexPath{
    
    UIImage *leftImg;
    UIImageView *leftImgView;
    NSString *str;
    UIColor *labTextColor;
    UIImageView *newsImgView;
    CGRect labelFrame;
    CGFloat imgW;
    CGFloat imgH;
    
    
    if (1 == indexPath.section && 0 == indexPath.row){
        
        leftImg = [UIImage imageNamed:@"my_pager"];
        imgW = leftImg.size.width;
        imgH = leftImg.size.height;
        
        leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kLEFT_MAR, (44 - imgH)/2, imgW, imgH)];
        str = @"我的红包";
        labTextColor = [UIColor blackColor];
        
        labelFrame = CGRectMake(CGRectGetMaxX(leftImgView.frame)+kLEFT_MAR, 0, 80, 44);
        
        UIImage *newsImg = [UIImage imageNamed:@"newsTipIcon"];
        CGFloat iconW = newsImg.size.width;
        CGFloat iconH = newsImg.size.height;
        newsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labelFrame), (44 - iconH)/2, iconW, iconH)];
        newsImgView.image = newsImg;
        [cell.contentView  addSubview:newsImgView];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else if (2 == indexPath.section && 0 == indexPath.row){
        
        leftImg = [UIImage imageNamed:@"my_addCustomer"];
        imgW = leftImg.size.width;
        imgH = leftImg.size.height;
        
        leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kLEFT_MAR, (44 - imgH)/2, imgW, imgH)];
        str = @"创建客户";
        labTextColor = [UIColor blackColor];
        
        labelFrame = CGRectMake(CGRectGetMaxX(leftImgView.frame)+kLEFT_MAR, 0, 80, 44);
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (3 == indexPath.section && 0 == indexPath.row){
        
        leftImg = [UIImage imageNamed:@"my_imperialcrown"];
        imgW = leftImg.size.width;
        imgH = leftImg.size.height;
        
        leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kLEFT_MAR, (44 - imgH)/2, imgW, imgH)];
        
        str = @"龙虎榜";
        labTextColor = [UIColor blackColor];
        
        labelFrame = CGRectMake(CGRectGetMaxX(leftImgView.frame)+kLEFT_MAR, 0, 80, 44);
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREENWIDTH - 95, 0, 80, 44)];
        rightLabel.textColor = [UIColor orangeColor];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.text = @"龙虎榜说明";
        rightLabel.font = [UIFont systemFontOfSize:11];
        [cell.contentView addSubview:rightLabel];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    leftImgView.image = leftImg;
    [cell.contentView  addSubview:leftImgView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = labelFrame;
    nameLabel.text = str;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = labTextColor;
    nameLabel.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:nameLabel];
}

- (void)setScrollViewWithCell:(UITableViewCell*)cell andIndexPath:(NSIndexPath*)indexPath{
    
    if (0 == indexPath.section && 0 == indexPath.row) {
        
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
            
            [_applyTypeView.myDataColorArr addObject:[UIColor lightGrayColor]];
            
        }
        [_applyTypeView setViewUI];
        
        [cell.contentView addSubview:_applyTypeView];
    }else if (2 == indexPath.section && 1 == indexPath.row){
        
        _myCustomerScrollView = [[MyCustomerScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame), kSCROLL_H)];
        [cell.contentView addSubview:_myCustomerScrollView];
    }
}

- (void)setDragonTigerCell:(DragonTigerCell*)cell andIndexPath:(NSIndexPath*)indexPath{
    
    NSArray *imgArr = @[@"DragonCopy",@"TigerCopy",@"WolfCopy",@"CowCopy",@"SheepCopy"];
    //龙虎榜
    if (3 == indexPath.section) {
        
        if (1 == indexPath.row) {
            
            NSArray *cellTitleArr = [[NSArray alloc] initWithObjects:@"等级",@"名称",@"总数",@"90天新增", nil];
            cell.rankImgView.hidden = YES;
            cell.rankLabel.hidden = NO;
            cell.rankLabel.text = cellTitleArr[0];
            cell.nameLabel.text = cellTitleArr[1];
            cell.allCountLabel.text = cellTitleArr[2];
            cell.numberLabel.text = cellTitleArr[3];
            
         }else if(indexPath.row > 1 && indexPath.row < imgArr.count+2){
             /*
             int newCustomer = [model.NewCustomer floatValue];
             int applicationCreatedBeatRate = [model.ApplicationCreatedBeatRate floatValue]*100;
             int checkingBeatRate = [model.CheckingBeatRate floatValue]*100;
             int successCreditBeatRate = [model.SuccessCreditBeatRate floatValue]*100;
             int sumBeatRate = [model.SumBeatRate floatValue] *100;
             
             if (applicationCreatedBeatRate == 100) {
                 applicationCreatedBeatRate = 99;
             }
             if (checkingBeatRate == 100){
                 checkingBeatRate = 99;
             }
             if (successCreditBeatRate == 100){
                 successCreditBeatRate = 99;
             }
             if (sumBeatRate == 100){
                 sumBeatRate = 99;
             }
              */
             
             int newCustomer = [@"21" floatValue];
             int applicationCreatedBeatRate = [@"0.7" floatValue]*100;
             int checkingBeatRate = [@"0.1" floatValue]*100;
             int successCreditBeatRate = [@"1" floatValue]*100;
             int sumBeatRate = [@"0.6" floatValue] *100;
             
             if (applicationCreatedBeatRate == 100) {
                 applicationCreatedBeatRate = 99;
             }
             if (checkingBeatRate == 100){
                 checkingBeatRate = 99;
             }
             if (successCreditBeatRate == 100){
                 successCreditBeatRate = 99;
             }
             if (sumBeatRate == 100){
                 sumBeatRate = 99;
             }
             
             cell.rankImgView.hidden = NO;
             
             if (newCustomer > 7*3) {
                  cell.rankImgView.image = [UIImage imageNamed:imgArr[0]];
             }else if (newCustomer > 5*3){
                 cell.rankImgView.image = [UIImage imageNamed:imgArr[1]];
             }else if (newCustomer > 3*3){
                 cell.rankImgView.image = [UIImage imageNamed:imgArr[2]];
             }else if (newCustomer > 3){
                 cell.rankImgView.image = [UIImage imageNamed:imgArr[3]];
             }else{
                 cell.rankImgView.image = [UIImage imageNamed:imgArr[4]];
             }
           
             
             cell.rankLabel.hidden = YES;
             cell.nameLabel.text = @"申请成功";
             cell.allCountLabel.text = @"1000万元";
             cell.numberLabel.text = @"10";
            }
    }
    
        
        
}

- (void)configularCell:(UITableViewCell*)cell andIndexPath:(NSIndexPath*)indexPath{
    
    //设置左边图片右边文字的cell
    [self setLeftImgWithTitleCell:cell andIndexPath:indexPath];
    
    //在cell上设置UIScrollView的cell
    [self setScrollViewWithCell:cell andIndexPath:indexPath];
    
}

- (void)updateImg {
    
    CGFloat yOffset   = _tableViewInfo.contentOffset.y;
    
    if (yOffset < 0) {
        
        CGFloat factor = ((ABS(yOffset)+kSCREENHEIGHT)*ImageWidth)/kSCREENHEIGHT;
        CGRect f = CGRectMake(-(factor-ImageWidth)/2, 0, factor, kSCREENHEIGHT+ABS(yOffset));
        self.imgProfile.frame = f;
    } else {
        CGRect f = self.imgProfile.frame;
        f.origin.y = -yOffset;
        self.imgProfile.frame = f;
    }
}

#pragma mark - getters and setters

- (UITableView *)tableViewInfo{
    
    if (!_tableViewInfo) {
        _tableViewInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kSCREENWIDTH, kSCREENHEIGHT+64) style:UITableViewStyleGrouped];
        _tableViewInfo.dataSource = self;
        _tableViewInfo.delegate = self;
        _tableViewInfo.backgroundColor = [UIColor clearColor];
        _tableViewInfo.separatorColor = [UIColor colorWithWhite:0.8f alpha:0.3f];
        _tableViewInfo.showsVerticalScrollIndicator = NO;
    }
    return _tableViewInfo;
}

#pragma mark- scroll delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableViewInfo == scrollView) {
        [self updateImg];
//        self.headView.offsetY = scrollView.contentOffset.y;
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.tableViewInfo == scrollView) {
//        _headView.touching = NO;
    }
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.tableViewInfo == scrollView) {
        if(decelerate==NO)
        {
//            _headView.touching = NO;
        }
    }
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.tableViewInfo == scrollView) {
//        _headView.touching = YES;
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.cellSectionDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *key = [self.setSections objectAtIndex:section];
    NSArray *set = [self.cellSectionDic objectForKey:key];
    return [set count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (0 == section) {
        return kSECTION_HVH;
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((0 == indexPath.section && 0 == indexPath.row) || (2 == indexPath.section && 1 == indexPath.row)) {
        return kSCROLL_H;
    }else if (3 == indexPath.section){
        
        if (0 == indexPath.row || 1 == indexPath.row) {
            return 44;
        }
        return 60;
    }
    return 44;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    if (0 == section) {
        UIView *sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSECTION_HVH)];
        sectionHeadView.backgroundColor = self.view.backgroundColor;
        UIImage *leftImg = [UIImage imageNamed:@"my_webLogin"];
        CGFloat imgW = leftImg.size.width;
        CGFloat imgH = leftImg.size.height;
        UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kLEFT_MAR, (kSECTION_HVH - imgH)/2, imgW, imgH)];
        leftImgView.image = leftImg;
        [sectionHeadView  addSubview:leftImgView];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(CGRectGetMaxX(leftImgView.frame)+8, (kSECTION_HVH-30)/2, kSCREENWIDTH - (CGRectGetMaxX(leftImgView.frame)+8), 30);
        nameLabel.text = @"网页融誉100管理系统已登录";
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.textColor = [UIColor lightGrayColor];
        nameLabel.font = [UIFont systemFontOfSize:14];
        [sectionHeadView addSubview:nameLabel];
        
        return sectionHeadView;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 10)];
    footView.backgroundColor = self.view.backgroundColor;
    return footView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (3 == indexPath.section &&  0 != indexPath.row) {
        
        DragonTigerCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DragonTigerCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setDragonTigerCell:cell andIndexPath:indexPath];
        
        return cell;
        
    }
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configularCell:cell andIndexPath:indexPath];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *key = [self.setSections objectAtIndex:indexPath.section];
    NSArray *set = [self.cellSectionDic objectForKey:key];
    
    cell.textLabel.text = [set objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - event response

- (void)popClick
{
//    POP;
}

- (void)onBackClick{
    
    
}

- (void)onClickToScan{
    
    
}

@end
