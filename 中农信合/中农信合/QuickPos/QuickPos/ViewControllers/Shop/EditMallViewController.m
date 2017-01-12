//
//  EditMallViewController.m
//  QuickPos
//
//  Created by 张倡榕 on 15/6/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "EditMallViewController.h"
#import "MallCollectionViewCell.h"
#import "MallData.h"
#import "MJRefresh.h"
#import "BoRefreshHeader.h"
#import "BoRefreshAutoStateFooter.h"

@interface EditMallViewController ()<ResponseData,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSString *collectionCellID;
    NSInteger indexRow;                 //记录点击的cell的row；
    int deleteIndex;                    //删除索引
    BOOL photoType;                     //判断图片是否改变
    Request *request;
    NSString *FristId ;
    NSString *LastId ;
    BOOL addType;
    int getDataType;
    UIImage *takePhoneImg;
    
}
@property (weak, nonatomic) IBOutlet UIView *editBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *editMerchandiseImageView; //编辑界面控件
@property (weak, nonatomic) IBOutlet UITextField *editMerchandiseName;
@property (weak, nonatomic) IBOutlet UITextField *editMerchandisePrice;

@property (weak, nonatomic) IBOutlet UICollectionView *editMallCollectionView;



@end

@implementation EditMallViewController
@synthesize mallData;
@synthesize editMerchandiseArr;
@synthesize editMallCollectionView;
@synthesize editMerchandiseImageView;
@synthesize editMerchandiseName;
@synthesize editMerchandisePrice;
@synthesize editBackgroundView;

- (void)viewDidLoad {
    [super viewDidLoad];
    addType = NO;
    collectionCellID = @"MallCollectionViewCellID";
    request = [[Request alloc]initWithDelegate:self];
    editBackgroundView.hidden = YES;
    getDataType = 0;
    //下拉,上拉
    
    self.editMallCollectionView.header = [BoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.editMallCollectionView.footer = [BoRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
    //    [self.editMallCollectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //    [self.editMallCollectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    if (mallData.mallArr.count != 0) {
        FristId = [mallData.mallArr[0] commodityID];
        LastId = [mallData.mallArr[mallData.mallArr.count-1] commodityID];
    }
}

//下拉
-(void)headerRereshing
{
    getDataType = 1;
    [request getMallListmobile:[AppDelegate getUserBaseData].mobileNo firstData:FristId lastData:@"0" dataSize:@"20" requestType:@"02"];
}
//上拉
- (void)footerRereshing
{
    getDataType = 2;
    [request getMallListmobile:[AppDelegate getUserBaseData].mobileNo firstData:@"0" lastData:LastId dataSize:@"20" requestType:@"01"];
}
//网络接口加载collection数据。
- (void)setUpCollection
{
    getDataType = 0;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
    [hud hide:YES afterDelay:10];
    [request getMallListmobile:[AppDelegate getUserBaseData].mobileNo firstData:@"0" lastData:@"0" dataSize:@"20" requestType:@"02"];
    
}



//删除商品
- (IBAction)deleteBtn:(id)sender {
    UICollectionViewCell *cell = (UICollectionViewCell *)[[sender superview]superview];
    NSIndexPath *path = [self.editMallCollectionView indexPathForCell:cell];
    NSString *str = [mallData.mallArr[path.row] commodityID];
    [request DeleteMallDataMobileNo:[AppDelegate getUserBaseData].mobileNo commodityID:str];
    //删除标签
    deleteIndex = path.row;
}

//返回
- (IBAction)returnToMall:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)changeMerchandiseImage:(id)sender {
    if (addType == NO) {
        photoType = YES;
    }
    
    [self addCarema];
}

//添加商品
- (IBAction)addMerchant:(id)sender {
    addType = YES;
    editBackgroundView.hidden = NO;
    editMerchandiseImageView.image = [UIImage imageNamed:@"no_cover"];
    editMerchandiseName.text = nil;
    editMerchandisePrice.text = nil;
}

//编辑/添加取消
- (IBAction)editCloseAction:(id)sender {
    editBackgroundView.hidden = YES;
    addType = NO;
}

