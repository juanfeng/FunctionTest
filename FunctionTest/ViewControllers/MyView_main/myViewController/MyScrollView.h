//
//  MyScrollView.h
//  FunctionTest
//
//  Created by zzj on 15/10/22.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *myScroll;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *myDataArr;

@property (nonatomic, strong) NSMutableArray *myDataColorArr;

@property (nonatomic, strong) NSMutableArray *myColorArr;

@property (nonatomic, strong) NSMutableDictionary *dictMyData;

- (void)initData;

- (void)setViewUI;

@end
