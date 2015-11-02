//
//  Tool.m
//  FunctionTest
//
//  Created by zzj on 15/9/16.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "Tool.h"

@implementation Tool

//根据颜色创建一个图片
+ (UIImage *)createImageWithColor:(UIColor *)color rect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//加载Loading动画
+ (void)showHudLoadingWithString:(NSString*)showStr andStatus:(MMProgressHUDPresentationStyle)animationStyle{
    
    [MMProgressHUD setPresentationStyle:animationStyle];
    [MMProgressHUD showWithTitle:showStr status:nil];
//    NSTimeInterval delayTimer = 15;
//    [MMProgressHUD dismissAfterDelay:delayTimer];
    
}
//加载成功动画
+ (void)showHudSuccessedWithDelay:(NSTimeInterval)delayTimer{
    
    [MMProgressHUD dismissWithSuccess:nil title:@"加载成功" afterDelay:delayTimer];
    
}
//加载失败动画
+ (void)showHudErrorWithDelay:(NSTimeInterval)delayTimer{
    
    [MMProgressHUD dismissWithError:nil title:@"加载失败" afterDelay:delayTimer];
}

//判断有无网络
+ (BOOL)IsNoNetworkConnection{
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    }else{
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

+ (void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)message anddelegate:(id)targetDelegate andcancelButtonTitle:(NSString*)cancelBtnTitle otherButtonTitles:(NSString*)otherBtnTitle{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:targetDelegate cancelButtonTitle:cancelBtnTitle otherButtonTitles:otherBtnTitle, nil];
    alertView.delegate = targetDelegate;
    [alertView show];
}

//设置cookies
+ (void)setCookies{
    
    [Tool clearCookies];
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"sessionCookies"]) {
        
        NSMutableArray *arcCookies = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"sessionCookies"]];
        NSMutableSet *setOriginalSet = [[NSMutableSet alloc] initWithArray:arcCookies];
        NSMutableSet *setNextSet = [[NSMutableSet alloc] initWithArray:cookies];
        [setOriginalSet unionSet:setNextSet];
        
        NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:setOriginalSet.allObjects];
        [defaults setObject:cookiesData forKey:@"sessionCookies"];
        [defaults synchronize];
        
    }else{
        
        NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
        [defaults setObject:cookiesData forKey:@"sessionCookies"];
        [defaults synchronize];
    }
    
}

//清除cookies
+ (void)clearCookies{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"sessionCookies"];
    [defaults synchronize];
    
}

//给号码添加“－”
+ (NSString*)alterPhoneStr:(NSString*)phoneStr{
    
    NSString *alterPhoneStr = nil;
    if (phoneStr.length == 10) {
        
        alterPhoneStr = [NSString stringWithFormat:@"%@-%@-%@",[phoneStr substringWithRange:NSMakeRange(0, 4)],[phoneStr substringWithRange:NSMakeRange(4, 3)],[phoneStr substringWithRange:NSMakeRange(7, 3)]];
        
        return alterPhoneStr;
        
    }else if (phoneStr.length == 11){
        
        alterPhoneStr = [NSString stringWithFormat:@"%@-%@-%@",[phoneStr substringWithRange:NSMakeRange(0, 3)],[phoneStr substringWithRange:NSMakeRange(3, 4)],[phoneStr substringWithRange:NSMakeRange(7, 4)]];
        
        return alterPhoneStr;
        
    }else{
        
        alterPhoneStr = phoneStr;
        return phoneStr;
    }
    
    return alterPhoneStr;
    
}

//对文本文字截断的方法
+(NSString *)interceptingWithString:(NSString *)labelStr{
    
    if([labelStr length]>9){
        
        NSString *str=[labelStr substringToIndex:4];
        NSRange range=NSMakeRange([labelStr length]-4, 4);
        NSString *str1=[labelStr substringWithRange:range];
        NSString *text=[NSString stringWithFormat:@"%@...%@",str,str1];
        return text;
    }
    return labelStr;
}

//时间处理
+ (NSString*)dealWithTime:(NSString*)dealTime{
    
    NSString *afterTime = @"";
    NSString *timeStr = dealTime;
    NSArray *timeStrs = [timeStr componentsSeparatedByString:@"T"];
    if (timeStrs.count>0) {
        afterTime = timeStrs[0];
    }else{
        afterTime = dealTime;
    }
    return afterTime;
}

+ (NSMutableAttributedString*)textLabelColor:(NSString*)str leftPosition:(NSInteger)leftPos rightPosition:(NSInteger)rightPos color:(UIColor*)color font:(UIFont*)font
{
    
    NSMutableAttributedString *labelStr= [[NSMutableAttributedString alloc] initWithString:str];
    [labelStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(leftPos,rightPos)];
    [labelStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(leftPos, rightPos)];
    return labelStr;
}

@end
