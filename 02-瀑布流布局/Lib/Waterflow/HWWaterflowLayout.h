//
//  HWWaterflowLayout.h
//  02-瀑布流布局
//
//  Created by apple on 14/12/27.
//  Copyright (c) 2014年 heima. All rights reserved.
//  瀑布流布局

#import <UIKit/UIKit.h>
@class HWWaterflowLayout;

@protocol HWWaterflowLayoutDelegate <NSObject>
- (CGFloat)waterflowLayout:(HWWaterflowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 *  返回四边的间距, 默认是UIEdgeInsetsMake(10, 10, 10, 10)
 */
- (UIEdgeInsets)insetsInWaterflowLayout:(HWWaterflowLayout *)waterflowLayout;
/**
 *  返回最大的列数, 默认是3
 */
- (int)maxColumnsInWaterflowLayout:(HWWaterflowLayout *)waterflowLayout;
/**
 *  返回每行的间距, 默认是10
 */
- (CGFloat)rowMarginInWaterflowLayout:(HWWaterflowLayout *)waterflowLayout;
/**
 *  返回每列的间距, 默认是10
 */
- (CGFloat)columnMarginInWaterflowLayout:(HWWaterflowLayout *)waterflowLayout;
@end

@interface HWWaterflowLayout : UICollectionViewLayout
@property (nonatomic, weak) id<HWWaterflowLayoutDelegate> delegate;
@end
