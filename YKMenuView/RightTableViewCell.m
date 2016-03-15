//
//  RightTableViewCell.m
//  YKMenuView
//
//  Created by white on 15/11/6.
//  Copyright (c) 2015年 white8818. All rights reserved.
//

#import "RightTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface RightTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsQuantity;

@property (nonatomic, strong) ReserveDishModel *model;

@end

@implementation RightTableViewCell

- (IBAction)addGoodsAction:(UIButton *)sender {
    self.model.quantity += 1;
    self.goodsQuantity.text = [NSString stringWithFormat:@"%ld", (long)self.model.quantity];
    if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(cellDelegateAddGoodsQuantity:)]) {
        [self.cellDelegate cellDelegateAddGoodsQuantity:self.model];
    }
}
- (IBAction)subtractGoodsAction:(UIButton *)sender {
    if (self.model.quantity > 0) {
        self.model.quantity -= 1;
        self.goodsQuantity.text = [NSString stringWithFormat:@"%ld", (long)self.model.quantity];
        if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(cellDelegateSubtractGoodsQuantity:)]) {
            [self.cellDelegate cellDelegateSubtractGoodsQuantity:self.model];
        }
    }
}

- (void)confihureCellWithModel:(ReserveDishModel *)model {
    self.model = model;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"store_icon"]];
    self.goodsName.text = model.name;
    self.goodsPrice.text = [NSString stringWithFormat:@"%.2f元", model.price];
    self.goodsQuantity.text = [NSString stringWithFormat:@"%ld", (long)model.quantity];
}

@end
