//
//  HWShop.h
//  02-瀑布流布局
//
//  Created by apple on 14/12/27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWShop : NSObject
/** 宽度 */
@property (nonatomic, assign) CGFloat w;
/** 高度 */
@property (nonatomic, assign) CGFloat h;
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 图片的url地址 */
@property (nonatomic, copy) NSString *img;
@end
