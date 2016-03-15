//
//  YKMenuView.h
//  YKMenuView
//
//  Created by white on 15/11/5.
//  Copyright (c) 2015年 white8818. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKMenuView;
@protocol YKMenuViewDelegate <NSObject>

- (void)YKMenuViewDelegateChangeGoodsQuantity:(NSString *)quantity
                                  price:(CGFloat)price;

@end

@interface YKMenuView : UIView

@property (nonatomic, assign) id<YKMenuViewDelegate> ykDelegate;
/**
 *  左边条目的数据源
 */
@property (nonatomic, strong) NSMutableArray *leftDatasource;
/**
 *  右边视图的数据源
 */
@property (nonatomic, strong) NSMutableArray *rightDatasource;
/**
 *  左边视图宽度
 */
@property (nonatomic, assign) CGFloat leftWidth;


@end
