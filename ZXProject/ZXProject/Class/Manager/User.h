//
//  User.h
//  ZXProject
//
//  Created by Me on 2018/3/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *accountid;//账号id
@property (nonatomic, copy) NSString *employerid;//职员id
@property (nonatomic, copy) NSString *accid;//语音账号id
@property (nonatomic, copy) NSString *acctoken;//语音token
@property (nonatomic, copy) NSString *acctname;//语言账号名字
@property (nonatomic, copy) NSString *projectids;//项目id
@property (nonatomic, strong) NSArray *project_ids;
@property (nonatomic, copy) NSString *employername;//职员姓名f
@property (nonatomic, copy) NSString *loginname;//登录账号
@property (nonatomic, copy) NSString *userrank;//职位
@property (nonatomic, copy) NSString *photourl;//头像图片url
@property (nonatomic, copy) NSString *mobileno;//手机号码
@property (nonatomic, copy) NSString *workno;//工号
@property (nonatomic, copy) NSString *companyname;//所属机构
@property (nonatomic, copy) NSString *gender;//性别
@property (nonatomic, copy) NSString *usertoken;//usertoken

+ (instancetype)userWithDict:(NSDictionary *)dict;


@end
