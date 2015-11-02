//
//  MyScrollView.m
//  FunctionTest
//
//  Created by zzj on 15/10/22.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

#pragma mark - life cycle

#pragma mark - private method

- (void)setViewUI{
    
    [self addSubview:self.myScroll];
    
    NSInteger count = 3;//一行放几个view
    
    CGFloat cenViewW = CGRectGetWidth(self.frame)/count;
    CGFloat cenViewH = CGRectGetHeight(self.frame);
    
    for (int i=0; i<self.myDataArr.count; i++) {
        
        UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(i*cenViewW, 0, cenViewW, cenViewH)];
        centerView.backgroundColor = [UIColor whiteColor];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(centerView.frame)-1, 20)];
        nameLabel.text = self.myDataArr[i];
        nameLabel.textColor = self.myDataColorArr[i];
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [centerView addSubview:nameLabel];
        
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame) + 5, CGRectGetWidth(nameLabel.frame), CGRectGetHeight(centerView.frame)-CGRectGetMaxY(nameLabel.frame) - 25)];
        
        NSString *numstr = [NSString stringWithFormat:@"%d",i];
        numLabel.textColor = self.myColorArr[i];
        numLabel.font = [UIFont systemFontOfSize:40];
        numLabel.attributedText = [Tool textLabelColor:[NSString stringWithFormat:@"%@个",numstr] leftPosition:numstr.length rightPosition:1 color:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:11]];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [centerView addSubview:numLabel];
        
        [self.myScroll addSubview:centerView];
    }
    
    self.myScroll.contentSize = CGSizeMake(self.myDataArr.count*cenViewW, CGRectGetHeight(self.frame));
    
    self.pageControl.numberOfPages = self.myDataArr.count/count;
    [self addSubview:self.pageControl];
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
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-10)/2, CGRectGetHeight(self.frame) - 20, 10, 10)];
        _pageControl.pageIndicatorTintColor = COLOR(225, 225, 225, 1.0f);
        _pageControl.currentPageIndicatorTintColor = COLOR(33, 142, 205, 1.0f);
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
