//
//  NewsReadListCell.m
//  ZXProject
//
//  Created by Me on 2018/5/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NewsReadListCell.h"

@interface NewsReadListCell()

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation NewsReadListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(NSDictionary *)model{
    _model = model;
    self.nameLabel.text = model[@"employername"];
    long readTime = [model[@"readtime"] longLongValue] /  1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:readTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *timeStr = [formatter stringFromDate:date];
    self.timeLabel.text = timeStr;
    self.statusLabel.text = @"已阅";
}

- (void)setIndex:(int)index{
    _index = index;
    self.indexLabel.text = [NSString stringWithFormat:@"%zd",index];
}

+ (instancetype)newsReadListCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"NewsReadListCell";
    NewsReadListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsReadListCell" owner:nil options:nil].lastObject;
    }
    return cell;
}


@end
