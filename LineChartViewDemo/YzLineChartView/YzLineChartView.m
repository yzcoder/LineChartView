//
//  ViewController.h
//  LineChartViewDemo
//
//  Created by Yz on 16/5/3.
//  Copyright © 2016年 Yuz. All rights reserved.
//



#define kChartCavanHeight (self.frame.size.height - kLabelHeight*3)


#import "YzLineChartView.h"

@interface YzLineChartView ()

@property (strong, nonatomic) NSArray * yLabels;
@property (nonatomic) CGFloat xLabelWidth;
@property (nonatomic) CGFloat yValueMin;
@property (nonatomic) CGFloat yValueMax;
@end

@implementation YzLineChartView
+ (YzLineChartView *)creatLineChartViewWithFrame:(CGRect)rect superView:(UIView *)superView {
    UIView *backgroundView = [[UIView alloc] initWithFrame:rect];
    [superView addSubview:backgroundView];
    YzLineChartView *chartLineView = [[YzLineChartView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [backgroundView addSubview:chartLineView];
    return chartLineView;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}





-(void)setYCoordinateArrays:(NSArray *)yCoordinateArrays
{
    _yCoordinateArrays = yCoordinateArrays;
    [self setYLabels:yCoordinateArrays];
}

-(void)setYLabels:(NSArray *)yLabels
{
    NSInteger max = 0;
    NSInteger min = 1000000000;
    
    for (NSArray *ary in yLabels) {
        for (NSString *valueString in ary) {
            NSInteger value = [valueString integerValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    max = max<5 ? 5:max;
    _yValueMin = 0;
    _yValueMax = (int)max;
    
    if (_chooseRange.max != _chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }
    
    if (self.isShowYCoordinate) {
        
        float level = (_yValueMax-_yValueMin) /4.0;
        CGFloat levelHeight = kChartCavanHeight /4.0;
        for (int i=0; i<5; i++) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0.0,kChartCavanHeight-i*levelHeight+5, YCoordinateWidth, kLabelHeight)];
            label.font = [UIFont systemFontOfSize:11];
            label.text = [NSString stringWithFormat:@"%d",(int)(level * i+_yValueMin)];
            [self addSubview:label];
        }
    }
}

-(void)setXCoordinateArray:(NSArray *)xCoordinateArray
{
    
    
    _xCoordinateArray = xCoordinateArray;
    CGFloat num = 0;
    if (xCoordinateArray.count<=1){
        num=1.0;
    }else{
        num = xCoordinateArray.count;
    }
    _xLabelWidth = (self.frame.size.width - YCoordinateWidth)/num;
    
    for (int i=0; i<xCoordinateArray.count; i++) {
        NSString *labelText = xCoordinateArray[i];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(i * _xLabelWidth+YCoordinateWidth - _xLabelWidth/2 - 3, self.frame.size.height - kLabelHeight, _xLabelWidth+6, kLabelHeight)];
        label.text = labelText;
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        [label setMinimumScaleFactor:5.0f];
        [label setNumberOfLines:1];
        [label setFont: [UIFont systemFontOfSize:11]];
        [label setTextColor:kColorWithRGB(0, 0, 0, 0.8)];
        [label setTextAlignment:NSTextAlignmentCenter];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        [self addSubview:label];
        
        //        [_chartLabelsForX addObject:label];
    }
    
    //画竖线
    for (int i=0; i<xCoordinateArray.count+1; i++) {
        
        //绘制渐变竖线
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(YCoordinateWidth+i*_xLabelWidth,kLabelHeight)];
        [path addLineToPoint:CGPointMake(YCoordinateWidth+i*_xLabelWidth,self.frame.size.height-2*kLabelHeight)];
        [path closePath];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = @[(__bridge id)kColorWithRGB(0, 0, 0, 0.05).CGColor,
                                 (__bridge id)kColorWithRGB(0, 0, 0, 0.1).CGColor,
                                 (__bridge id)kColorWithRGB(0, 0, 0, 0.15).CGColor,
                                 (__bridge id)kColorWithRGB(0, 0, 0, 0.20).CGColor,
                                 (__bridge id)kColorWithRGB(0, 0, 0, 0.25).CGColor,
                                 (__bridge id)kColorWithRGB(0, 0, 0, 0.30).CGColor];
        gradientLayer.locations=@[@0.0,@0.2,@1.0];
        gradientLayer.startPoint = CGPointMake(0.5,0.5);
        gradientLayer.endPoint = CGPointMake(0.5,1);
        
        
        
        CAShapeLayer *arc = [CAShapeLayer layer];
        arc.path =path.CGPath;
        arc.fillColor = [UIColor yellowColor].CGColor;
        arc.strokeColor = [UIColor yellowColor].CGColor;
        arc.lineWidth = 0.5;
        gradientLayer.mask=arc;
        
        [self.layer addSublayer:gradientLayer];
        
        
        
        
        
    }
}



