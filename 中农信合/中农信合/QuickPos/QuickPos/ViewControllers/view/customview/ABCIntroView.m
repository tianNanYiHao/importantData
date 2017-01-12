//
//  IntroView.m
//  DrawPad
//
//  Created by Adam Cooper on 2/4/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "ABCIntroView.h"
#import "Common.h"

@interface ABCIntroView () <UIScrollViewDelegate>{


    UIButton *doneButton;
    

}
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIPageControl *pageControl;
@property UIView *holeView;
@property UIView *circleView;
//@property UIButton *doneButton;

@end

@implementation ABCIntroView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
       [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundImageView.image = [UIImage imageNamed:@"Intro_Screen_Background"];
        [self addSubview:backgroundImageView];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        //滑动点点
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height*0.81, self.frame.size.width, 10)];
//        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [self addSubview:self.pageControl];
        
        [self createViewOne];
        [self createViewTwo];
        [self createViewThree];
//        [self createViewFour];
        
        
        //Done Button
//        doneButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.85, self.frame.size.width*.8, 60)];
//        [doneButton setTintColor:[UIColor whiteColor]];
//        [doneButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
//        [doneButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
//        doneButton.backgroundColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
//        doneButton.layer.borderColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000].CGColor;
//        [doneButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        doneButton.layer.borderWidth =.5;
//        doneButton.layer.cornerRadius = 15;
        //[self addSubview:doneButton];
        
        
        self.pageControl.numberOfPages = 3;
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width*3, self.scrollView.frame.size.height);
        
        //This is the starting point of the ScrollView
        CGPoint scrollPoint = CGPointMake(0, 0);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    return self;
}

- (void)onFinishedIntroButtonPressed:(id)sender {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.delegate onDoneButtonPressed];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    
}


-(void)createViewOne{
    
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
    titleLabel.text = [NSString stringWithFormat:@"Pixifly"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"help1"];
    [view addSubview:imageview];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"Description for First Screen."];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
    [descriptionLabel sizeToFit];
    //[view addSubview:descriptionLabel];
    
    //跳过
//    UIButton *gotoButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*.7, self.frame.size.height*.15, self.frame.size.width*.8, 60)];
    
    UIButton *gotoButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 50, 20)];
    
    [gotoButton setTintColor:[UIColor whiteColor]];
    [gotoButton setTitle:@"跳过" forState:UIControlStateNormal];
    [gotoButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
    gotoButton.backgroundColor = [UIColor clearColor];
    [gotoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [gotoButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:gotoButton];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.7);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}


-(void)createViewTwo{
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth, 0, originWidth, originHeight)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
    titleLabel.text = [NSString stringWithFormat:@"DropShot"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"help2"];
    [view addSubview:imageview];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"Description for Second Screen."];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
    [descriptionLabel sizeToFit];
    //[view addSubview:descriptionLabel];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.7);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}

-(void)createViewThree{
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth*2, 0, originWidth, originHeight)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
    titleLabel.text = [NSString stringWithFormat:@"Shaktaya"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
//    imageview.image = [UIImage imageNamed:@"Intro_Screen_Two"];
//    [view addSubview:imageview];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"help3"];
    [view addSubview:imageview];
    
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.65, self.frame.size.width*.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"Description for Third Screen."];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
    [descriptionLabel sizeToFit];
    //[view addSubview:descriptionLabel];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.7);
    descriptionLabel.center = labelCenter;
    
    //Done Button
    doneButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*0.192, self.frame.size.height*0.88, self.frame.size.width*0.6, 30)];
    [doneButton setTintColor:[UIColor whiteColor]];
    [doneButton setTitle:@"知道了" forState:UIControlStateNormal];
    [doneButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
//    doneButton.backgroundColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
//    doneButton.layer.borderColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000].CGColor;
    
    //doneButton 背景颜色
    doneButton.backgroundColor = [Common hexStringToColor:@"#56c6f7"];
    doneButton.layer.borderColor = [Common hexStringToColor:@"#56c6f7"].CGColor;
    
    [doneButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    doneButton.layer.borderWidth =.5;
    doneButton.layer.cornerRadius = 5;
    
    [view addSubview:doneButton];
    
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}


-(void)createViewFour{
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth*3, 0, originWidth, originHeight)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
    titleLabel.text = [NSString stringWithFormat:@"Punctual"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
//    imageview.image = [UIImage imageNamed:@"Intro_Screen_Two"];
//    [view addSubview:imageview];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"help4"];
    [view addSubview:imageview];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"Description for Fourth Screen."];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
    [descriptionLabel sizeToFit];
    //[view addSubview:descriptionLabel];
    
    //Done Button
    doneButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*0.192, self.frame.size.height*0.85, self.frame.size.width*0.6, 50)];
    [doneButton setTintColor:[UIColor whiteColor]];
    [doneButton setTitle:@"知道了" forState:UIControlStateNormal];
    [doneButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    doneButton.backgroundColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
    doneButton.layer.borderColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000].CGColor;
    [doneButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    doneButton.layer.borderWidth =.5;
    doneButton.layer.cornerRadius = 5;

    [view addSubview:doneButton];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.7);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com