//
//  SwitchLff.m
//  customFaceSwitchLFF
//
//  Created by Lff on 16/12/30.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "SwitchLff.h"
#import "AnimationManagerLff.h"
#import "EyeMouthLayerLff.h"
#define selfHeight self.bounds.size.height
#define selfWidth self.bounds.size.width
#define FaceMoveAnimationKey @"FaceMoveAnimationKey"
#define BackGroundColorAnimationKey @"BackGroundColorAnimationKey"
#define EyeMouthLayerStarAnimationKey @"EyeMouthLayerStarAnimationKey"
#define EyesMoveEndAnimationKey @"EyesMoveEndAnimationKey"
#define EyesMoveBackAnimationKey @"EyesMoveBackAnimationKey"
#define EyesCloseAndOpenAnimationKey @"EyesCloseAndOpenAnimationKey"
#define MouthOpenCloseAnimationKey @"MouthOpenCloseAnimationKey"
@interface SwitchLff()<CAAnimationDelegate>{
    
}
@property (nonatomic,strong)UIView *backGroundView; //背景View
@property (nonatomic,strong)CAShapeLayer *circleFaceLayer;  // 脸layer
@property (nonatomic,assign)CGFloat paddingWidth; //间隙
@property (nonatomic,assign)CGFloat circleFaceRadius; //半径
@property (nonatomic,assign)CGFloat moveDistanc; //滚动距离
@property (nonatomic,assign)CGFloat animationDruation; //动画时长
@property (nonatomic,strong)AnimationManagerLff *animationManager;
@property (nonatomic,strong)EyeMouthLayerLff *eyeMouthLayer;
@property (nonatomic,assign)BOOL isAnimating;
@property (nonatomic,assign)CGFloat facelayerWidth;

@end


@implementation SwitchLff

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self instansView];
    }return self;
}


-(void)instansView{
    
    //设置初始属性
    _onColor = [UIColor colorWithRed:73/255.0 green:182/255.0 blue:235/255.0 alpha:1.f];  //淡蓝
    _offColor = [UIColor colorWithRed:211/255.0 green:207/255.0 blue:207/255.0 alpha:1.f]; //灰色
    _faceColor = [UIColor whiteColor];
    _paddingWidth = selfHeight * 0.1f;
    _circleFaceRadius = (selfHeight - _paddingWidth*2)/2;
    _moveDistanc = selfWidth-2*_paddingWidth-2*_circleFaceRadius;
    _animationDruation = 1.0f;
    self.backGroundView.backgroundColor = _offColor;
    self.circleFaceLayer.fillColor = _faceColor.CGColor;
    
    _on = NO;
    _isAnimating = NO; //控制手势点击
    self.circleFaceLayer.masksToBounds = YES;
    self.facelayerWidth = self.circleFaceLayer.frame.size.width;
    [self.eyeMouthLayer setNeedsDisplay];
    //实例化动画管理类
    _animationManager = [[AnimationManagerLff alloc] initWithAnimationDruation:_animationDruation];
    
    //手势
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(hanleTapSwitch)]];
    
}


