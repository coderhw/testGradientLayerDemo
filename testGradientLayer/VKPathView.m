//
//  VKPathView.m
//  testGradientLayer
//
//  Created by vanke on 2017/3/31.
//  Copyright © 2017年 vanke. All rights reserved.
//

#import "VKPathView.h"

@implementation VKPathView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self gradentWith:frame];
    }
    return self;
}

- (void)gradentWith:(CGRect)frame{
    
    CGFloat xPadding = self.bounds.size.width/6;

    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
    [gradientPath moveToPoint:CGPointMake(0, CGRectGetMaxY(self.bounds))];
    [gradientPath addLineToPoint:CGPointMake(xPadding, 50)];
    [gradientPath addLineToPoint:CGPointMake(xPadding*2, 100)];
    [gradientPath addLineToPoint:CGPointMake(xPadding*3, 130)];
    [gradientPath addLineToPoint:CGPointMake(xPadding*4, 150)];
    [gradientPath addLineToPoint:CGPointMake(xPadding*5, 100)];
    [gradientPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    gradientPath.lineWidth = 3.0f;

    
    CAShapeLayer *line = [CAShapeLayer layer];
    line.backgroundColor = [UIColor redColor].CGColor;
    line.lineWidth = 4.0f;
    line.path = gradientPath.CGPath;
    line.strokeColor = [UIColor whiteColor].CGColor;
    line.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:line];
    
    
}

@end
