//
//  UserViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/9.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)clickback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView *btnview = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5, 7, 30, 30);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btnview addSubview:btn];
    [btn addTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btnview];
    self.navigationItem.leftBarButtonItem = bar;

    // Do any additional setup after loading the view.
    
    
    
    UIButton *logoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutbtn.frame = CGRectMake(20, 450, SCREEN_WIDTH-40, 40);
    [logoutbtn setTitle:@"安全退出" forState:UIControlStateNormal];
    logoutbtn.backgroundColor = [UIColor redColor];
    [logoutbtn addTarget:self action:@selector(clicklogout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutbtn];
    
}
- (void)clicklogout{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"退出后下次需要重新登录" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *centain = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Manager remove:@"username"];
        [Manager remove:@"password"];
        [Manager remove:@"msg"];
        LoginViewController *login = [[LoginViewController alloc]init];
        login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:login animated:YES completion:nil];
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:centain];
    [alert addAction:cancle];
    
    [self presentViewController:alert animated:YES completion:nil];
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
