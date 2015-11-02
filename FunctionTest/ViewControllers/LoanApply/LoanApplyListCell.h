//
//  LoanApplyListCell.h
//  FunctionTest
//
//  Created by zzj on 15/9/28.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanApplyListView.h"

@interface LoanApplyListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

@property (weak, nonatomic) IBOutlet UIView *oneLineView;

@property (weak, nonatomic) IBOutlet UIView *twoLineView;

@property (weak, nonatomic) IBOutlet UIImageView *indicateIconImageView;
@property (weak, nonatomic) IBOutlet LoanApplyListView *applyListView1;
@property (weak, nonatomic) IBOutlet LoanApplyListView *applyListView2;
@property (weak, nonatomic) IBOutlet LoanApplyListView *applyListView3;

- (LoanApplyListCell*)configularCell:(LoanApplyListCell*)listCell andRowWithIndexPath:(NSIndexPath*)indexpath;

@end
