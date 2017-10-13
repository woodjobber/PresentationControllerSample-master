//
//  FirstViewController.m
//  PresentationControllerSample
//
//  Created by Shinichiro Oba on 2014/10/08.
//  Copyright (c) 2014年 bricklife.com. All rights reserved.
//
// NSArray *ab = [original valueForKeyPath:@"@distinctUnionOfObjects.self"];
//NSLog(@"%@",ab);

#import "FirstViewController.h"
#import "GCDObject.h"
#import "NSArray+Extra.h"
#import "JMLabel+Action.h"
#import "PCSSubView.h"
#import "ThirdViewController.h"
#import "CALayerLabel.h"
#import "KACollectionViewCell.h"
@interface FirstViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet JMLabel *label;
@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *lineImageVeiw;
@property (weak, nonatomic) IBOutlet UIImageView *modifyImageView;


@end
typedef UIImage * _Nullable (^asimagenode_modification_block_t)(UIImage *image);

 asimagenode_modification_block_t ASImageNodeTintColorModificationBlock(UIColor *color)
{
    return ^(UIImage *originalImage) {
        UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, originalImage.scale);
        
        // Set color and render template
        [color setFill];
        UIImage *templateImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [templateImage drawAtPoint:CGPointZero];
        
        UIImage *modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // if the original image was stretchy, keep it stretchy
        if (!UIEdgeInsetsEqualToEdgeInsets(originalImage.capInsets, UIEdgeInsetsZero)) {
            modifiedImage = [modifiedImage resizableImageWithCapInsets:originalImage.capInsets resizingMode:originalImage.resizingMode];
        }
        
        return modifiedImage;
    };
}
@implementation FirstViewController
{
    PCSSubView *sc ;
    CATextLayer *textLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
#if 0
    NSMutableArray *original = @[].mutableCopy;
    size_t group = 1;
    for (size_t i = 0; i <500; i++) {
        if (i % 10 != 0) {
            GCDObject *ob1 = [GCDObject new];
            ob1.userId = @(group).stringValue;
            ob1.name = @(i).stringValue;
            [original addObject:ob1];
        }else {
            group ++;
            GCDObject *ob1 = [GCDObject new];
            ob1.userId = @(i).stringValue;
            ob1.name = @(i).stringValue;
            [original addObject:ob1];
        }
    }
    CFAbsoluteTime begin1 = CFAbsoluteTimeGetCurrent();
    NSLog(@"%ld",original.distinct.count);
    CFAbsoluteTime end1 = CFAbsoluteTimeGetCurrent();

    CFAbsoluteTime begin2 = CFAbsoluteTimeGetCurrent();
    NSLog(@"%ld",original.distinctOrderedOfObjects.count);
    CFAbsoluteTime end2 = CFAbsoluteTimeGetCurrent();

    CFAbsoluteTime begin3 = CFAbsoluteTimeGetCurrent();
    NSLog(@"%ld",original.distinctUnionOfObjects.count);
    CFAbsoluteTime end3 = CFAbsoluteTimeGetCurrent();
    
    NSLog(@"\n - distinct:%lf\n - distinctOrderedOfObjects:%lf\n - distinctUnionOfObjects:%lf",end1- begin1, end2-begin2,end3-begin3);
    //
    id objects = @[@{@"key": @{@"color": @"blue"}},
                   @{@"key": @{@"color": @"red"}},
                   @{@"key": @{@"color": @"green"}},
                   @{@"key": @{@"color": @"blue"}},
                   @{@"key": @{@"color": @"red"}},
                   @{@"key": @{@"color": @"green"}},
                   @"notacolor"];
    NSLog(@"%@",[objects valueForKeyPath:@"@distinctUnionOfNonNullObjects.key.color"]);
    CFAbsoluteTime begin4= CFAbsoluteTimeGetCurrent();
    id o = [original valueForKeyPath:@"@unionOfNonNullArrays.models"];
    CFAbsoluteTime end4 = CFAbsoluteTimeGetCurrent();
    NSLog(@"%lf- ",end4 - begin4);
    NSNumber * numb = [o valueForKeyPath:@"@count"];
    if ([numb respondsToSelector:@selector(integerValue)]) {
        NSLog(@"%@", numb);
    }

//    NSDictionary *dic = @{
//                          @"key": @[
//                                  @{@"num": @1},
//                                  @{@"num": @34},
//                                  ]
//                          };
//
//    NSLog(@"%@", [dic valueForKeyPath:@"key.@sum.num"]);
//
//

    [self.label addActionHandler:^{
        NSLog(@"action...");
    }];
#endif
    NSLog(@"%@",[NSValue valueWithCGRect:[UIApplication sharedApplication].statusBarFrame]);
    
#if 0
    NSArray *originalArray = @[@"1",@"2",@"3",@"4",@"4", @"21",@"22",@"23",@"24",@"25", @"11",@"12",@"13",@"14",@"15", @"16",@"17",@"18"];
    NSMutableArray *originalMutableArray = [NSMutableArray arrayWithArray:originalArray];
    
    NSArray *currentPageArray = [originalMutableArray subarrayWithRange:NSMakeRange(originalArray.count-10, 2)];
    NSInteger location = [originalMutableArray indexOfObject:currentPageArray.firstObject];
    NSArray *newArray = @[@"a",@"b",@"c"];
    NSInteger length = currentPageArray.count;
    NSRange range = NSMakeRange(location, length);
    if (NSLocationInRange(location, NSMakeRange(0, originalArray.count))) {
        [originalMutableArray replaceObjectsInRange:range withObjectsFromArray:newArray];
    }else {
        [originalMutableArray addObjectsFromArray:newArray];
    }
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:originalMutableArray];
    NSLog(@"%@",orderedSet.array);
