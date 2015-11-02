//
//  MyCustomerScrollView.m
//  FunctionTest
//
//  Created by zzj on 15/10/22.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "MyCustomerScrollView.h"

@implementation MyCustomerScrollView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initData];
        [self setBodyUI];
    }
    
    return self;
}

#pragma mark - private method

- (void)setBodyUI{
    
    [self addSubview:self.myScroll];
    
    NSInteger count = 4;//一行放几个view
    
    CGFloat cenViewW = CGRectGetWidth(self.frame)/count;
    CGFloat cenViewH = CGRectGetHeight(self.frame);
    
    for (int i=0; i<self.myDataArr.count; i++) {
        
        UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(i*cenViewW, 0, cenViewW, cenViewH)];
        centerView.backgroundColor = [UIColor whiteColor];
        
        UIImage *headIcon = [UIImage imageNamed:@"newiconDefault"];
        CGFloat cenViewW = headIcon.size.width*2/5;
        CGFloat cenViewH = headIcon.size.height*2/5;
        
        UIImageView *headIconView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(centerView.frame)-cenViewW)/2, 10, cenViewW, cenViewH)];
        [headIconView.layer setMasksToBounds:YES];
        [headIconView.layer setCornerRadius:2];
        headIconView.image = headIcon;
        [centerView addSubview:headIconView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headIconView.frame), CGRectGetWidth(centerView.frame)-1, 25)];
        nameLabel.text = self.myDataArr[i];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [centerView addSubview:nameLabel];
        
        [self.myScroll addSubview:centerView];
    }
    
    self.myScroll.contentSize = CGSizeMake(self.myDataArr.count*cenViewW, CGRectGetHeight(self.frame));
    
    self.pageControl.numberOfPages = self.myDataArr.count/count;
    [self addSubview:self.pageControl];
}

- (void)initData{
    
    self.myDataArr = [[NSMutableArray alloc] initWithObjects:@"李小宝",@"谭成功",@"李自成",@"张五金",@"张希痕",@"李小白",@"晓晓",@"忽如名叫",@"招娣",@"燊瀑布",nil];
    //    self.dictMyData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"5",@"",@"3",@"",@"5",@"3",@"",@"1",@"",@"",@"0",@"", nil];
}

#pragma mark - getters and setters

- (UIScrollView *)myScroll{
    
    if (!_myScroll) {
        _myScroll = [[UIScrollView alloc] initWithFrame:self.frame];
        _myScroll.delegate = self;
        _myScroll.contentOffset = CGPointMake(0, 0);
        _myScroll.backgroundColor = [UIColor colorWithWhite:0.52f alpha:0.4f];
        _myScroll.showsHorizontalScrollIndicator = NO;
        _myScroll.pagingEnabled = YES;
    }
    
    return _myScroll;
}

- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-40)/2, CGRectGetHeight(self.frame) - 20, 40, 20)];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    }
    return _pageControl;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.myScroll == scrollView) {
        self.pageControl.currentPage = scrollView.contentOffset.x/kSCREENWIDTH;
    }
}

#pragma mark - event response

@end
