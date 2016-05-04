//
//  ViewController.m
//  LineChartViewDemo
//
//  Created by Yz on 16/5/3.
//  Copyright © 2016年 Yuz. All rights reserved.
//


#define kColorHex(hexValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:1.0]

#import "ViewController.h"
#import "YzLineChartView.h"
#import "UIView+YzViewBorder.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    YzLineChartView *lineChart = [YzLineChartView creatLineChartViewWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 200) superView:self.view];
    
    lineChart.xCoordinateArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    NSArray *arr = @[@"23",@"142",@"225",@"145",@"330",@"600",@"322"];
    
    lineChart.chooseRange = CGRangeMake(1000, 0);
    
    lineChart.yCoordinateArrays = @[arr];
    
    lineChart.chartLinecolors = @[kColorHex(0xab55cf)];
    
    lineChart.showMaxMinArray = @[@"1"];
    lineChart.isShowShadow = YES;
    lineChart.shadowColorArray = @[kColorWithRGB(171, 85, 207, 0.5),kColorWithRGB(171, 85, 207, 0.3),kColorWithRGB(171, 85, 207, 0.1)];
    lineChart.targetLinecount = 500;
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 19, 19)];
    backV.backgroundColor = kColorHex(0xab55cf);
    [backV cornerRadiusStyleWithValue:9.5];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_trend_mubiao"]];
    imageView.frame = CGRectMake(0, 0, 10, 10);
    [backV addSubview:imageView];
    imageView.center = backV.center;
    lineChart.targetTipWord = @"500步";
    lineChart.isShowDrawAnimation = YES;
    lineChart.achieveTargetView = backV;
    lineChart.isShowYCoordinate = YES;
    [lineChart strokeChart];
    
    
    
    
    
    YzLineChartView *lineChart2 = [YzLineChartView creatLineChartViewWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 200) superView:self.view];
    
    lineChart2.xCoordinateArray = @[@"第一天",@"",@"第三天",@"",@"第五天",@"",@"第七天",@"",@"第九天",@""];
    
    NSArray *arr2 = @[@"23",@"142",@"225",@"145",@"330",@"600",@"322",@"145",@"322",@"142"];
    NSArray *arr3 = @[@"225",@"145",@"322",@"142",@"23",@"142",@"145",@"322",@"330",@"145"];
    
    
    lineChart2.chooseRange = CGRangeMake(1200, 0);
    
    lineChart2.yCoordinateArrays = @[arr2,arr3];
    
    lineChart2.chartLinecolors = @[kColorHex(0xab55cf),[UIColor redColor]];
    
    lineChart2.showMaxMinArray = @[@"1",@"0"];
    lineChart2.isShowShadow = YES;
    lineChart2.shadowColorArray = @[kColorWithRGB(71, 100, 207, 0.5),kColorWithRGB(85,  100, 207, 0.3),kColorWithRGB(71, 85, 207, 0.1)];
    lineChart2.targetLinecount = 1000;
    UIView *backV2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 19, 19)];
    backV2.backgroundColor = kColorHex(0xab55cf);
    [backV2 cornerRadiusStyleWithValue:9.5];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_trend_mubiao"]];
    imageView2.frame = CGRectMake(0, 0, 10, 10);
    [backV2 addSubview:imageView2];
    imageView2.center = backV2.center;
    lineChart2.targetTipWord = @"1000步";
    lineChart2.isShowDrawAnimation = YES;
    lineChart2.achieveTargetView = backV2;
    lineChart2.isShowYCoordinate = NO;
    [lineChart2 strokeChart];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