#pragma mark - tapGesture
-(void)hanleTapSwitch{
    if (_isAnimating) {
        return;
    }
    _isAnimating = YES; //设置手势不可点击
    // 脸layer平移动画
    CABasicAnimation *faceMoveAnimation =   [_animationManager faceMoveAnimationFromPosition: _on?CGPointMake(_circleFaceLayer.position.x+_moveDistanc, _circleFaceLayer.position.y):CGPointMake(_circleFaceLayer.position.x, _circleFaceLayer.position.y) toPosition:_on?CGPointMake(_circleFaceLayer.position.x, _circleFaceLayer.position.y):CGPointMake(_circleFaceLayer.position.x + _moveDistanc, _circleFaceLayer.position.y)];
     faceMoveAnimation.delegate = self;
    [_circleFaceLayer addAnimation:faceMoveAnimation forKey:FaceMoveAnimationKey];
   
    
    
    //背景色渐变动画
    CABasicAnimation *backgroundAnimation = [_animationManager backgroudColorAnimationFormValue:(id)(_on ? _onColor : _offColor).CGColor toValue:(id)(_on ? _offColor.CGColor : _onColor.CGColor)];
    backgroundAnimation.delegate = self;
    [_backGroundView.layer addAnimation:backgroundAnimation forKey:BackGroundColorAnimationKey];
    
    //脸内部Layer平移动画 动作一(1)
    CABasicAnimation *eyeMouthLayerAnimation = [_animationManager eyeMouthLayerAnimationFromValue:@(0) toValue:@(_on?-_facelayerWidth: _facelayerWidth)];
    eyeMouthLayerAnimation.delegate = self;
    [_eyeMouthLayer addAnimation:eyeMouthLayerAnimation forKey:EyeMouthLayerStarAnimationKey];

    
    // 控制开关及重置状态
    _on = ! _on;
    
    
    
    
    
}
#pragma mark - AnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim{
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        //脸内部Layer平移动画 动作一(2)
        if (anim == [_eyeMouthLayer animationForKey:EyeMouthLayerStarAnimationKey]) {
            _eyeMouthLayer.eyeColor = _on?self.onColor:self.offColor;
            _eyeMouthLayer.isHappy = _on?YES:NO;
            [_eyeMouthLayer setNeedsDisplay];
            CABasicAnimation *rotationAnimation = [_animationManager eyeMouthLayerAnimationFromValue:@(_on?-_facelayerWidth:_facelayerWidth) toValue:@( _on?_facelayerWidth/6:-_facelayerWidth/6)];
            rotationAnimation.delegate = self;
            [_eyeMouthLayer addAnimation:rotationAnimation forKey:EyesMoveEndAnimationKey];
            
        }
        //_eyeMouthLayer 回头动画 动作二
        if (anim == [_eyeMouthLayer animationForKey:EyesMoveEndAnimationKey]) {
            CABasicAnimation *rotationAnimation = [_animationManager eyeMouthLayerAnimationFromValue:@(_on ? _facelayerWidth / 6 :  -_facelayerWidth / 6) toValue:@(0)];
            rotationAnimation.delegate = self;
            [_eyeMouthLayer addAnimation:rotationAnimation forKey:EyesMoveBackAnimationKey];
            //eyeCloseAndOpen 闭眼睁眼 动作三
            if (_on) {
                CAKeyframeAnimation *eyeCloseAndOpen = [_animationManager eyeCloseAndOpenAnimationWithRect:_eyeMouthLayer.eyeRect];
                eyeCloseAndOpen.delegate = self;
                [_eyeMouthLayer addAnimation:eyeCloseAndOpen forKey:EyesCloseAndOpenAnimationKey];
            }
        }
        //mouthOpenClose 嘴部动画 动作四
        if (anim == [_eyeMouthLayer animationForKey:EyesCloseAndOpenAnimationKey]) {
            CAKeyframeAnimation *mouthOpenCloseAnimation = [_animationManager mouthOpenAndCloseAnimationHeight:0 on:_on];
            [_eyeMouthLayer addAnimation:mouthOpenCloseAnimation forKey:MouthOpenCloseAnimationKey];
        }
        
        if (anim == [_eyeMouthLayer animationForKey:EyesMoveBackAnimationKey]) {
            [_eyeMouthLayer removeAllAnimations];
            _isAnimating = NO; //手势可以重新点击
        }
        
    }
   
    
    
}


#pragma mark -lazyAdd
- (UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backGroundView.layer.masksToBounds = YES;
        _backGroundView.layer.cornerRadius = selfHeight/2;
        [self addSubview:_backGroundView];
    }
    return _backGroundView;
}
-(CAShapeLayer *)circleFaceLayer{
    if (!_circleFaceLayer) {
        _circleFaceLayer = [CAShapeLayer layer];
        _circleFaceLayer.frame = CGRectMake(_paddingWidth, _paddingWidth, _circleFaceRadius
                                            *2, _circleFaceRadius*2);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_circleFaceLayer.bounds];
        _circleFaceLayer.path = path.CGPath;
//        _circleFaceLayer.backgroundColor = [UIColor cyanColor].CGColor;
        [_backGroundView.layer addSublayer:_circleFaceLayer];
    }
    return _circleFaceLayer;
}
-(EyeMouthLayerLff *)eyeMouthLayer{
    if (!_eyeMouthLayer) {
        _eyeMouthLayer = [EyeMouthLayerLff layer];
        _eyeMouthLayer.eyeColor = _offColor;
        _eyeMouthLayer.frame =  CGRectMake(_facelayerWidth / 4, _circleFaceLayer.frame.size.height * 0.28, _facelayerWidth / 2, _circleFaceLayer.frame.size.height * 0.72);
        _eyeMouthLayer.eyeSpace = _facelayerWidth/3;
        _eyeMouthLayer.eyeColor = _offColor;
        _eyeMouthLayer.mouthY = 0;
        _eyeMouthLayer.isHappy = NO;
        _eyeMouthLayer.eyeRect = CGRectMake(0, 0, _facelayerWidth/6, _circleFaceLayer.frame.size.height * 0.22);
//        _eyeMouthLayer.backgroundColor = [UIColor yellowColor].CGColor;
        [self.circleFaceLayer addSublayer:_eyeMouthLayer];
    }return _eyeMouthLayer;
}


#pragma mark -setter
-(void)setOn:(BOOL)on{
    _on = on;
    if (on) {
        self.eyeMouthLayer.eyeColor = _onColor;
//        [self.eyeMouthLayer needsDisplay];
    }
}

-(void)setOnColor:(UIColor *)onColor{
    _onColor = onColor;
    if (_on) {
        _eyeMouthLayer.eyeColor = _onColor;
        _eyeMouthLayer.mouthY = _facelayerWidth/3;
        _eyeMouthLayer.isHappy = _on;
        [self.eyeMouthLayer setNeedsDisplay];
    }
}
-(void)setOffColor:(UIColor *)offColor{
    _offColor = offColor;
    if (!_on) {
        _eyeMouthLayer.eyeColor = _offColor;
        [self.eyeMouthLayer setNeedsDisplay];
    }
}

@end
