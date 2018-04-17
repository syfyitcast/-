//
//  EventsHomeCell.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/22.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "EventsHomeCell.h"

@interface EventsHomeCell()

@property (weak, nonatomic) IBOutlet UILabel *createName;
@property (weak, nonatomic) IBOutlet UILabel *isNeedCar;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeCount;

@end

@implementation EventsHomeCell

+ (instancetype)eventsHomeCellWithTabelView:(UITableView *)tableView{
    static NSString *ID = @"EventsHomeCell";
    EventsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"EventsHomeCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)setModel:(eventsMdoel *)model{
    _model = model;
    self.createName.text = model.createemployername;
    self.isNeedCar.text = [model.isvehneed intValue]?@"需要派车":@"无需派车";
    self.adress.text = model.eventdescription;
    self.timeLabel.text = model.occourtimeString;
    NSString *text = [NSString stringWithFormat:@"计时:  %@",model.timeCount];
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:text];
    [mString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[text rangeOfString:model.timeCount]];
    self.timeCount.attributedText = mString;
}


@end
