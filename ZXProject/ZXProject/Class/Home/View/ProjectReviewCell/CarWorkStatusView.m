//
//  CarWorkStatusView.m
//  ZXProject
//
//  Created by Me on 2018/5/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "CarWorkStatusView.h"
#import <UIImageView+WebCache.h>
#import "NetworkConfig.h"

@interface CarWorkStatusView()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;



@end

@implementation CarWorkStatusView

+ (instancetype)carWorkStatusView{
    CarWorkStatusView *view = [[NSBundle mainBundle] loadNibNamed:@"CarWorkStatus" owner:nil options:nil].lastObject;
    return view;
}


- (void)setModelDict:(NSDictionary *)modelDict{
    _modelDict = modelDict;
    NSURL *url = [NSURL URLWithString:[[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:modelDict[@"photourl"]]];
    [self.iconView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}


@end
