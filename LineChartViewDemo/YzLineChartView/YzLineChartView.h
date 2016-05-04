//
//  ViewController.h
//  LineChartViewDemo
//
//  Created by Yz on 16/5/3.
//  Copyright © 2016年 Yuz. All rights reserved.
//


#import <UIKit/UIKit.h>


#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define kColorWithRGB(r, g, b, alp) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:alp]
#define chartMargin              10
#define xLabelMargin             15
#define yLabelMargin             15
#define kLabelHeight             10
#define YCoordinateWidth         SCREEN_WIDTH/(self.xCoordinateArray.count + 1)
#define MinMaxMarkLabelwidth     80

//范围
struct Range {
    CGFloat max;
    CGFloat min;
};
typedef struct Range CGRange;
CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min);

CG_INLINE CGRange
CGRangeMake(CGFloat max, CGFloat min){
    CGRange p;
    p.max = max;
    p.min = min;
    return p;
}

static const CGRange CGRangeZero = {0,0};

@interface YzLineChartView : UIView
/**< x坐标数组*/
@property (strong, nonatomic) NSArray *xCoordinateArray;
/**< y坐标数组*/
@property (strong, nonatomic) NSArray *yCoordinateArrays;
/**< 折线颜色 ---   传入数组，一一对应*/
@property (strong, nonatomic) NSArray *chartLinecolors;
/**< 目标值*/
@property (nonatomic, assign) CGFloat targetLinecount;
/**< 目标值视图*/
@property (nonatomic, strong) UIView *achieveTargetView;
/**< 目标值提示文字*/
@property (nonatomic, copy) NSString *targetTipWord;
/**< 数组中对应每条折线是否显示最高最低点。 以字符串形式保存。 @"1" == YES, @"0" == NO;*/
@property (strong, nonatomic) NSArray *showMaxMinArray;
/**< 显示范围*/
@property (nonatomic, assign) CGRange chooseRange;
/**< 是否显示渐变色阴影*/
@property (nonatomic, assign) BOOL isShowShadow;
/**< 渐变色阴影数组   建议array.count >= 3*/
@property (nonatomic, strong) NSArray *shadowColorArray;
/**< 是否显示绘制动画*/
@property (nonatomic, assign) BOOL isShowDrawAnimation;
/**< 是否显示y坐标*/
@property (nonatomic, assign) BOOL isShowYCoordinate;
/**
 *  创建折线视图
 *
 *  @param rect      视图尺寸
 *  @param superView 需要添加到的父视图
 *
 *  @return <#return value description#>
 */
+ (YzLineChartView *)creatLineChartViewWithFrame:(CGRect)rect superView:(UIView *)superView ;

/**< 绘图*/
-(void)strokeChart;
@end
