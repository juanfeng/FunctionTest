//
//  MymainHeadView.m
//  FunctionTest
//
//  Created by zzj on 15/10/30.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "MyHeadView.h"

@implementation MyHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.headIconView];
        [self addSubview:self.chartsBtn];
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLabel];
    }
    
    return self;
}

- (UIImageView *)headIconView{
    
    if (!_headIconView) {
        UIImage *icon = [UIImage imageNamed:@"my_headIcon"];
        CGFloat iconW = icon.size.width;
        CGFloat iconH = icon.size.height;
        _headIconView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-iconW)/2, 150, iconW, iconH)];
        _headIconView.image = icon;
    }
    
    return _headIconView;
}

- (UIButton *)chartsBtn{
    
    if (!_chartsBtn) {
        UIImage *charIcon = [UIImage imageNamed:@"my_charts"];
        CGFloat charIconW = charIcon.size.width;
        CGFloat charIconH = charIcon.size.height;
        _chartsBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headIconView.frame)-15, CGRectGetMinY(self.headIconView.frame)+5, charIconW, charIconH)];
        [_chartsBtn setBackgroundImage:charIcon forState:UIControlStateNormal];
        [_chartsBtn setTitle:@"四级牛" forState:UIControlStateNormal];
        [_chartsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_chartsBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _chartsBtn;
}

- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headIconView.frame)+10, kSCREENWIDTH, 40)];
        _nameLabel.text = [NSString stringWithFormat:@"您好，%@",@"陈逸飞"];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont boldSystemFontOfSize:25];
    }
    
    return _nameLabel;
}

- (UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame), kSCREENWIDTH, 20)];
        _phoneLabel.text = [NSString stringWithFormat:@"18844446666"];
        _phoneLabel.textColor = [UIColor whiteColor];
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.font = [UIFont systemFontOfSize:13];
    }
    
    return _phoneLabel;
    
}

@end
