//
//  Model.h
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/9.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject
//-------公有线索
@property(nonatomic,strong)NSString *customerShortName;
@property(nonatomic,strong)NSString *customerFullName;
@property(nonatomic,strong)NSString *customerIndustry;

@property(nonatomic,strong)NSString *customerScale;

@property(nonatomic,strong)NSString *customerProvinceName;
@property(nonatomic,strong)NSString *customerCityName;
@property(nonatomic,strong)NSString *customerDistrictName;
@property(nonatomic,strong)NSString *customerAddress;


@property(nonatomic,strong)NSString *createPersonName;

@property(nonatomic,strong)NSString *contactPersonNum;

@property(nonatomic,strong)NSString *contactsCommunicateNum;

@property(nonatomic,strong)NSString *leadSource;

@property(nonatomic,strong)NSString *leadNo;

@property(nonatomic,strong)NSString *existDays;

@property(nonatomic,strong)NSString *leadCreateDate;

@property(nonatomic,strong)NSString *id;

@property(nonatomic,strong)NSString *leadGetDate;
@property(nonatomic,strong)NSString *customerProvinceCode;
@property(nonatomic,strong)NSString *customerCityCode;
@property(nonatomic,strong)NSString *customerDistrictCode;
@property(nonatomic,strong)NSString *customerIntroduce;

@property(nonatomic,strong)NSString *followPersonName;
@property(nonatomic,strong)NSString *followUserId;
@property(nonatomic,strong)NSString *realName;
@property(nonatomic,strong)NSString *personName;
//
@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)NSString *label;
@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *birthday;

@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *mainPerson;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *position;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *wechat;



@property(nonatomic,strong)NSString *communicateFile;
@property(nonatomic,strong)NSString *communicateResult;
@property(nonatomic,strong)NSString *communicateStage;
@property(nonatomic,strong)NSString *communicateTime;
@property(nonatomic,strong)NSString *communicateType;
@property(nonatomic,strong)NSString *contactsPersonId;
@property(nonatomic,strong)NSString *contactsPersonName;
@property(nonatomic,strong)NSString *createTime;






@end

NS_ASSUME_NONNULL_END



