//
//  DeviceTypeCell.m
//  ZXProject
//
//  Created by Me on 2018/4/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "DeviceTypeCell.h"
#import <UIImageView+WebCache.h>
#import "NetworkConfig.h"

@interface DeviceTypeCell()

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation DeviceTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}


+ (instancetype)deviceTypeCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"DeviceTypeCell";
    DeviceTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DeviceTypeCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)setModelDict:(NSDictionary *)modelDict{
    _modelDict = modelDict;
    self.nameLabel.text = modelDict[@"dataname"];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:[NSString stringWithFormat:@"/hjwulian/%@",modelDict[@"icon"]]]]];
}

- (void)setIndex:(int)index{
    _index = index;
    self.indexLabel.text = [NSString stringWithFormat:@"%zd",index];
}

@end
