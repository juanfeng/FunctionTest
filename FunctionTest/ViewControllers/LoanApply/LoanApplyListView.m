//
//  LoanApplyListView.m
//  FunctionTest
//
//  Created by zzj on 15/9/28.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "LoanApplyListView.h"

@implementation LoanApplyListView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"000000");
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        UIView *containerView = [[[UINib nibWithNibName:@"LoanApplyListView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
}

@end
