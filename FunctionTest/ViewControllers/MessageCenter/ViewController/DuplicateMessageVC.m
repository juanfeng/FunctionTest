//
//  DuplicateMessageVC.m
//  FunctionTest
//
//  Created by zzj on 15/10/16.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "DuplicateMessageVC.h"
#import "MessageMainCell.h"

#define kBTNSELECTBACK_COLOR [UIColor orangeColor]
#define kBTNNORMALBACK_COLOR [UIColor whiteColor]
@interface DuplicateMessageVC ()

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *list;

@property (nonatomic, strong) NSArray *AZList;

@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation DuplicateMessageVC{
    
    CGFloat currentMoveY;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self setBodyUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private method

- (void)initData{
    /*
     @{@"indexTitle": @"A",@"data":@[@"adam", @"alfred", @"ain", @"abdul", @"anastazja", @"angelica"]},
     @{@"indexTitle": @"D",@"data":@[@"dennis" , @"deamon", @"destiny", @"dragon", @"dry", @"debug", @"drums"]},
     @{@"indexTitle": @"F",@"data":@[@"Fredric", @"France", @"friends", @"family", @"fatish", @"funeral"]},
     
     @{@"indexTitle": @"M",@"data":@[@"Mark", @"Madeline"]},
     
     @{@"indexTitle": @"N",@"data":@[@"Nemesis", @"nemo", @"name"]},
     
     @{@"indexTitle": @"O",@"data":@[@"Obama", @"Oprah", @"Omen", @"OMG OMG OMG", @"O-Zone", @"Ontario"]},
     
     @{@"indexTitle": @"Z",@"data":@[@"Zeus", @"Zebra", @"zed"]}
     */
    self.dataSource = @[@{@"indexTitle": @"A",@"data":@[@"adam", @"alfred", @"ain", @"abdul", @"anastazja", @"angelica"]},@{@"indexTitle": @"D",@"data":@[@"dennis" , @"deamon", @"destiny", @"dragon", @"dry", @"debug", @"drums"]},@{@"indexTitle": @"F",@"data":@[@"Fredric", @"France", @"friends", @"family", @"fatish", @"funeral"]},@{@"indexTitle": @"M",@"data":@[@"Mark", @"Madeline"]},@{@"indexTitle": @"N",@"data":@[@"Nemesis", @"nemo", @"name"]},@{@"indexTitle": @"O",@"data":@[@"Obama", @"Oprah", @"Omen", @"OMG OMG OMG", @"O-Zone", @"Ontario"]},@{@"indexTitle": @"Z",@"data":@[@"Zeus", @"Zebra", @"zed"]}];
}

- (void)setBodyUI{
    
    
    [self setHeadView:_headView];
    
    [self.view addSubview:self.tableViewInfo];
    
}

- (void)setHeadView:(UIView *)headView{
    
    if (!_headView) {
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kSCREENWIDTH, 44)];
        _headView.backgroundColor = [UIColor whiteColor];
        NSArray *btnTitleArr = @[@"消息",@"信贷申请"];
        CGFloat btnWidth = kSCREENWIDTH/btnTitleArr.count;
        for (int j = 0; j<btnTitleArr.count; j++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth*j, 0, btnWidth, CGRectGetHeight(_headView.frame)-2)];
            [btn setTitle:btnTitleArr[j] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(onSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 10+j;
            j == 0 ? (btn.backgroundColor = kBTNSELECTBACK_COLOR) : (btn.backgroundColor = kBTNNORMALBACK_COLOR);
            j == 0 ? ([btn setTitleColor:kBTNNORMALBACK_COLOR forState:UIControlStateNormal]) : ([btn setTitleColor:kBTNSELECTBACK_COLOR forState:UIControlStateNormal]);
            [_headView addSubview:btn];
        }
        
        UIView *botLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_headView.frame)-2, CGRectGetWidth(_headView.frame), 2)];
        botLine.backgroundColor = kBTNSELECTBACK_COLOR;
        [_headView addSubview:botLine];
    }
    
    [self.view addSubview:_headView];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource[section][@"data"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.000001;
}

//给tableviewcell添加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSMutableArray * indexTitles = [NSMutableArray array];
    for (NSDictionary * sectionDictionary in self.dataSource) {
        [indexTitles addObject:sectionDictionary[@"indexTitle"]];
    }
    return indexTitles;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageMainCell *cell = [[NSBundle mainBundle] loadNibNamed:@"MessageMainCell" owner:self options:nil][0];
    cell.nameLabel.text = self.dataSource[indexPath.section][@"data"][indexPath.row];
    
    
    //    NSString *showText = [self.list objectAtIndex:section];
    //    cell.botTipLabel.text = [NSString stringWithFormat:@"数据在%@这个分组中",showText];
    return cell;
}

#pragma mark - event response

#pragma mark 头部点击按钮事件

- (void)onSelectClick:(UIButton*)sender{
    
    sender.backgroundColor = kBTNSELECTBACK_COLOR;
    [sender setTitleColor:kBTNNORMALBACK_COLOR forState:UIControlStateNormal];
    for (UIView *view in self.headView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)view;
            if (btn != sender) {
                btn.backgroundColor = kBTNNORMALBACK_COLOR;
                [btn setTitleColor:kBTNSELECTBACK_COLOR forState:UIControlStateNormal];
            }
        }
    }
    
    switch (sender.tag) {
        case 10://消息
            
            
            break;
        case 11://信贷申请
            
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
        _lineView.backgroundColor = [UIColor blueColor];
    }
    
    return _lineView;
}

- (NSArray *)AZList{
    
    if (!_AZList) {
        NSMutableArray *mutableArr = [[NSMutableArray alloc] init];
        char a[26];
        for (int i = 'A'; i<= 'Z'; i++) {
            a[i-'A'] = i;
            [mutableArr addObject:[NSString stringWithFormat:@"%c",a[i-'A']]];
        }
        _AZList = [mutableArr copy];
    }
    
    return _AZList;
}

@end
