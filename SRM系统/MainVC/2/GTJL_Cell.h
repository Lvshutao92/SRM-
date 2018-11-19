//
//  GTJL_Cell.h
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/16.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTJL_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgview;


@property (weak, nonatomic) IBOutlet UIView *topview;

@property (weak, nonatomic) IBOutlet UILabel *lab1;

@property (weak, nonatomic) IBOutlet UILabel *lab2;


@property (weak, nonatomic) IBOutlet UILabel *lab3;

@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *lab6;

@property (weak, nonatomic) IBOutlet UILabel *lab7;
@property (weak, nonatomic) IBOutlet UILabel *lab8;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultHeight;


@end

NS_ASSUME_NONNULL_END
