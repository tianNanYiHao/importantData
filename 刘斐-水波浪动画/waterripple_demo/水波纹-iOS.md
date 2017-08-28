##简介 
使用iOS原生CoreGraphic框架完成，主要内容就是在给定的路径上绘制出图形，水波纹的实现是按照三角函数的sin函数来实现的，利用sin函数计算出大量的点，然后做颜色填充。
##实现方法
首先一个波纹需要一个layer来进行渲染，越底层的波纹要越早绘制，本Demo只实现了双波纹交错。
水波纹基本属性：

**不需要对外暴露的属性**
```
@interface WaterRippleView(){
    float _currentLinePointY;
}
@property (nonatomic, strong)CADisplayLink *rippleDisplayLink;//苹果的垂直同步
@property (nonatomic, strong)CAShapeLayer *mainRippleLayer;//主波图层
@property (nonatomic, strong)CAShapeLayer *minorRippleLayer;//次波图层
@property (nonatomic, assign)CGFloat rippleWidth;//波浪宽度
@end
```
**可以对外暴露的属性**
```
@property (nonatomic, strong)UIColor *mainRippleColor;//主波填充颜色
@property (nonatomic, strong)UIColor *minorRippleColor;//次波填充颜色
@property (nonatomic, assign)CGFloat mainRippleoffsetX;//主波偏移量
@property (nonatomic, assign)CGFloat minorRippleoffsetX;//次波偏移量
@property (nonatomic, assign)CGFloat rippleSpeed;//波浪速度
@property (nonatomic, assign)CGFloat ripplePosition;//波浪Y轴位置
@property (nonatomic, assign)float rippleAmplitude;//波浪振幅
```
**各属性的默认值设置**
```
        self.mainRippleColor = [UIColor colorWithRed:255/255.0f green:127/255.0f blue:80/255.0f alpha:1];
        self.minorRippleColor = [UIColor whiteColor];
        self.mainRippleoffsetX = 1;
        self.minorRippleoffsetX = 2;
        self.rippleSpeed = .5f;
        self.rippleWidth = frame.size.width;
        self.ripplePosition = frame.size.height-10.0f;
        self.rippleAmplitude = 5;
```
**对外暴露的方法**
```
//设置frame 主波填充颜色  次波填充颜色
- (instancetype)initWithFrame:(CGRect)frame mainRippleColor:(UIColor *)mainRippleColor minorRippleColor:(UIColor *)minorRippleColor;
//设置frame 主波填充颜色  次波填充颜色 主波偏移量 次波偏移量 波浪速度 波浪Y轴位置 波浪振幅
- (instancetype)initWithFrame:(CGRect)frame mainRippleColor:(UIColor *)mainRippleColor minorRippleColor:(UIColor *)minorRippleColor mainRippleoffsetX:(float)mainRippleoffsetX minorRippleoffsetX:(float)minorRippleoffsetX rippleSpeed:(float)rippleSpeed ripplePosition:(float)ripplePosition rippleAmplitude:(float)rippleAmplitude;
```
在view中需要绘制图形时，要在自带的dramRect：方法中编写相关代码
```
- (void)drawRect:(CGRect)rect {
    /*
     *创建两个layer
     */
    self.mainRippleLayer = [CAShapeLayer layer];
    self.mainRippleLayer.fillColor = self.mainRippleColor.CGColor;
    [self.layer addSublayer:self.mainRippleLayer];
    self.minorRippleLayer = [CAShapeLayer layer];
    self.minorRippleLayer.fillColor = self.minorRippleColor.CGColor;
    [self.layer addSublayer:self.minorRippleLayer];
    self.rippleDisplayLink = [CADisplayLink displayLinkWithTarget:self
                                                         selector:@selector(getCurrentRipple)];
    [self.rippleDisplayLink addToRunLoop:[NSRunLoop mainRunLoop]
                                 forMode:NSRunLoopCommonModes];
}
```
下面是绘制代码：
**主波**
```
- (void)drawMainRipple{
    self.mainRippleoffsetX += self.rippleSpeed;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, self.ripplePosition);
    CGFloat y = 0.f;
    for (float x = 0.f; x <= self.rippleWidth ; x++) {
        y = self.rippleAmplitude * sin(1.2 *  M_PI/ self.rippleWidth  * x   - self.mainRippleoffsetX *M_PI/180) + self.ripplePosition;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, self.rippleWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    self.mainRippleLayer.path = path;
    CGPathRelease(path);
}
```
**次波**
```
- (void)drawMinorRipple{
    self.minorRippleoffsetX += self.rippleSpeed+0.1f;
    CGMutablePathRef minorRipple = CGPathCreateMutable();
    CGPathMoveToPoint(minorRipple, nil, 0, self.ripplePosition);
    CGFloat y = 0.f;
    for (float x = 0.f; x <= self.rippleWidth ; x++) {
        y = self.rippleAmplitude * sin(1.2 *  M_PI/ self.rippleWidth  * x   - self.minorRippleoffsetX*M_PI/360 ) + self.ripplePosition;
        CGPathAddLineToPoint(minorRipple, nil, x, y);
    }
    CGPathAddLineToPoint(minorRipple, nil, self.rippleWidth, self.frame.size.height);
    CGPathAddLineToPoint(minorRipple, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(minorRipple);
    self.minorRippleLayer.path = minorRipple;
    CGPathRelease(minorRipple);
}

```
###实现效果

![水波纹Gif](http://img.blog.csdn.net/20170525155948950?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWnVvV2VpWGlhb0R1WnVvWnVv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
##最后
本Demo的git库地址：https://git.oschina.net/LiynXu/waterripple.git
欢迎访问