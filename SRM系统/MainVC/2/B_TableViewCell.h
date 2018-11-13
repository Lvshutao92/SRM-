//
//  B_TableViewCell.h
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/7.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface B_TableViewCell : UITableViewCell
@property(nonatomic, retain)UILabel *nameLable;//用来显示联系人姓名
@property(nonatomic, retain)UILabel *phoneNumberLable;//用来显示联系人电话号码

@property(nonatomic, retain)UIButton *btn1;
@property(nonatomic, retain)UIButton *btn2;

@end

NS_ASSUME_NONNULL_END
