//
//  HWShopCell.m
//  02-瀑布流布局
//
//  Created by apple on 14/12/27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWShopCell.h"
#import "HWShop.h"
#import "UIImageView+WebCache.h"

@interface HWShopCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation HWShopCell

- (void)setShop:(HWShop *)shop
{
    _shop = shop;
    
    self.priceLabel.text = shop.price;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
}

@end
