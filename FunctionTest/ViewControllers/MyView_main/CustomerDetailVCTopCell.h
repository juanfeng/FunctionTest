//
//  CustomerDetailVCTopCell.h
//  FunctionTest
//
//  Created by zzj on 15/10/26.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerDetailVCTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *customerHeadImgView;
@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerPhoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerCarIdLabel;

@end
