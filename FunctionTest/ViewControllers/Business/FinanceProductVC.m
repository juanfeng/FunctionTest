//
//  FinanceProductVC.m
//  FunctionTest
//
//  Created by zzj on 15/9/22.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "FinanceProductVC.h"
#import "FinanceProductCell.h"

@interface FinanceProductVC ()

@end

@implementation FinanceProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setBodyUI];
}

- (void)setBodyUI{
    
    [self requestData];
    [self.view addSubview:self.tableViewInfo];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.tableViewInfo addGestureRecognizer:tapGesture];
    [tapGesture addTarget:self action:@selector(onTapTouch)];
}

- (void)onTapTouch{
    
    [self.view endEditing:YES];
    
}

//请求数据
- (void)requestData{
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://192.168.253.33:82/api_v2/downloadMaterial/GetMaterials?MaterialType=2" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"请求数据成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求数据失败");
        
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FinanceProductCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"FinanceProductCell" owner:self options:nil] lastObject];
    cell.bigTitleLabel.text = @"恐怖主义分子";
    if (indexPath == 0) {
        
         cell.downLoadBtn.enabled = YES;
        
    }else{
        
         cell.downLoadBtn.enabled = NO;
    }
    [cell.downLoadBtn addTarget:self action:@selector(onClickDownLoadFile) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;
}

- (void)onClickDownLoadFile{
    
    NSLog(@"可以下载!");
    
}

- (UITableView *)tableViewInfo{
    
    if (!_tableViewInfo) {
        _tableViewInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableViewInfo.dataSource = self;
        _tableViewInfo.delegate = self;
    }
    
    return _tableViewInfo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