//编辑/添加确认
- (IBAction)editClickAction:(id)sender {
    if (addType == NO) {
        NSString *priceVer = editMerchandisePrice.text;
        priceVer = [NSString stringWithFormat:@"%.2f",[priceVer doubleValue]];
        NSString *priceVerde = editMerchandisePrice.text;
        //编辑商品
        if ([editMerchandiseImageView.image isEqual:[UIImage imageNamed:@"no_cover"]])
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"AddGoodsPicture")];
        }
        else if ([editMerchandiseName.text isEqualToString:@""])
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"EnterGoodsName")];
        }
        else if ([editMerchandiseName.text length] > 9)
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"MaximumOfNineWords")];
        }
        else if ([priceVer length] > 9 || [priceVerde isEqualToString:@""] || ![self matchStringFormat:priceVer withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"] || [priceVer isEqualToString:@"0.00"])
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"CorrectCommodityPrices")];
        }
        else if (![self matchStringFormat:priceVerde withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"])
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"CorrectCommodityPrices")];
        }
        else
        {
            NSString *image= nil;
            NSString *CID = [mallData.mallArr[indexRow] commodityID];
            if (photoType == YES) {
                NSData *imageData= UIImagePNGRepresentation(takePhoneImg);
                image = [self stringWithData:imageData];
                photoType = NO;
            }
            NSString *price = priceVer;
            [request changeMallDataMobileNo:[AppDelegate getUserBaseData].mobileNo commodityID:CID icon:image title:[NSString stringWithFormat:@"%@",editMerchandiseName.text] price:price amount:@"1"];
            editBackgroundView.hidden = YES;
            
        }
        
    }
    else if(addType == YES)
    {
        NSString *priceVer = editMerchandisePrice.text;
        priceVer = [NSString stringWithFormat:@"%.2f",[priceVer doubleValue]];
        NSString *priceVerde = editMerchandisePrice.text;
        //添加商品
        if ([editMerchandiseImageView.image isEqual:[UIImage imageNamed:@"no_cover"]])
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"AddGoodsPicture")];
        }
        else if ([editMerchandiseName.text isEqualToString:@""])
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"EnterGoodsName")];
        }
        else if ([editMerchandiseName.text length] > 9)
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"MaximumOfNineWords")];
        }
        else if ([priceVer length] > 9 || [priceVerde isEqualToString:@""] || ![self matchStringFormat:priceVer withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"] || [priceVer isEqualToString:@"0.00"])
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"CorrectCommodityPrices")];
        }
        else if (![self matchStringFormat:priceVerde withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"])
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"CorrectCommodityPrices")];
        }
        else
        {
            addType = NO;
            editBackgroundView.hidden = YES;
            NSData *imageData = UIImagePNGRepresentation(takePhoneImg);
            NSString *image = [self stringWithData:imageData];
            NSString *name = editMerchandiseName.text;
            NSString *price = priceVer;
            
            [request addMallDataMobileNo:[AppDelegate getUserBaseData].mobileNo icon:image title:name price:price amount:@"2"];
            
            
        }
    }
    [self.editMallCollectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mallData.mallArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MallCollectionViewCell *cell = (MallCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    MallItem *dic    = mallData.mallArr[indexPath.row];
    
    [cell.MerchandiseImage sd_setImageWithURL:[NSURL URLWithString:dic.iconurl] placeholderImage:[UIImage imageNamed:@"tick"]];
    cell.MerchandiseNameLbl.text = dic.title;
    cell.MerchandisePrice.text = dic.price;
    
    return cell;
}

//根据机型改变cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/2-20, 270);
    
}

//定义每个collectionCell 的边缘
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 15, 15, 15);//上 左 下 右
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    indexRow = indexPath.row;
    editBackgroundView.hidden = NO;
    [editMerchandiseImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[(MallItem *)mallData.mallArr[indexPath.row] iconurl]]]];
    editMerchandiseName.text = [NSString stringWithFormat:@"%@",[(MallItem *)mallData.mallArr[indexPath.row] title]];
    editMerchandisePrice.text = [NSString stringWithFormat:@"%@",[(MallItem *)mallData.mallArr[indexPath.row] price]];
}

#pragma mark - 相机

- (void)addCarema {
    //判断是否可以打开相机，模拟器此功能无法使用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = (id)self;
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls = YES;
        picker.allowsEditing = YES;  //是否可编辑
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    photoType = NO;
    //    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //得到图片
    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
    CGSize imagesize = editImage.size;
    imagesize.height = editMerchandiseImageView.frame.size.height;
    imagesize.width = editMerchandiseImageView.frame.size.height;
    //    takePhoneImg = [self getScaledImage:editImage];
    //对图片大小进行压缩--
    takePhoneImg = [self imageWithImage:editImage scaledToSize:imagesize];
    editMerchandiseImageView.image = takePhoneImg;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIImage*)getScaledImage:(UIImage*)image{
    
    //    UIImage *srcimg = image;
    //    NSLog(@"image width = %f,height = %f",srcimg.size.width,srcimg.size.height);
    CGRect rect =  CGRectMake(0, 0, editMerchandiseImageView.frame.size.width, editMerchandiseImageView.frame.size.height);//要裁剪的图片区域，按照原图的像素大小来，超过原图大小的边自动适配
    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
    //    editMerchandiseImageView.image = [UIImage imageWithCGImage:cgimg];
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
    return img;
}

//图片压缩
- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}



#pragma mark - cancelFristResponder

