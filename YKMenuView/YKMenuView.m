//
//  YKMenuView.m
//  YKMenuView
//
//  Created by white on 15/11/5.
//  Copyright (c) 2015年 white8818. All rights reserved.
//

#import "YKMenuView.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"

#define YKWidth self.bounds.size.width
#define YKHeight self.bounds.size.height

@interface YKMenuView ()<UITableViewDataSource, UITableViewDelegate, RightTableViewCellDelegate>
/**
 *  左边视图
 */
@property (nonatomic, strong) UITableView *leftTableView;
/**
 *  右边视图
 */
@property (nonatomic, strong) UITableView *rightTableView;
/**
 *  左边视图宽度
 */
@property (nonatomic, assign) CGFloat oldOffset;
/**
 *  当点击左边视图, 右边是否连动
 */
@property (nonatomic, assign, getter=isScrollOn) BOOL scrollOn;
/**
 *  数量
 */
@property (nonatomic, assign) NSInteger quantity;
/**
 *  价钱
 */
@property (nonatomic, assign) CGFloat price;
@end

static NSString *leftIdentifier=@"leftCell";
static NSString *rightIdentifier=@"rightCell";

@implementation YKMenuView

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.leftWidth, YKHeight)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:leftIdentifier];
        [self addSubview:self.leftTableView];
        self.quantity = 0;
        self.price = 0;
    }
    return _leftTableView;
}
- (UITableView *)rightTableView {
    if (!_rightTableView) {
        self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.leftWidth, 0, YKWidth - _leftWidth, YKHeight)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        [_rightTableView registerNib:[UINib nibWithNibName:@"RightTableViewCell" bundle:nil] forCellReuseIdentifier:rightIdentifier];
        self.oldOffset = 0;
        [self addSubview:self.rightTableView];
    }
    return _rightTableView;
}
- (void)layoutSubviews {
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    NSIndexPath *defaultIndexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [_leftTableView selectRowAtIndexPath:defaultIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark UITabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _leftTableView) {
        return 1;
    } else {
        return self.rightDatasource.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {      
        return 50;
    }
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return self.leftDatasource.count;
    } else {
        return [self.rightDatasource[section] count];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _rightTableView) {
        return 20;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _rightTableView) {
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
        headerLabel.font = [UIFont systemFontOfSize:14];
        headerLabel.text = [NSString stringWithFormat:@"  %@", self.leftDatasource[section]];
        headerLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return headerLabel;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableFooterView = [UIView new];
    if (tableView == _leftTableView) {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftIdentifier forIndexPath:indexPath];
        //设置下划线
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.bounds.size.height - 1, cell.bounds.size.width, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell addSubview:line];
        [cell configureCellWithTitle:self.leftDatasource[indexPath.row]];
        return cell;
    } else {
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightIdentifier forIndexPath:indexPath];
        cell.cellDelegate = self;
        [cell confihureCellWithModel:self.rightDatasource[indexPath.section][indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        self.scrollOn = YES;
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        if (self.rightDatasource.count > 0) {
            [self.rightTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (_rightTableView.contentOffset.y > _oldOffset) {//如果当前位移大于缓存位移，说明scrollView向上滑动
        if (!self.isScrollOn) {
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:section + 1 inSection:0];
            if (self.leftDatasource.count > 0) {
                [self.leftTableView selectRowAtIndexPath:scrollIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            }
        }
    }
    _oldOffset = _rightTableView.contentOffset.y;//将当前位移变成缓存位移
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (_rightTableView.contentOffset.y < _oldOffset) {
        if (!self.isScrollOn) {
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:section inSection:0];
            if (self.leftDatasource.count > 0) {
                [self.leftTableView selectRowAtIndexPath:scrollIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            }
        }
    }
    _oldOffset = _rightTableView.contentOffset.y;//将当前位移变成缓存位移
}
#pragma mark -- UIScrollViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ((UITableView *)scrollView == self.rightTableView) {
        //当手动滑动开始时,调用此方法
        self.scrollOn = NO;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ((UITableView *)scrollView == self.rightTableView) {
        //当点击左边视图, 右边会滚动, 此时滚动停止调用此方法
        self.scrollOn = NO;
    }
}


#pragma mark -- RightTableViewCellDelegate
//菜品数量加1
- (void)cellDelegateAddGoodsQuantity:(ReserveDishModel *)model {
    self.quantity += 1;
    self.price += model.price;
    if (self.ykDelegate && [self.ykDelegate respondsToSelector:@selector(YKMenuViewDelegateChangeGoodsQuantity:price:)]) {
        [self.ykDelegate YKMenuViewDelegateChangeGoodsQuantity:[NSString stringWithFormat:@"%ld", (long)self.quantity] price:self.price];
    }
}
//菜品数量减1
- (void)cellDelegateSubtractGoodsQuantity:(ReserveDishModel *)model {
    self.quantity -= 1;
    self.price -= model.price;
    if (self.ykDelegate && [self.ykDelegate respondsToSelector:@selector(YKMenuViewDelegateChangeGoodsQuantity:price:)]) {
        [self.ykDelegate YKMenuViewDelegateChangeGoodsQuantity:[NSString stringWithFormat:@"%ld", (long)self.quantity] price:self.price];
    }
}

@end



















