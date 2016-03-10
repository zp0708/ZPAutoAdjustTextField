# ZPAutoAdjustTextField
可以简单调节位置的textfield

###### 导入文件
<pre><code>
#import "ViewController.h"
#import "ZPAutoAdjustTextField.h"
#import "UIView+Extension.h"
</code></pre>

###### 使用方法

<pre><code>
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
        field.verifyType = CustomTextFieldTextFormMobile;
        field.textType = CustomTextFieldToolbarTypePreviousNextCancelEnsure;
    }

    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)customTextFieldShouldBeginEditing:(ZPAutoAdjustTextField *)textField
{
    [textField adjustTextFieldFrameWhenBeginEdtingWithView:self.view];
    return YES;
}

- (NSArray *)allTextFieldsWithCustomTextField:(ZPAutoAdjustTextField *)textField{
    return _fieldArr;
}
</code></pre>

![](https://github.com/NewUnsigned/ZPAutoAdjustTextField/blob/master/ZPAutoAdjustTextField/2015-11-06%2014_23_43.gif)
