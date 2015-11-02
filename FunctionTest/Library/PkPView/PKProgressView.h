//
//  LDProgressView.h
//  LDProgressView
//
//  Created by Christian Di Lorenzo on 9/27/13.
//  Copyright (c) 2013 Light Design. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PKPViewTypeNotacquired,//未获取
    PKPViewTypeProgressing,//进行时
    PKPViewTypeAcquired//已获取
}PKPViewType;

typedef enum {
    LDProgressStripes,
    LDProgressGradient,
    LDProgressSolid
} LDProgressType;

@interface PKProgressView : UIView

@property (nonatomic, assign) CGFloat pkpProgress;

@property (nonatomic, assign) PKPViewType pkpViewType;

@property (nonatomic, strong) NSString *labelStr;
@property (nonatomic, strong)UIColor *labelStrColor;
@property (nonatomic, strong) NSString *pkImageName;

@property (nonatomic) CGFloat progress;
@property (nonatomic) CGFloat labelProgress;

@property (nonatomic, strong) UIColor *color UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *background UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) NSNumber *flat UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *animate UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *showStroke UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *showText UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *showBackground UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *showBackgroundInnerShadow UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) NSNumber *outerStrokeWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *progressInset UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *borderRadius UI_APPEARANCE_SELECTOR;

@property (nonatomic) NSTextAlignment textAlignment;
@property (nonatomic) LDProgressType type;

- (void)overrideProgressText:(NSString *)progressText;
- (void)overrideProgressTextColor:(UIColor *)progressTextColor;

- (PKProgressView*)returnPKPViewType:(PKProgressView*)progressView;

@end
