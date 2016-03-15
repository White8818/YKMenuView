//
//  RightTableViewCell.h
//  YKMenuView
//
//  Created by white on 15/11/6.
//  Copyright (c) 2015年 white8818. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReserveDishModel.h"

@class RightTableViewCell;
@protocol RightTableViewCellDelegate <NSObject>

- (void)cellDelegateAddGoodsQuantity:(ReserveDishModel *)model;
- (void)cellDelegateSubtractGoodsQuantity:(ReserveDishModel *)model;

@end

@interface RightTableViewCell : UITableViewCell

@property (nonatomic, assign) id<RightTableViewCellDelegate> cellDelegate;

- (void)confihureCellWithModel:(ReserveDishModel *)model;

@end
