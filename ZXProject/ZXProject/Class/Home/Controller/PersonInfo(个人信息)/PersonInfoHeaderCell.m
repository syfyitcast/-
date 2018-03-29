//
//  PersonInfoHeaderCell.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/29.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "PersonInfoHeaderCell.h"
#import <UIImageView+WebCache.h>

@interface PersonInfoHeaderCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;


@end

@implementation PersonInfoHeaderCell

+ (instancetype)personInfoHeaderCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"PersonInfoHeaderCell";
    PersonInfoHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PersonInfoHeaderCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)setUrl:(NSString *)url{
    _url = url;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"personInfoIcon"]];
    
}


@end
