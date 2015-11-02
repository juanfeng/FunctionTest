//
//  RYProfessionalKnowledgecellSeekVC.h
//  FunctionTest
//
//  Created by zzj on 15/9/16.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYProfessionalKnowledgecellSeekVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewInfo;
@property (nonatomic, strong) UILabel *leftNameLabel;
@property (nonatomic, strong) UITextField *rightNameTF;


@end
