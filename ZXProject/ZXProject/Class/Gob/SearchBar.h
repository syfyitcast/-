//
//  SearchBar.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/17.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    SearchBarTypeNormal = 0,
    SearchBarTypeCategory,
}SearchBarType;

@interface SearchBar : UIView

+ (instancetype)zx_SearchBarWithPlaceHolder:(NSString *)placeHolder andFrame:(CGRect)frame andType:(SearchBarType)type andSearchBlock:(void(^)(NSString *macth))block;


@end
