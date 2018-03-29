//
//  PersoninfoDeflutCell.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/29.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "PersoninfoDeflutCell.h"

@interface PersoninfoDeflutCell()

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end

@implementation PersoninfoDeflutCell

+ (instancetype)personinfoDeflutCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"PersoninfoDeflutCell";
    PersoninfoDeflutCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PersonInfoDeflutCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)hideBottomLine{
    self.bottomLine.hidden = YES;
}

- (void)setMdoelDict:(NSDictionary *)mdoelDict{
    _mdoelDict = mdoelDict;
    self.bottomLine.hidden = NO;
    self.leftLabel.text = mdoelDict.allKeys.firstObject;
    self.rightLabel.text = mdoelDict[mdoelDict.allKeys.firstObject];
}

@end
