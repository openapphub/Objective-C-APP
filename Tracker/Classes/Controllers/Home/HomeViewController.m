//
//  HomeViewController.m
//  Tracker
//
//  Created by jin xm on 2025/1/14.
//

#import <QMUIKit/QMUIKit.h>
#import "HomeViewController.h"
#import "DetailViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) QMUIEmptyView *emptyView;


@property (nonatomic, strong) QMUISegmentedControl *segmentedControl; // 支出/收入选择
@property (nonatomic, strong) UIDatePicker *datePicker; // 日期选择器
@property (nonatomic, strong) QMUITextField *amountTextField; // 金额输入框
@property (nonatomic, strong) QMUISegmentedControl *typeSegmentedControl; // 类型选择

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    NSString *model = [QMUIHelper deviceModel];
    NSLog(@"设备型号: %@", model);
    NSString *name = [QMUIHelper deviceName];
    NSLog(@"设备名称: %@", name);
    if ([QMUIHelper isIPhone]) {
        NSLog(@"当前设备是 iPhone");
    }
    
    // 创建按钮
    QMUIButton *button = [[QMUIButton alloc] initWithFrame:CGRectMake(self.view.qmui_width - 80, self.view.qmui_height - 180, 60, 60)];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"记账" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)showActionSheet {
    // 创建 QMUIAlertController
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:nil message:nil preferredStyle:QMUIAlertControllerStyleActionSheet];
    
    // 添加“记账”按钮
    QMUIAlertAction *accountingAction = [QMUIAlertAction actionWithTitle:@"记账" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        [self showAccountingSheet];
    }];
    [alertController addAction:accountingAction];
    
    // 添加“记事”按钮（置灰不可用）
    QMUIAlertAction *noteAction = [QMUIAlertAction actionWithTitle:@"记事" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        // 这里不会执行，因为按钮被禁用了
    }];
    noteAction.enabled = NO; // 禁用按钮
    [alertController addAction:noteAction];
    
    // 添加“取消”按钮
    QMUIAlertAction *cancelAction = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    // 显示 ActionSheet
    [alertController showWithAnimated:YES];
}
- (void)showAccountingSheet {
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    modalViewController.contentViewMargins = UIEdgeInsetsMake(20, 20, 20, 20);
    modalViewController.maximumContentViewWidth = CGRectGetWidth(self.view.bounds) - 40;
    modalViewController.contentView.backgroundColor = [UIColor whiteColor];
    modalViewController.contentView.layer.cornerRadius = 10; // 圆角
    modalViewController.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    modalViewController.contentView.layer.shadowOpacity = 0.1; // 阴影
    modalViewController.contentView.layer.shadowOffset = CGSizeMake(0, 2);
    modalViewController.contentView.layer.shadowRadius = 4;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, modalViewController.maximumContentViewWidth, 600)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    // 标题栏
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(contentView.bounds), 50)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(headerView.bounds) - 40, CGRectGetHeight(headerView.bounds))];
    titleLabel.text = @"记账";
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLabel];
    
    QMUIButton *closeButton = [[QMUIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(headerView.bounds) - 50, 0, 50, 50)];
    [closeButton setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:closeButton];
    [contentView addSubview:headerView];
    
    // 支出/收入选择
    self.segmentedControl = [[QMUISegmentedControl alloc] initWithItems:@[@"支出", @"收入"]];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.frame = CGRectMake(20, CGRectGetMaxY(headerView.frame) + 10, CGRectGetWidth(contentView.bounds) - 40, 40);
    self.segmentedControl.tintColor = [UIColor blueColor]; // 微信风格蓝色
    [contentView addSubview:self.segmentedControl];
    
    // 日期选择器
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.segmentedControl.frame) + 10, CGRectGetWidth(contentView.bounds) - 40, 40)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.date = [NSDate date];
    [contentView addSubview:self.datePicker];
    
    // 金额输入框
    self.amountTextField = [[QMUITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.datePicker.frame) + 20, CGRectGetWidth(contentView.bounds) - 40, 60)];
    self.amountTextField.placeholder = @"0.00";
    self.amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.amountTextField.textAlignment = NSTextAlignmentCenter;
    self.amountTextField.font = [UIFont systemFontOfSize:32];
    [contentView addSubview:self.amountTextField];
    
    // 类型选择
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.amountTextField.frame) + 20, CGRectGetWidth(contentView.bounds) - 40, 20)];
    typeLabel.text = @"选择类型";
    typeLabel.font = [UIFont systemFontOfSize:14];
    typeLabel.textColor = [UIColor grayColor];
    [contentView addSubview:typeLabel];
    
    self.typeSegmentedControl = [[QMUISegmentedControl alloc] initWithItems:@[@"饮食", @"交通", @"购物", @"娱乐"]];
    self.typeSegmentedControl.selectedSegmentIndex = 0;
    self.typeSegmentedControl.frame = CGRectMake(20, CGRectGetMaxY(typeLabel.frame) + 10, CGRectGetWidth(contentView.bounds) - 40, 40);
    self.typeSegmentedControl.tintColor = [UIColor blueColor]; // 微信风格蓝色
    [contentView addSubview:self.typeSegmentedControl];
    
    // 添加备注按钮
    QMUIButton *addNoteButton = [[QMUIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.typeSegmentedControl.frame) + 20, CGRectGetWidth(contentView.bounds) - 40, 40)];
    [addNoteButton setTitle:@"添加备注" forState:UIControlStateNormal];
    [addNoteButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addNoteButton addTarget:self action:@selector(showNoteInput) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:addNoteButton];
    
    // 确认按钮
    QMUIButton *confirmButton = [[QMUIButton alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(contentView.bounds) - 60, CGRectGetWidth(contentView.bounds) - 40, 50)];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.backgroundColor = [UIColor blueColor]; // 微信风格蓝色
    confirmButton.layer.cornerRadius = 8;
    [confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:confirmButton];
    
    modalViewController.contentView = contentView;
    [modalViewController showWithAnimated:YES completion:nil];
}
- (void)showEmptyViewWithText:(NSString *)text
                   detailText:(NSString *)detailText
                  buttonTitle:(NSString *)buttonTitle
                 buttonAction:(SEL)action {
    // 创建或获取 emptyView
    self.emptyView = [[QMUIEmptyView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.emptyView];

    // 设置内容
    [self.emptyView setImage:[UIImage imageNamed:@"empty_icon"]];
    [self.emptyView setTextLabelText:@"暂无数据"];
    [self.emptyView setDetailTextLabelText:@"请稍后再试"];
    [self.emptyView setActionButtonTitle:@"刷新"];
    [self.emptyView setLoadingViewHidden:YES];

    // 设置按钮点击事件
    if (action) {
        [self.emptyView.actionButton addTarget:self
                                        action:action
                              forControlEvents:UIControlEventTouchUpInside];
    }

    // 显示 emptyView
    self.emptyView.hidden = NO;
    
}
- (void)showNoteInput {
    QMUIDialogTextFieldViewController *dialogViewController = [[QMUIDialogTextFieldViewController alloc] init];
    dialogViewController.title = @"添加备注";
    
    // 添加输入框
    [dialogViewController addTextFieldWithTitle:nil configurationHandler:^(QMUILabel *titleLabel, QMUITextField *textField, CALayer *separatorLayer) {
        textField.placeholder = @"请输入备注";
        textField.maximumTextLength = 50; // 限制最大输入长度
    }];
    
    // 自动控制提交按钮的可用状态
    dialogViewController.enablesSubmitButtonAutomatically = YES;
    
    // 添加取消按钮
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    
    // 添加确定按钮
    __weak typeof(self) weakSelf = self;
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *aDialogViewController) {
        QMUITextField *textField = dialogViewController.textFields.firstObject;
        NSString *note = textField.text;
        [weakSelf handleNoteInput:note]; // 处理备注输入
        [aDialogViewController hide]; // 关闭弹窗
    }];
    
    // 显示备注输入框
    [dialogViewController show];
}

