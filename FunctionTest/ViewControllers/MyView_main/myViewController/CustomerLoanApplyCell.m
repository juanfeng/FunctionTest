//
//  CustomerLoanApplyCell.m
//  FunctionTest
//
//  Created by zzj on 15/10/29.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "CustomerLoanApplyCell.h"

@implementation CustomerLoanApplyCell

#pragma mark - life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self configularCell:reuseIdentifier];
    }
    
    return self;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark - private method
- (void)configularCell:(NSString *)reuseIdentifier{
    
    
    self.iconLabel.left       = self.leftLineView.right+10;
    self.iconLabel.top        = 15;
    self.customerLabel.left   = self.iconLabel.right+8;
    self.customerLabel.top    = self.iconLabel.top;
    self.companyLabel.left    = self.customerLabel.left;
    self.companyLabel.top     = self.customerLabel.bottom;
    self.createTimeLabel.left = self.companyLabel.left;
    self.createTimeLabel.top  = self.companyLabel.bottom;
    self.appgressLabel.left   = self.createTimeLabel.left;
    self.appgressLabel.top    = self.createTimeLabel.bottom;
    
    [self.contentView addSubview:self.leftLineView];
    [self.contentView addSubview:self.iconLabel];
    [self.contentView addSubview:self.customerLabel];
    [self.contentView addSubview:self.companyLabel];
    [self.contentView addSubview:self.createTimeLabel];
    [self.contentView addSubview:self.appgressLabel];
    
}

#pragma mark - getters and setters

- (UIView *)leftLineView{
    
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, CGRectGetHeight(self.contentView.frame))];
        _leftLineView.backgroundColor = [UIColor orangeColor];
    }
    
    return _leftLineView;
    
}

- (UILabel *)iconLabel{
    
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        _iconLabel.text = @"消";
        _iconLabel.font = [UIFont systemFontOfSize:13];
        _iconLabel.textColor = [UIColor whiteColor];
        _iconLabel.backgroundColor = [UIColor orangeColor];
    }
    
    return _iconLabel;
}

- (UILabel *)customerLabel{
    
    if (!_customerLabel) {
        _customerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 295, 30)];
        _customerLabel.textColor = [UIColor blackColor];
        _customerLabel.font = [UIFont systemFontOfSize:15];
        _customerLabel.textAlignment = NSTextAlignmentLeft;
        _customerLabel.text = @"张三/个体工商户点融网/30万[已授权]";
    }
    return _customerLabel;
}

- (UILabel *)companyLabel{
    
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _companyLabel.textAlignment = NSTextAlignmentLeft;
        _companyLabel.textColor = [UIColor lightGrayColor];
        _companyLabel.font = [UIFont systemFontOfSize:12];
        _companyLabel.text = @"上海金得电子商务有限公司";
    }
    return _companyLabel;
}

- (UILabel *)appgressLabel{
    
    NSString *perStr = @"申请进度:已作废";
    if (!_appgressLabel) {
        _appgressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _appgressLabel.textAlignment = NSTextAlignmentLeft;
        _appgressLabel.font =[UIFont systemFontOfSize:12];
        _appgressLabel.textColor = [UIColor lightGrayColor];
        _appgressLabel.attributedText = [Tool textLabelColor:perStr leftPosition:5 rightPosition:perStr.length-5 color:[UIColor blueColor] font:_appgressLabel.font];
    }
    
    return _appgressLabel;
}

@end
