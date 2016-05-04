//
//  UIView+YzViewBorder.m
//  LineChartViewDemo
//
//  Created by Yz on 16/5/3.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "UIView+YzViewBorder.h"

@implementation UIView (YzViewBorder)


- (void)borderStyleWithColor:(UIColor *)color width:(CGFloat)width {
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.masksToBounds = YES;
}

- (void)cornerRadiusStyleWithValue:(CGFloat)value {
    self.layer.cornerRadius = value;
    self.layer.masksToBounds = YES;
}

- (void)roundWidthStyle {
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
}


@end
