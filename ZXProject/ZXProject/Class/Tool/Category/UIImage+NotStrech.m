//
//  UIImage+NotStrech.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/11.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "UIImage+NotStrech.h"

@implementation UIImage (NotStrech)

+ (instancetype)imageNotStrechWithNamed:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    CGFloat left = image.size.width * 0.5;
    CGFloat top = image.size.height * 0.5;
    [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
    return image;
}

@end