#endif
//    [self setStatusBarBackgroundColor:[UIColor clearColor]];
//    [self setNeedsStatusBarAppearanceUpdate];
//    //设置导航条透明度
//    self.navigationController.navigationBar.translucent = YES;//透明
//    //图标颜色为黑色
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
//    //导航栏背景颜色
//    //[self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//    //导航条下面的黑线
//    self.navigationController.navigationBar.clipsToBounds = NO;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    if (@available(iOS 11.0, *)) {
//        self.navigationController.navigationBar.prefersLargeTitles = NO;
//    } else {
//        // Fallback on earlier versions
//    }
//    if (@available(iOS 11.0, *)) {
//        self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
//    } else {
//        // Fallback on earlier versions
//    }
//    if (@available(iOS 11.0, *)) {
//        self.view.insetsLayoutMarginsFromSafeArea = NO;
//        self.collectionView.insetsLayoutMarginsFromSafeArea = NO;
//        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//
//    } else {
//        // Fallback on earlier versions
//    }
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.edgesForExtendedLayout = UIRectEdgeAll;
//    if (@available(iOS 10.0, *)) {
//        NSLog(@"我是 ceshi..");
//    } else {
//        // Fallback on earlier versions
//    }
//    if (@available(iOS 11.0, *)) {
//
//    } else {
//        // Fallback on earlier versions
//    }
//    if (@available(iOS 11.0, *)) {
//        NSLog(@"%@",[NSValue valueWithUIEdgeInsets:self.view.safeAreaInsets]);
//    } else {
//        // Fallback on earlier versions
//    }
//    self.navigationController.navigationBarHidden = YES;
//
//    sc = [[PCSSubView alloc] initWithFrame:CGRectMake(100, 100, 110, 110)];
//    [self.view addSubview:sc];
//    sc.backgroundColor = [UIColor redColor];
    
    
//    self.lineImageVeiw.image = [self imageWithColor:[UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1]];
//    self.lineImageVeiw.layer.shadowColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
//    self.lineImageVeiw.layer.shadowOpacity = 0.5;
//    self.lineImageVeiw.layer.shadowOffset = CGSizeMake(0, -1);
    
//    UIImage *image = [UIImage imageNamed:@"问答"];
//    asimagenode_modification_block_t block_t = ASImageNodeTintColorModificationBlock([UIColor redColor]);
//    if (block_t) {
//       self.modifyImageView.image = block_t(image);
//    }
    
    
    
}

- (UIImage *)imageWithColor:(UIColor *)color { // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
    //开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;

}
    
- (UIImage *)imageWithImage:(UIImage *)originalImage color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, originalImage.scale);
    
    // Set color and render template
    [color setFill];
    UIImage *templateImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [templateImage drawAtPoint:CGPointZero];
    
    UIImage *modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // if the original image was stretchy, keep it stretchy
    if (!UIEdgeInsetsEqualToEdgeInsets(originalImage.capInsets, UIEdgeInsetsZero)) {
        modifiedImage = [modifiedImage resizableImageWithCapInsets:originalImage.capInsets resizingMode:originalImage.resizingMode];
    }
    
    return modifiedImage;
}
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]){
        statusBar.backgroundColor = color;
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeMake(12, 36);
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(12, 36);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
        minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {

    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
     return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger width = [UIScreen mainScreen].bounds.size.width / 4.0;
    return CGSizeMake(width, 74.0f);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *resuableView = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:@"headerID"
                                                                 forIndexPath:indexPath];

    }else {
        resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:@"footerID"
                                                                 forIndexPath:indexPath];
       
    }
    
    return resuableView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 100;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 120;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];

   
    cell.label.text = @"2";
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}
- (IBAction)close:(UIStoryboardSegue *)segue {
}
- (IBAction)presentvc:(id)sender {
//    ThirdViewController * vc =[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ThirdViewController"];
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    vc.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//    [self.navigationController presentViewController:vc animated:YES completion:^{
//
//    }];
    [self.collectionView reloadData];
}


@end
