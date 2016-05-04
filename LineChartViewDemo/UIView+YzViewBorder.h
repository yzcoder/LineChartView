//
//  UIView+YzViewBorder.h
//  LineChartViewDemo
//
//  Created by Yz on 16/5/3.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YzViewBorder)
/**
 *  设置view边框效果
 *
 *  @param color 边框颜色
 *  @param width 边框宽度
 */
- (void)borderStyleWithColor:(UIColor *)color width:(CGFloat)width;
/**
 *  设置view圆角
 *
 *  @param value 角度
 */
- (void)cornerRadiusStyleWithValue:(CGFloat)value;
/**
 *  设置圆角，默认宽度一半
 */
- (void)roundWidthStyle;
@end
