//
//  WorkTaskCell.m
//  ZXProject
//
//  Created by Me on 2018/3/4.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskCell.h"
#import "GobHeaderFile.h"
#import "NetworkConfig.h"
#import <UIImageView+WebCache.h>

@interface WorkTaskCell()

@property (weak, nonatomic) IBOutlet UIImageView *workTaskIcon;
@property (weak, nonatomic) IBOutlet UILabel *personName;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;


@end;

@implementation WorkTaskCell

+ (instancetype)workTaskCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"WorkTaskCell";
    WorkTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"WorkTaskCell" owner:nil options:nil].lastObject;
        cell.typeLabel.layer.cornerRadius = 6;
        cell.typeLabel.clipsToBounds = YES;
    }
    return cell;
}

- (void)setModel:(WorkTaskModel *)model{
    _model = model;
    self.personName.text =  [NSString stringWithFormat:@"发起人:%@", model.solveusername];
    self.desLabel.text = [NSString stringWithFormat:@"说明:%@",model.eventdescription];
    self.updateLabel.text = [NSString stringWithFormat:@"更新:%@",model.occurtime];
    self.adressLabel.text = model.positionaddress;
    if ([model.eventstatus isEqualToString:@"2"]) {
        self.typeLabel.text = @"已完成";
        self.typeLabel.backgroundColor = BTNBackgroudColor;
    }else if ([model.eventstatus isEqualToString:@"99"]){
        self.typeLabel.text = @"草稿";
        self.typeLabel.backgroundColor = UIColorWithRGB(59, 127, 159);
    }else if ([model.eventstatus isEqualToString:@"0"]){
        self.typeLabel.text = @"未完成";
        self.typeLabel.backgroundColor = [UIColor redColor];
    }
    
    [self.workTaskIcon sd_setImageWithURL:[NSString stringWithFormat:@"%@%@",[NetworkConfig sharedNetworkingConfig].baseUrl,model.photoUrls.firstObject] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

@end
