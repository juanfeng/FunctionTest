//
//  Tool.h
//  FunctionTest
//
//  Created by zzj on 15/9/16.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

//根据颜色创建一个图片
+ (UIImage *)createImageWithColor:(UIColor *)color rect:(CGRect)rect;

//加载Loading动画
+ (void)showHudLoadingWithString:(NSString*)showStr andStatus:(MMProgressHUDPresentationStyle)animationStyle;
//加载成功动画
+ (void)showHudSuccessedWithDelay:(NSTimeInterval)delayTimer;
//加载失败动画
+ (void)showHudErrorWithDelay:(NSTimeInterval)delayTimer;

//判断有无网络
+ (BOOL)IsNoNetworkConnection;

//alertView
+ (void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)message anddelegate:(id)targetDelegate andcancelButtonTitle:(NSString*)cancelBtnTitle otherButtonTitles:(NSString*)otherBtnTitle;

//设置cookies
+ (void)setCookies;
//清除cookies
+ (void)clearCookies;

//给号码添加“－”
+ (NSString*)alterPhoneStr:(NSString*)phoneStr;

//对文本文字截断的方法
+ (NSString *)interceptingWithString:(NSString *)labelStr;

//时间处理
+ (NSString*)dealWithTime:(NSString*)dealTime;

//设置两段文字大小颜色
+ (NSMutableAttributedString*)textLabelColor:(NSString*)str leftPosition:(NSInteger)leftPos rightPosition:(NSInteger)rightPos color:(UIColor*)color font:(UIFont*)font;

@end
