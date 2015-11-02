//
//  MyCustomerScrollView.h
//  FunctionTest
//
//  Created by zzj on 15/10/22.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomerScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *myScroll;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *myDataArr;

@property (nonatomic, strong) NSMutableDictionary *dictMyData;

@end
