//
//  ViewController.m
//  02-瀑布流布局
//
//  Created by apple on 14/12/27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "ViewController.h"
#import "HWWaterflowLayout.h"
#import "HWShopCell.h"
#import "HWShop.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, HWWaterflowLayoutDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;
@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (!_shops) {
        self.shops = [[NSMutableArray alloc] init];
    }
    return _shops;
}

static NSString * const CellId = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化数据
    [self.shops addObjectsFromArray:[HWShop objectArrayWithFilename:@"1.plist"]];
    
    // 创建布局
    HWWaterflowLayout *layout = [[HWWaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"HWShopCell" bundle:nil] forCellWithReuseIdentifier:CellId];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 添加刷新控件
//    [self.collectionView addHeaderWithCallback:^{
//        NSLog(@"进入下拉刷新状态");
//    }];
//    [self.collectionView addFooterWithCallback:^{
//        NSLog(@"进入shang拉刷新状态");
//    }];
    [self.collectionView addHeaderWithTarget:self action:@selector(loadNewShops)];
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreShops)];
}

- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *newShops = [HWShop objectArrayWithFilename:@"2.plist"];
        [self.shops insertObjects:newShops atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newShops.count)]];
        [self.collectionView reloadData];
        
        // stop refresh
        [self.collectionView headerEndRefreshing];
    });
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *newShops = [HWShop objectArrayWithFilename:@"3.plist"];
        [self.shops addObjectsFromArray:newShops];
        [self.collectionView reloadData];
        
        // stop refresh
        [self.collectionView footerEndRefreshing];
    });
}

#pragma mark - <HWWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(HWWaterflowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    HWShop *shop = self.shops[indexPath.item];
    return shop.h * itemWidth / shop.w;
}

//- (UIEdgeInsets)insetsInWaterflowLayout:(HWWaterflowLayout *)waterflowLayout
//{
//    return UIEdgeInsetsMake(30, 30, 30, 30);
//}

//- (int)maxColumnsInWaterflowLayout:(HWWaterflowLayout *)waterflowLayout
//{
//    return 2;
//}

//- (CGFloat)rowMarginInWaterflowLayout:(HWWaterflowLayout *)waterflowLayout
//{
//    return 30;
//}
//
//- (CGFloat)columnMarginInWaterflowLayout:(HWWaterflowLayout *)waterflowLayout
//{
//    return 50;
//}

#pragma mark - <UICollectionViewDataSource>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HWShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