- (void)handleNoteInput:(NSString *)note {
    NSLog(@"备注内容：%@", note);
    // 处理备注逻辑，例如保存到模型或更新 UI
}
- (void)closeModal {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)refreshData {
    NSLog(@"刷新数据");
    [self pushToDetailPage];
    // 隐藏 emptyView
    // 显示加载提示
        QMUITips *loadingTips = [QMUITips showLoadingInView:self.view hideAfterDelay:2.0];
        
        // 模拟一个耗时操作
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 隐藏加载提示
            [QMUITips hideAllTips];
        });
    self.emptyView.hidden = YES;
}

- (void)confirmButtonClicked {
    // 获取选择的支出类型、日期、金额、类型、备注等参数
    NSInteger selectedSegmentIndex = self.segmentedControl.selectedSegmentIndex;
    NSDate *selectedDate = self.datePicker.date;
    NSString *amount = self.amountTextField.text;
    NSInteger selectedTypeIndex = self.typeSegmentedControl.selectedSegmentIndex;
    
    // 调用接口
    [self callAPIWithType:selectedSegmentIndex date:selectedDate amount:amount category:selectedTypeIndex note:nil];
}

- (void)callAPIWithType:(NSInteger)type date:(NSDate *)date amount:(NSString *)amount category:(NSInteger)category note:(NSString *)note {
    // 调用接口的逻辑
    NSLog(@"调用接口：类型=%ld, 日期=%@, 金额=%@, 类别=%ld, 备注=%@", (long)type, date, amount, (long)category, note);
}
- (void)pushToDetailPage {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
