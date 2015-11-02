//
//  LDProgressView.m
//  LDProgressView
//
//  Created by Christian Di Lorenzo on 9/27/13.
//  Copyright (c) 2013 Light Design. All rights reserved.
//


//事例
/*
 PKProgressView *pkprogressView = [[PKProgressView alloc] initWithFrame:CGRectMake(100, 200, 120, 40)];
 
 pkprogressView.pkpProgress = 1.0f;//用于判断类型
 
 [self.view addSubview:[pkprogressView returnPKPViewType:pkprogressView]];
 */

#import "PKProgressView.h"

@interface PKProgressView ()
@property (nonatomic) CGFloat offset;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) CGFloat stripeWidth;
@property (nonatomic, strong) UIImage *gradientProgress;
@property (nonatomic) CGSize stripeSize;

@property (nonatomic, strong) NSString *progressTextOverride;
@property (nonatomic, strong) UIColor *progressTextColorOverride;

// Animation of progress
@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic) CGFloat progressToAnimateTo;

@end

@implementation PKProgressView
@synthesize animate=_animate, color=_color;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor clearColor];
    self.textAlignment = NSTextAlignmentRight;
    
    //初始化数据
    self.pkpProgress = 0.0;
    self.type = LDProgressSolid;
    self.showText = @YES;
    self.borderRadius = @3;
    self.labelStrColor = [UIColor whiteColor];
    self.animate = @NO;
    self.color = [UIColor colorWithRed:107/255.0f green:203/255.0f blue:146/255.0f alpha:1.0f];
}

- (PKProgressView*)returnPKPViewType:(PKProgressView*)progressView{
    
//    progressView.frame = CGRectMake(0, 0, 120, 40);
    
    //根据进度决定类型
    if (self.pkpProgress == 0.0) {//未获取
        
        progressView.pkpViewType = PKPViewTypeNotacquired;
        
    }else if (self.pkpProgress >= 1.0){//已获取
        
        progressView.pkpViewType = PKPViewTypeAcquired;
        
    }else{
        
        progressView.pkpViewType = PKPViewTypeProgressing;
        
    }
    
    switch (progressView.pkpViewType) {
        case PKPViewTypeNotacquired://未获取
        {
            progressView.labelStr = @"未获取";
            progressView.labelStrColor = progressView.color;
            progressView.progress = self.pkpProgress;
            progressView.background = [UIColor whiteColor];
            progressView.color = [UIColor lightGrayColor];
            progressView.pkImageName = @"pkStar2";
        }
            break;
        case PKPViewTypeProgressing://进行时
        {
            progressView.labelStr = @"获取中";
            progressView.animate = @YES;
            progressView.progress = self.pkpProgress;
            progressView.pkImageName = @"pkStar1";
            
        }
            break;
        case PKPViewTypeAcquired://已获取
        {
            progressView.labelStr = @"已获取";
            progressView.progress = self.pkpProgress;
            progressView.color = progressView.color;
            progressView.pkImageName = @"pkStar3";
            
        }
            break;
            
        default:
            break;
    }
    
    progressView.layer.borderColor = progressView.labelStrColor.CGColor;
    progressView.layer.borderWidth = 2.0f;
    [progressView.layer setMasksToBounds:YES];
    [progressView.layer setCornerRadius:5];
    
    return progressView;
}

- (void)setAnimate:(NSNumber *)animate {
    _animate = animate;
    if ([animate boolValue]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(incrementOffset) userInfo:nil repeats:YES];
    } else if (self.timer) {
        [self.timer invalidate];
    }
}


- (void)setProgress:(CGFloat)progress {
    self.progressToAnimateTo = progress;
    if ([self.animate boolValue]) {
        if (self.animationTimer) {
            [self.animationTimer invalidate];
        }
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.008 target:self selector:@selector(incrementAnimatingProgress) userInfo:nil repeats:YES];
    } else {
        _progress = progress;
        [self setNeedsDisplay];
    }
}

- (void)incrementAnimatingProgress {
    if (_progress >= self.progressToAnimateTo-0.005 && _progress <= self.progressToAnimateTo+0.005) {
        _progress = self.progressToAnimateTo;
        [self.animationTimer invalidate];
        [self setNeedsDisplay];
    } else {
        _progress = (_progress < self.progressToAnimateTo) ? _progress + 0.005 : _progress - 0.005;
        [self setNeedsDisplay];
    }
}

- (void)incrementOffset {
    
    if (self.offset <= -self.stripeWidth) {
        self.offset = 0;
    } else {
        self.offset -= 1;
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if ([self.showBackground boolValue]) {
        [self drawProgressBackground:context inRect:rect];
    }
    
    if (self.outerStrokeWidth) {
        [self drawOuterStroke:context inRect:rect];
    }
    
//    if (self.progress > 0) {
        float inset = self.progressInset.floatValue;
        [self drawProgress:context withFrame:self.progressInset ? CGRectInset(rect, inset, inset) : rect];
//    }
}

- (void)drawProgressBackground:(CGContextRef)context inRect:(CGRect)rect {
    CGContextSaveGState(context);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.borderRadius.floatValue];
    CGContextSetFillColorWithColor(context, self.background.CGColor);
    [roundedRect fill];
    
    UIBezierPath *roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect:CGRectMake(-10, -10, rect.size.width+10, rect.size.height+10)];
    [roundedRectangleNegativePath appendPath:roundedRect];
    roundedRectangleNegativePath.usesEvenOddFillRule = YES;

    [roundedRect addClip];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(rect.size.width), 0);
    [roundedRectangleNegativePath applyTransform:transform];
    [[UIColor grayColor] setFill];
    [roundedRectangleNegativePath fill];
    CGContextRestoreGState(context);

    [roundedRect addClip];
}

