//
//  LoanApplyListCell.m
//  FunctionTest
//
//  Created by zzj on 15/9/28.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "LoanApplyListCell.h"

@interface LoanApplyListCell ()

- (id)getClassObjectFromNib:(Class)class;

@end

@implementation LoanApplyListCell

- (void)awakeFromNib {
    // Initialization code
}

- (LoanApplyListView *)applyListView1{
    
    if (_applyListView1 == nil) {
        
        _applyListView1 = [self getClassObjectFromNib:[LoanApplyListView class]];
    }
    
    return _applyListView1;
}

- (LoanApplyListView *)applyListView2{
    
    if (_applyListView2 == nil) {
        
        _applyListView2 = [self getClassObjectFromNib:[LoanApplyListView class]];
    }
    
    return _applyListView2;
}


- (LoanApplyListView *)applyListView3{
    
    if (_applyListView3 == nil) {
        
        _applyListView3 = [self getClassObjectFromNib:[LoanApplyListView class]];
        
    }
    
    return _applyListView3;
}

- (id)getClassObjectFromNib:(Class)class{
    
    NSString *nibName = NSStringFromClass(class);
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    for (id anObject in topLevelObjects) {
        if ([anObject isKindOfClass:class]) {
            return anObject;
        }
    }
    
    return nil;
}

- (LoanApplyListCell*)configularCell:(LoanApplyListCell*)listCell andRowWithIndexPath:(NSIndexPath*)indexpath{
    
    listCell.leftIconImageView.image = [UIImage imageNamed:@"ic_product_type_0"];
    listCell.rightNameLabel.text = @"网商贷_个体工商户借款网商贷_个体工商户借款";
    listCell.lineLabel.alpha = 0.15;
    listCell.oneLineView.alpha = 0.15;
    listCell.twoLineView.alpha = 0.15;
    listCell.indicateIconImageView.image = [UIImage imageNamed:@"notcompleteImg"];
    
    listCell.applyListView1.leftIcon.image = [UIImage imageNamed:@"apply_a1"];
    listCell.applyListView1.rightNameLabel.text = @"申请时间";
    listCell.applyListView1.bottomTitleLabel.textColor = [UIColor colorWithRed:52/255.0f green:193/255.0f blue:225/255.0f alpha:1.0f];
    listCell.applyListView1.bottomTitleLabel.text = @"2014-6-11";
    
    listCell.applyListView2.leftIcon.image = [UIImage imageNamed:@"apply_a2"];
    listCell.applyListView2.rightNameLabel.text = @"申请金额";
    listCell.applyListView2.bottomTitleLabel.textColor = [UIColor colorWithRed:252/255.0f green:58/255.0f blue:0.0f alpha:1.0f];
    listCell.applyListView2.bottomTitleLabel.text = @"100,000,000";
    
    listCell.applyListView3.leftIcon.image = [UIImage imageNamed:@"apply_a3"];
    listCell.applyListView3.rightNameLabel.text = @"申请期数";
    listCell.applyListView3.bottomTitleLabel.textColor = [UIColor colorWithRed:250/255.0f green:192/255.0f blue:80/255.0f alpha:1.0f];
    listCell.applyListView3.bottomTitleLabel.text = @"24";
    
    return listCell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
