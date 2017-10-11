//
//  ViewController.m
//  SDCardScrollView
//
//  Created by tianNanYiHao on 2017/9/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SDCardScrollView.h"

#define Width [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<SDCardScrollViewDelegate,SDCardScrollViewDataSource>
{
    SDCardScrollView *sdv;
}
/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation ViewController

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    for (int index = 0; index < 5; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d",index]];
        [self.imageArray addObject:image];
    }


    
    sdv = [[SDCardScrollView alloc] initWithFrame:CGRectMake(0, 72, self.view.frame.size.width, self.view.frame.size.width*9/16)];
    sdv.delegate = self;
    sdv.dataSource = self;
    sdv.isCarousel = NO;
    [sdv reloadData];
    [self.view addSubview:sdv];
    

    
}


#pragma - mark SDCardScrollViewDelegate
- (CGSize)sizeForCellInScrollview:(SDCardScrollView *)scrollview{
    return CGSizeMake(Width-40, (Width-40)*9/16);
}

#pragma - mark SDCardScrollViewDataSource
- (CGFloat)numbersOfCellInSDCardScrollView:(SDCardScrollView *)scrollview{
    return self.imageArray.count;
}

- (SDCardScrollViewCell*)cell:(SDCardScrollView *)scrollView cellForIndex:(NSInteger)index{
    
    SDCardScrollViewCell *cell = [scrollView dequeueReusableCell];
    if (!cell) {
        cell = [[SDCardScrollViewCell alloc] init];
        cell.tag = index;
        cell.layer.cornerRadius = 5.f;
        cell.layer.masksToBounds = YES;
    }
    cell.mainImageView.image = self.imageArray[index];
    return cell;
    
}



@end
