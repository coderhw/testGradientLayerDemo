//
//  VKGradientBarView.m
//  testGradientLayer
//
//  Created by Evan on 2017/3/15.
//  Copyright © 2017年 vanke. All rights reserved.
//

#import "VKGradientBarView.h"

#define degressToRadius(ang) (M_PI*(ang)/180.0f) //把角度转换成PI的方式
#define RYUIColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define XRGB(r,g,b)     [UIColor colorWithRed:(0x##r)/255.0 green:(0x##g)/255.0 blue:(0x##b)/255.0 alpha:1]
#define COLOR_PINK      XRGB(e6, 00, 12)//红色
#define PROGRESS_LINE_WIDTH 4 //弧线的宽度


@interface VKGradientBarView ()

@property (nonatomic, strong) UIBezierPath *gradientPath;
@property (nonatomic, strong) UIBezierPath *linePath;
@property (nonatomic, strong) UIBezierPath *circlePath;

@property (nonatomic, strong) CAShapeLayer *gradientLayer;
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;


@end

@implementation VKGradientBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        [self defaultConfig];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self defaultConfig];
}

- (void)defaultConfig {
    _values = @[@"0", @"0", @"0", @"0", @"0", @"0", @"0"];
}

- (void)drawGraientView {

   
    
    CGFloat lPedding = 13;
    CGFloat dateLabelW = 22;
    CGFloat dateLabelH = 15;
    CGFloat yLabelW = 24;
    CGFloat yLabelH = 15;

    CGFloat viewW = CGRectGetWidth(self.bounds)-lPedding;
    CGFloat ViewH = CGRectGetHeight(self.bounds)-dateLabelH-3;
    
    NSArray *dateStr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周天"];

    CGFloat maxValue = [[_values valueForKeyPath:@"@max.floatValue"] floatValue];
    
    NSMutableArray *pointYvalues = [NSMutableArray array];
    [_values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat pointY =  [_values[idx] floatValue] * (ViewH)/maxValue;
        [pointYvalues addObject:[NSString stringWithFormat:@"%f", pointY]];
        
    }];
    
    
    CGFloat xPadding = viewW/6;
    CGPoint origalPoint = CGPointMake(lPedding, ViewH-dateLabelH);
    
    CGPoint mondayPoint = CGPointMake(lPedding, ViewH-([pointYvalues[0] floatValue]));
    CGPoint tuesdayPoint = CGPointMake(xPadding, ViewH-([pointYvalues[1] floatValue]));
    CGPoint wednesdayPoint = CGPointMake(xPadding*2, ViewH-([pointYvalues[2] floatValue]));
    CGPoint thusdayPoint = CGPointMake(xPadding*3, ViewH-([pointYvalues[3] floatValue]));
    CGPoint fridayPoint = CGPointMake(xPadding*4, ViewH-([pointYvalues[4] floatValue]));
    CGPoint saturdayPoint = CGPointMake(xPadding*5, ViewH-([pointYvalues[5] floatValue]));
    CGPoint sundayPoint = CGPointMake(xPadding*6, ViewH-([pointYvalues[6] floatValue]));
    
    CGPoint endPoint = CGPointMake(xPadding*6, ViewH);
    
    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
    [gradientPath moveToPoint:origalPoint];
    [gradientPath addLineToPoint:mondayPoint];
    [gradientPath addLineToPoint:tuesdayPoint];
    [gradientPath addLineToPoint:wednesdayPoint];
    [gradientPath addLineToPoint:thusdayPoint];
    [gradientPath addLineToPoint:fridayPoint];
    [gradientPath addLineToPoint:saturdayPoint];
    [gradientPath addLineToPoint:sundayPoint];
    [gradientPath addLineToPoint:endPoint];
    gradientPath.lineWidth = 3.0f;
    
    //外部线框
    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    [linePath moveToPoint:mondayPoint];
    [linePath addLineToPoint:tuesdayPoint];
    [linePath addLineToPoint:wednesdayPoint];
    [linePath addLineToPoint:thusdayPoint];
    [linePath addLineToPoint:fridayPoint];
    [linePath addLineToPoint:saturdayPoint];
    [linePath addLineToPoint:sundayPoint];
    linePath.lineWidth = 3.0f;
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 2.0f;
    lineLayer.strokeColor = COLOR_PINK.CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:lineLayer];
    
    CAShapeLayer *markLayer = [CAShapeLayer layer];
    markLayer.path = gradientPath.CGPath;
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, viewW, ViewH);
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[COLOR_PINK CGColor],
                            (__bridge id)[UIColor colorWithWhite:1 alpha:0.1].CGColor, nil];
    gradientLayer.locations=@[@0.0,@1.0];
    gradientLayer.startPoint = CGPointMake(0.0,0.0);
    gradientLayer.endPoint = CGPointMake(0.0,1);
    gradientLayer.mask = markLayer;
    [self.layer addSublayer:gradientLayer];
    
    //画当天圆环
    UIBezierPath *circlePath = [[UIBezierPath alloc] init];
    [circlePath addArcWithCenter:CGPointMake(xPadding*3, ViewH-([pointYvalues[3] floatValue]))
                          radius:5
                      startAngle:0.0 endAngle:180.0 clockwise:YES];
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.path = circlePath.CGPath;
    circleLayer.lineWidth = 2.0f;
    circleLayer.fillColor = [UIColor whiteColor].CGColor;
    circleLayer.strokeColor = COLOR_PINK.CGColor;
    [self.layer addSublayer:circleLayer];
    
    NSArray *points = @[NSStringFromCGPoint(mondayPoint),
                        NSStringFromCGPoint(CGPointMake(tuesdayPoint.x - yLabelW/2, tuesdayPoint.y)),
                        NSStringFromCGPoint(CGPointMake(wednesdayPoint.x - yLabelW/2, wednesdayPoint.y)),
                        NSStringFromCGPoint(CGPointMake(thusdayPoint.x - yLabelW/2, thusdayPoint.y)),
                        NSStringFromCGPoint(CGPointMake(fridayPoint.x - yLabelW/2, fridayPoint.y)),
                        NSStringFromCGPoint(CGPointMake(saturdayPoint.x - yLabelW/2, saturdayPoint.y)),
                        NSStringFromCGPoint(CGPointMake(sundayPoint.x-yLabelW, sundayPoint.y))];

    //画Y值
    for(int i = 0; i < 7; i++) {
        
        CATextLayer *datelayer = [CATextLayer layer];
        datelayer.backgroundColor = [UIColor clearColor].CGColor;
        datelayer.frame = CGRectMake(CGPointFromString(points[i]).x, CGPointFromString(points[i]).y - 16 - 10, yLabelW, yLabelH);
        datelayer.foregroundColor = [UIColor blackColor].CGColor;
        datelayer.alignmentMode = kCAAlignmentCenter;
        datelayer.wrapped = YES;
        UIFont *font = [UIFont systemFontOfSize:11];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef =CGFontCreateWithFontName(fontName);
        datelayer.font = fontRef;
        datelayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        datelayer.contentsScale = [UIScreen mainScreen].scale;
        datelayer.string = _values[i];
        [self.layer addSublayer:datelayer];
    }

    //日期
    NSArray *datePoints = @[NSStringFromCGPoint(mondayPoint),
                        NSStringFromCGPoint(CGPointMake(tuesdayPoint.x-dateLabelW/2, saturdayPoint.y)),
                        NSStringFromCGPoint(CGPointMake(wednesdayPoint.x-dateLabelW/2, saturdayPoint.y)),
                        NSStringFromCGPoint(CGPointMake(thusdayPoint.x-dateLabelW/2, saturdayPoint.y)),
                        NSStringFromCGPoint(CGPointMake(fridayPoint.x-dateLabelW/2, saturdayPoint.y)),
                        NSStringFromCGPoint(CGPointMake(saturdayPoint.x-dateLabelW/2, saturdayPoint.y)),
                        NSStringFromCGPoint(CGPointMake(sundayPoint.x-dateLabelW, sundayPoint.y))];
    
    for(int i = 0; i < 7; i++){
        CATextLayer *datelayer = [CATextLayer layer];
        datelayer.backgroundColor = [UIColor clearColor].CGColor;
        datelayer.frame = CGRectMake(CGPointFromString(datePoints[i]).x, self.bounds.size.height - dateLabelH, dateLabelW, dateLabelH);
        datelayer.foregroundColor = [UIColor blackColor].CGColor;
        datelayer.alignmentMode = kCAAlignmentLeft;
        datelayer.wrapped = YES;
        UIFont *font = [UIFont systemFontOfSize:11];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef =CGFontCreateWithFontName(fontName);
        datelayer.font = fontRef;
        datelayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        datelayer.contentsScale = [UIScreen mainScreen].scale;
        datelayer.string = dateStr[i];
        [self.layer addSublayer:datelayer];
    }
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 4;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue= [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue= [NSNumber numberWithFloat:5.0f];
    pathAnimation.autoreverses = NO;
    [lineLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

- (void)setValues:(NSArray *)values {
    _values = values;

    
    [self drawGraientView];
}
@end