-(void)cancelFristResponder
{
    UIControl *backGroundControl = [[UIControl alloc] initWithFrame:
                                    CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backGroundControl.backgroundColor = [UIColor clearColor];
    [backGroundControl addTarget:self
                          action:@selector(backgroundTab)
                forControlEvents:UIControlEventTouchUpInside];
    UIControl *backGroundControl1 = [[UIControl alloc] initWithFrame:
                                     CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backGroundControl1.backgroundColor = [UIColor clearColor];
    [backGroundControl1 addTarget:self
                           action:@selector(backgroundTab)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.editBackgroundView insertSubview:backGroundControl atIndex:0];
    
}
//取消第一响应者事件
- (void)backgroundTab
{
    [editMerchandiseName resignFirstResponder];
    [editMerchandisePrice resignFirstResponder];
}

#pragma mark - 正则判断

- (BOOL)matchStringFormat:(NSString *)matchedStr withRegex:(NSString *)regex
{
    //SELF MATCHES一定是大写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [predicate evaluateWithObject:matchedStr];
}


#pragma mark - stringWithData

- (NSString *)stringWithData:(NSData *)data
{
    //获取到之后要去掉尖括号和中间的空格
    NSString *strdata = [NSString stringWithFormat:@"%@",data];
    NSMutableString *st = [NSMutableString stringWithString:strdata];
    [st deleteCharactersInRange:NSMakeRange(0, 1)];
    [st deleteCharactersInRange:NSMakeRange(st.length-1, 1)];
    NSString *imageStr = [st stringByReplacingOccurrencesOfString:@" " withString:@""];
    return imageStr;
}

#pragma mark - responseDict

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{
    if([[dict objectForKey:@"respCode"] isEqualToString:@"0000"]){
        //获取数据
        if (type == REQUEST_COMMODITYLIST)
        {
            if (getDataType == 0) {
                //            正常获取
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                editMerchandiseArr = [[dict objectForKey:@"data"] objectForKey:@"list"];
                mallData = [[MallData alloc]initWithData:editMerchandiseArr];
                
            }
            else if (getDataType == 1) {
                int index = 0;
                for (NSDictionary *DI in [[dict objectForKey:@"data"] objectForKey:@"list"]) {
                    [editMerchandiseArr insertObject:DI atIndex:index];
                    index++;
                }
                mallData = [[MallData alloc]initWithData:editMerchandiseArr];
            }
            else if (getDataType == 2)
            {
                [editMerchandiseArr addObjectsFromArray:[[dict objectForKey:@"data"] objectForKey:@"list"]];
                mallData = [[MallData alloc]initWithData:editMerchandiseArr];
            }
            //            [self.editMallCollectionView headerEndRefreshing];
            //            [self.editMallCollectionView footerEndRefreshing];
            
            [self.editMallCollectionView.header endRefreshing];
            [self.editMallCollectionView.footer endRefreshing];
            NSLog(@"获取数据回调");
            
        }
        //添加
        else if(type == REQUEST_ADDCOMMODITY)
        {
            NSLog(@"添加回调");
            if (!mallData.mallArr.count) {
                [self setUpCollection];
            }
            else
            {
                //                [self.editMallCollectionView headerBeginRefreshing];
                [self.editMallCollectionView.header endRefreshing];
            }
        }
        //删除
        else if(type == REQUEST_DELETECOMMODITY)
        {
            //        收到回调后删除
            [editMerchandiseArr removeObjectAtIndex:deleteIndex];
            [mallData.mallArr removeObjectAtIndex:deleteIndex];
            NSLog(@"%d",mallData.mallArr.count);
            if (!mallData.mallArr.count) {
                [self setUpCollection];
            }
        }
        //编辑
        else if(type == REQUEST_EDITCOMMODITY)
        {
            [mallData.mallArr[indexRow] setIconurl:[[dict objectForKey:@"data"] objectForKey:@"iconUrl"]];
            [mallData.mallArr[indexRow] setPrice:[NSString stringWithFormat:@"%@",editMerchandisePrice.text]];
            [mallData.mallArr[indexRow] setTitle:[NSString stringWithFormat:@"%@",editMerchandiseName.text]];
            [editMerchandiseArr[indexRow] setObject:[[dict objectForKey:@"data"] objectForKey:@"iconUrl"] forKey:@"iconurl"];
            [editMerchandiseArr[indexRow] setObject:[NSString stringWithFormat:@"%@",editMerchandisePrice.text] forKey:@"price"];
            [editMerchandiseArr[indexRow] setObject:[NSString stringWithFormat:@"%@",editMerchandiseName.text] forKey:@"title"];
        }
        if (mallData.mallArr.count != 0) {
            FristId = [mallData.mallArr[0] commodityID];
            LastId = [mallData.mallArr[mallData.mallArr.count-1] commodityID];
        }
        [self.editMallCollectionView reloadData];
    }
    else
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
