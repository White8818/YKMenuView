//
//  LeftTableViewCell.m
//  Pugongying
//
//  Created by white on 15/11/17.
//  Copyright (c) 2015年 white8818. All rights reserved.
//

#import "LeftTableViewCell.h"

@interface LeftTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LeftTableViewCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, self.contentView.bounds.size.width - 3, self.contentView.bounds.size.height)];
        _titleLabel.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:245/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)configureCellWithTitle:(NSString *)title {
    self.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:245/255.0 alpha:1.0];
    //设置标题
    self.titleLabel.text = title;
    //设置选中的视图
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3, self.bounds.size.height)];
    backLabel.backgroundColor = appointColor;
    self.selectedBackgroundView = [UIView new];
    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.selectedBackgroundView addSubview:line];
    [self.selectedBackgroundView addSubview:backLabel];
}


@end
