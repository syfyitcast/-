//
//  NSString+boundSize.h
//  Nexpaq NewUI Project
//
//  Created by Jordan Zhou on 16/9/20.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (boundSize)

- (CGSize)boundSizeWithFont:(UIFont *)font;

- (CGSize)boudSizeWithFont:(UIFont *)font andMaxSize:(CGSize)size;

@end
