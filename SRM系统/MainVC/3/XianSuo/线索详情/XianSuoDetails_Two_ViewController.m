//
//  XianSuoDetails_Two_ViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/15.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "XianSuoDetails_Two_ViewController.h"

@interface XianSuoDetails_Two_ViewController ()

@end

@implementation XianSuoDetails_Two_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"-----%@",[Manager sharedManager].idXianSuoString);
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
