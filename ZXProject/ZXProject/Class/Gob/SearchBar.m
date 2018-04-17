//
//  SearchBar.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/17.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "SearchBar.h"
#import "GobHeaderFile.h"
#import <Masonry.h>

@interface SearchBar()

@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, strong) void(^block)(NSString *match);
@property (nonatomic, strong) UIView *searchBgView;
@property (nonatomic, strong) UIImageView *searchImageView;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) UIButton *searchBtn;

@end

@implementation SearchBar

+ (instancetype)zx_SearchBarWithPlaceHolder:(NSString *)placeHolder andFrame:(CGRect)frame andSearchBlock:(void(^)(NSString *macth))block{
    SearchBar *bar = [[SearchBar alloc] initWithFrame:frame];
    bar.backgroundColor = WhiteColor;
    bar.block = block;
    bar.placeHolder = placeHolder;
    return bar;
}

- (void)setSubViews{
     __weak typeof(self)  weakself = self;
    [self addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(15);
        make.centerY.equalTo(weakself.mas_centerY);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(40);
    }];
    [self addSubview:self.searchBgView];
    [self.searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(15);
        make.centerY.equalTo(weakself.mas_centerY);
        make.right.equalTo(weakself.searchBtn.mas_left).offset(-20);
        make.height.mas_equalTo(50);
    }];
    [self.searchBgView addSubview:self.searchImageView];
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.searchBgView.mas_left).offset(5);
        make.centerY.equalTo(weakself.searchBgView.mas_centerY);
        make.size.mas_equalTo(weakself.searchImageView.image.size);
    }];
}

#pragma mark - setter && getter

- (UIButton *)searchBtn{
    if (_searchBtn == nil) {
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn  setTitle:@"搜索" forState:UIControlStateNormal];
        _searchBtn.backgroundColor = BTNBackgroudColor;
        _searchBtn.layer.cornerRadius = 4;
        [_searchBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    }
    return _searchBtn;
}

- (UIView *)searchBgView{
    if (_searchBgView == nil) {
        _searchBgView = [[UIView alloc] init];
        _searchBgView.backgroundColor = UIColorWithFloat(245);
        _searchBgView.layer.cornerRadius = 5;
        _searchBgView.layer.borderWidth = 1;
        _searchBgView.layer.borderColor = UIColorWithFloat(200).CGColor;
    }
    return _searchBgView;
}

- (UIImageView *)searchImageView{
    if (_searchImageView == nil) {
        _searchImageView = [[UIImageView alloc] init];
        _searchImageView.image = [UIImage imageNamed:@"searchBarIcon"];
    }
    return _searchImageView;
}

- (UITextField *)searchField{
    if (_searchField == nil) {
        _searchField = [[UITextField alloc] init];
        _searchField.placeholder = self.placeHolder;
        _searchField.textColor = UIColorWithFloat(98);
    }
    return _searchField;
}

@end
