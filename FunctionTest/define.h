//
//  define.h
//  FunctionTest
//
//  Created by zzj on 15/9/14.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#ifndef FunctionTest_define_h
#define FunctionTest_define_h

#define kSCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define kSCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

//autoLayout 布局宏
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

//API接口
#define api_domain @"http://192.168.253.33:82/"
#define api_login_on api_domain@"API/User/OnLogon"

#define kWHOLE_COLOR [UIColor colorWithRed:24/255.0f green:143/255.0f blue:202/255.0f alpha:1.0f]
#define kBACK_COLOR [UIColor colorWithRed:240/255.0f green:243/255.0f blue:245/255.0f alpha:1.0f]

#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//适配屏幕高度比率
#define kRateH(th) ([th floatValue]/480*kSCREENHEIGHT)
//适配屏幕宽度比率
#define kRateW(tw) ([tw floatValue]/320*kSCREENWIDTH)

#endif