- (void)drawOuterStroke:(CGContextRef)context inRect:(CGRect)rect {
    float outerStrokeWidth = self.outerStrokeWidth.floatValue;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, outerStrokeWidth / 2, outerStrokeWidth / 2) cornerRadius:self.borderRadius.floatValue];
    [self.color setStroke];
    bezierPath.lineWidth = outerStrokeWidth;
    [bezierPath stroke];
}

- (void)drawProgress:(CGContextRef)context withFrame:(CGRect)frame {
    CGRect rectToDrawIn = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width * self.progress, frame.size.height);
    CGRect insetRect = CGRectInset(rectToDrawIn, self.progress > 0.01 ? 0.5 : -0.5, 0.5);
    
    insetRect = rectToDrawIn;
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:insetRect cornerRadius:0];
    if ([self.flat boolValue]) {
        CGContextSetFillColorWithColor(context, self.color.CGColor);
        [roundedRect fill];
    } else {
        CGContextSaveGState(context);
        [roundedRect addClip];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGFloat locations[] = {0.0, 1.0};
        NSArray *colors = @[(__bridge id)self.color.CGColor];
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
        
        CGContextDrawLinearGradient(context, gradient, CGPointMake(insetRect.size.width / 2, 0), CGPointMake(insetRect.size.width / 2, insetRect.size.height), 0);
        CGContextRestoreGState(context);
        
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorSpace);
    }
    
        [self drawLabelInRect:insetRect];
}

- (void)drawGradients:(CGContextRef)context inRect:(CGRect)rect {
    
    self.stripeSize = CGSizeMake(self.stripeWidth, rect.size.height);
    CGContextSaveGState(context);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.borderRadius.floatValue] addClip];
    CGFloat xStart = self.offset;
    while (xStart < rect.size.width) {
        [self.gradientProgress drawAtPoint:CGPointMake(xStart, 0)];
        xStart += self.stripeWidth;
    }
    CGContextRestoreGState(context);
}

- (void)drawStripes:(CGContextRef)context inRect:(CGRect)rect {
    CGContextSaveGState(context);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.borderRadius.floatValue] addClip];
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] colorWithAlphaComponent:0.2].CGColor);
    CGFloat xStart = self.offset, height = rect.size.height, width = self.stripeWidth, y = rect.origin.y;
    while (xStart < rect.size.width) {
        CGContextSaveGState(context);
        CGContextMoveToPoint(context, xStart, height + y);
        CGContextAddLineToPoint(context, xStart + width * 0.25, 0);
        CGContextAddLineToPoint(context, xStart + width * 0.75, 0);
        CGContextAddLineToPoint(context, xStart + width * 0.50, height + y);
        CGContextClosePath(context);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
        xStart += width;
    }
    CGContextRestoreGState(context);
}

- (void)drawLabelInRect:(CGRect)rect {
    
    UIImage *logImg = [UIImage imageNamed:self.pkImageName];
    
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label .backgroundColor = [UIColor clearColor];
    label.text = self.labelStr;
    
    CGFloat logH = 25;
    CGFloat logW = logImg.size.width/logImg.size.height*logH;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (CGRectGetHeight(self.frame) - logH)/2 , logW, logH)];
    imgView.image = logImg;
    [self addSubview:imgView];
    
    label .font = [UIFont boldSystemFontOfSize:19];
    label .textColor = self.labelStrColor;
    
    CGFloat width = [label.text sizeWithAttributes:@{NSFontAttributeName: label .font}].width;
    label.textAlignment = NSTextAlignmentLeft;
    [label  drawTextInRect:CGRectMake(CGRectGetMaxX(imgView.frame)+7, rect.origin.y, width, rect.size.height)];
}

#pragma mark - Accessors

- (UIImage *)gradientProgress {
    return _gradientProgress;
}

- (NSNumber *)animate {
    if (_animate == nil) {
        return @YES;
    }
    return _animate;
}

- (NSNumber *)showText {
    if (_showText == nil) {
        return @YES;
    }
    return _showText;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.gradientProgress = nil;
}

- (UIColor *)color {
    if (!_color) {
        return [UIColor colorWithRed:0.07 green:0.56 blue:1.0 alpha:1.0];
    }
    return _color;
}

- (CGFloat)stripeWidth {
    switch (self.type) {
        case LDProgressGradient:
            _stripeWidth = 15;
            break;
        default:
            _stripeWidth = 50;
            break;
    }
    return _stripeWidth;
}

- (NSNumber *)borderRadius {
    if (!_borderRadius) {
        return @(self.frame.size.height / 2.0);
    }
    return _borderRadius;
}

- (UIColor *)background {
    if (!_background) {
        return [UIColor colorWithRed:201/255.0f green:201/255.0f blue:201/255.0f alpha:1.00f];
    }
    return _background;
}

- (NSNumber *)showStroke {
    if (!_showStroke) {
        return @YES;
    }
    return _showStroke;
}

- (NSNumber *)showBackground {
    if (!_showBackground) {
        return @YES;
    }
    return _showBackground;
}

- (NSNumber *)showBackgroundInnerShadow {
    if (!_showBackgroundInnerShadow) {
        return @YES;
    }
    return _showBackgroundInnerShadow;
}

- (void)overrideProgressText:(NSString *)progressText {
    self.progressTextOverride = progressText;
    [self setNeedsDisplay];
}

- (void)overrideProgressTextColor:(UIColor *)progressTextColor {
    self.progressTextColorOverride = progressTextColor;
    [self setNeedsDisplay];
}



@end
