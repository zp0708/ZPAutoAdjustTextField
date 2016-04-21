//
//  SecondViewController.m
//  ZPAutoAdjustTextField
//
//  Created by 融通汇信 on 15/11/9.
//  Copyright © 2015年 融通汇信. All rights reserved.
//

#import "SecondViewController.h"
#import "ZPAutoAdjustTextField.h"
#import "UIView+Extension.h"

@interface SecondViewController () <CustomTextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *fieldArr;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"用户名",@"密码",@"手机",@"邮箱",@"验证码",@"年龄",@"性别",@"省",@"市"];
    for (NSInteger i = 0; i < titleArr.count; i++) {
        ZPAutoAdjustTextField *field = [[ZPAutoAdjustTextField alloc]initWithFrame:CGRectMake(10, 50 * (i + 1) + 40, self.view.width - 20,30)];
        [self.view addSubview:field];
        [self.fieldArr addObject:field];
        field.backgroundColor = [UIColor orangeColor];
        field.placeholder   = titleArr[i];
        field.font   = [UIFont systemFontOfSize:14];
        field.customDelegate = self;
        field.delegate = self;
        field.textType = CustomTextFieldToolbarTypePreviousNextCancelEnsure;
    }

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)customTextField:(ZPAutoAdjustTextField *)textField previousBarButtonItemDidClicked:(UIBarButtonItem *)item
{
    NSLog(@"%s",__func__);
}

- (void)customTextField:(ZPAutoAdjustTextField *)textField nextBarButtonItemDidClicked:(UIBarButtonItem *)item
{
    NSLog(@"%s",__func__);
}

- (NSArray *)allTextFieldsWithCustomTextField:(ZPAutoAdjustTextField *)textField{
    return _fieldArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)fieldArr{
    if (_fieldArr == nil) {
        _fieldArr = [NSMutableArray array];
    }
    return _fieldArr;
}

@end