-(void)strokeChart
{
    
    
    UIBezierPath *shadowPath=[[UIBezierPath alloc] init];
    [shadowPath moveToPoint:CGPointMake(YCoordinateWidth, self.frame.size.height - kLabelHeight*2)];
    
    for (int i=0; i<_yCoordinateArrays.count; i++) {
        NSArray *childAry = _yCoordinateArrays[i];
        if (childAry.count==0) {
            return;
        }
        //获取最大最小位置
        CGFloat max = [childAry[0] floatValue];
        CGFloat min = [childAry[0] floatValue];
        NSInteger max_i = 0;
        NSInteger min_i = 0;
        
        for (int j=0; j<childAry.count; j++){
            CGFloat num = [childAry[j] floatValue];
            if (max<=num){
                max = num;
                max_i = j;
            }
            if (min>=num){
                min = num;
                min_i = j;
            }
        }
        
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = 1.0;
        _chartLine.strokeEnd   = 0.0;
        [self.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        
        
        
        
        
        CGFloat firstValue = [[childAry objectAtIndex:0] floatValue];
        
        float grade = ((float)firstValue-_yValueMin) / ((float)_yValueMax-_yValueMin);
        
        //第一个点
        BOOL isShowMaxAndMinPoint = YES;
        if (self.showMaxMinArray) {
            if ([self.showMaxMinArray[i] intValue]>0) {
                isShowMaxAndMinPoint = (max_i==0 || min_i==0)?NO:YES;
            }else{
                isShowMaxAndMinPoint = YES;
            }
        }
        [self addPoint:CGPointMake(YCoordinateWidth, kChartCavanHeight - grade * kChartCavanHeight+kLabelHeight)
                 index:i
                isShow:isShowMaxAndMinPoint
                 value:firstValue];
        
        CGPoint chartPoint = CGPointMake(YCoordinateWidth, kChartCavanHeight - grade * kChartCavanHeight+kLabelHeight);
        
        [shadowPath addLineToPoint:chartPoint];
        
        
        [progressline moveToPoint:chartPoint];
        [progressline setLineWidth:2.0];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        for (NSString * valueString in childAry) {
            
            float grade =([valueString floatValue]-_yValueMin) / ((float)_yValueMax-_yValueMin);
            if (index != 0) {
                
                CGPoint point = CGPointMake(YCoordinateWidth+index*_xLabelWidth, kChartCavanHeight - grade * kChartCavanHeight+kLabelHeight);
                [progressline addLineToPoint:point];
                
                [shadowPath addLineToPoint:point];
                
                BOOL isShowMaxAndMinPoint = YES;
                if (self.showMaxMinArray) {
                    if ([self.showMaxMinArray[i] intValue]>0) {
                        isShowMaxAndMinPoint = (max_i==index || min_i==index)?NO:YES;
                    }else{
                        isShowMaxAndMinPoint = YES;
                    }
                }
                [progressline moveToPoint:point];
                [self addPoint:point
                         index:i
                        isShow:isShowMaxAndMinPoint
                         value:[valueString floatValue]];
            }
            index += 1;
        }
        [shadowPath addLineToPoint:CGPointMake(self.frame.size.width  - _xLabelWidth, self.frame.size.height - kLabelHeight*2)];
        [shadowPath closePath];
        
        
        
        
        _chartLine.path = progressline.CGPath;
        if ([[_chartLinecolors objectAtIndex:i] CGColor]) {
            _chartLine.strokeColor = [[_chartLinecolors objectAtIndex:i] CGColor];
        }else{
            _chartLine.strokeColor = [UIColor greenColor].CGColor;
        }
        _chartLine.strokeEnd = 1.0;
        
        if (self.isShowShadow) {
            //绘制渐变色层
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.frame = self.bounds;
            NSMutableArray *shadowsColors = [NSMutableArray array];
            for (UIColor *color in self.shadowColorArray) {
                [shadowsColors addObject:(__bridge id)color.CGColor];
            }
            gradientLayer.colors = shadowsColors;
            gradientLayer.locations=@[@0.0,@0.2,@1.0];
            gradientLayer.startPoint = CGPointMake(0.5,0.5);
            gradientLayer.endPoint = CGPointMake(0.5,1);
            [self.layer addSublayer:gradientLayer];//加上渐变层
            
            
            CAShapeLayer *arc = [CAShapeLayer layer];
            arc.path =shadowPath.CGPath;
            arc.fillColor = [UIColor yellowColor].CGColor;
            arc.strokeColor = [UIColor yellowColor].CGColor;
            arc.lineWidth = 1;
            gradientLayer.mask=arc;
        }
        
        
        if (self.isShowDrawAnimation) {
            //        绘制动画
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.duration = childAry.count*0.4;
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
            pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
            pathAnimation.autoreverses = NO;
            [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        }
        
        
    }
    
    
    
    if (self.targetLinecount != 0) {
        
        //画目标值虚线
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        // 设置虚线颜色为
        [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
        [shapeLayer setStrokeColor:[[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f] CGColor]];
        
        // 3.0f设置虚线的宽度
        [shapeLayer setLineWidth:1.0f];
        [shapeLayer setLineJoin:kCALineJoinRound];
        
        // 4=线的宽度 2=每条线的间距
        [shapeLayer setLineDashPattern:@[@(4),@(2)]];
        [shapeLayer setBounds:self.bounds];
        [shapeLayer setPosition:self.center];
        // Setup the path
        CGMutablePathRef dashedPath = CGPathCreateMutable();
        
        float grade =(_targetLinecount-_yValueMin) / ((float)_yValueMax-_yValueMin);
        
        //起点
        CGPathMoveToPoint(dashedPath, NULL, YCoordinateWidth, kChartCavanHeight - grade * kChartCavanHeight+kLabelHeight);
        //终点
        CGPathAddLineToPoint(dashedPath, NULL, self.frame.size.width  - _xLabelWidth,kChartCavanHeight - grade * kChartCavanHeight+kLabelHeight);
        
        [shapeLayer setPath:dashedPath];
        
        
        [self.layer addSublayer:shapeLayer];
        CGPathRelease(dashedPath);
        
        
        if (self.achieveTargetView) {
            
            //添加目标值图标
            UIView *achieveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            achieveView.backgroundColor = [UIColor clearColor];
            achieveView.center = CGPointMake(YCoordinateWidth, kChartCavanHeight - grade * kChartCavanHeight+kLabelHeight);
            [achieveView addSubview:self.achieveTargetView];
            self.achieveTargetView.center = CGPointMake(25, 25);
            [self addSubview:achieveView];
            
            
            //            添加目标值label
            UILabel *targetLabel = [[UILabel alloc] initWithFrame:CGRectMake(YCoordinateWidth+15, kChartCavanHeight - grade * kChartCavanHeight+kLabelHeight - kLabelHeight - 10, 80, kLabelHeight)];
            targetLabel.text = self.targetTipWord;
            targetLabel.textAlignment = NSTextAlignmentLeft;
            [targetLabel setNumberOfLines:1];
            [targetLabel setFont:[UIFont systemFontOfSize:11]];
            [targetLabel setTextColor:kColorWithRGB(0, 0, 0, 0.8)];
            [self addSubview:targetLabel];
            
        }
    }
    
}

- (void)addPoint:(CGPoint)point index:(NSInteger)index isShow:(BOOL)isHollow value:(CGFloat)value
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 4, 4)];
    view.center = point;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 2;
    view.layer.borderWidth = 2;
    view.layer.borderColor = [[_chartLinecolors objectAtIndex:index] CGColor]?[[_chartLinecolors objectAtIndex:index] CGColor]:[UIColor greenColor].CGColor;
    
    if (isHollow) {
        view.backgroundColor = [UIColor whiteColor];
    }else{
        view.backgroundColor = [_chartLinecolors objectAtIndex:index]?[_chartLinecolors objectAtIndex:index]:[UIColor greenColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x-MinMaxMarkLabelwidth/2.0, point.y-kLabelHeight*2, MinMaxMarkLabelwidth, kLabelHeight)];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = view.backgroundColor;
        label.text = [NSString stringWithFormat:@"%d",(int)value];
        [self addSubview:label];
    }
    
    [self addSubview:view];
}


@end
