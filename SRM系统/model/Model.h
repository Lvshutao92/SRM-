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


//
@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)NSString *label;

//-------------私有线索


//@property(nonatomic,strong)NSString *leadCreateDate;
//@property(nonatomic,strong)NSString *leadCreateDate;
//@property(nonatomic,strong)NSString *leadCreateDate;
//@property(nonatomic,strong)NSString *leadCreateDate;
//@property(nonatomic,strong)NSString *leadCreateDate;
//@property(nonatomic,strong)NSString *leadCreateDate;













@end

NS_ASSUME_NONNULL_END



