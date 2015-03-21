//
//  LoginView.m
//  ADLoginViewController
//
//  Created by Andrew on 3/20/15.
//  Copyright (c) 2015 trolmark. All rights reserved.
//

#import "ADLoginView.h"
#import "UITextField+FormExtended.h"
#import "UIView+CKFrame.h"
#import "ADButton.h"
#import "ADTheme.h"
#import "ADUserLoginModel.h"

@interface ADLoginView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIView *buttonContainer;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
@property (weak, nonatomic) IBOutlet ADButton *signInButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;
@property (weak, nonatomic) UITextField *currentTextField;
@property (weak, nonatomic) IBOutlet UIView *childContentView;

@end

@implementation ADLoginView

- (instancetype) initWithFrame:(CGRect) frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
}

- (void) commonInit {
    self.backgroundColor = [ADTheme backgroundColor];
    
    [self observeKeyboard];
    [self setupSubviews];

    
}

- (void)observeKeyboard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) setupSubviews
{
    self.buttonContainer.backgroundColor = [UIColor clearColor];
    self.iconImageView.backgroundColor = [ADTheme infoBackgroundColor];
    self.errorLabel.textColor = [ADTheme alarmTextColor];
    
    self.logoLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    
    __weak typeof(self) weakSelf = self;
    [self.signInButton configureWithBlock:^(ADButton *sender) {
        [weakSelf closeKeyboard];
        [weakSelf login];
    }];
    
    [self setupLoginForm];
    [self setupGestureRecognizer];
}

- (void) setupLoginForm
{
    __weak typeof(self) weakSelf = self;
    void (^configureTextField)(UITextField *, UIImageView *) = ^(UITextField *field, UIImageView *iconView) {
        field.leftView = iconView;
        field.leftViewMode = UITextFieldViewModeAlways;
        field.backgroundColor = [ADTheme infoBackgroundColor];
        field.layer.borderWidth = 1.0;
        field.layer.borderColor = [ADTheme inactiveTextColor].CGColor;
        field.delegate = weakSelf;
    };
    
    CGFloat iconTextFieldPadding = 20;
    UIImageView *(^textFieldLeftView)(UIImage *) = ^(UIImage *image) {
        UIImageView *iconView = [[UIImageView alloc] initWithImage:image];
        iconView.frameWidth += iconTextFieldPadding;
        iconView.contentMode = UIViewContentModeCenter;
        return iconView;
    };
    
    
    configureTextField(self.usernameField, textFieldLeftView([UIImage imageNamed:@"user"]));
    configureTextField(self.passwordField, textFieldLeftView([UIImage imageNamed:@"password"]));
    
    self.usernameField.ra_nextTextField = self.passwordField;
    self.passwordField.ra_nextTextField = nil;
}

- (void) setupGestureRecognizer {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self addGestureRecognizer:tapGesture];
}

- (void) dismissKeyboard:(UITapGestureRecognizer *)gestureRecognizer {
    [self closeKeyboard];
}

- (void) login
{
    if (self.loginBlock) {
        self.loginBlock([self loginParams]);
    }
}

- (ADUserLoginModel *) loginParams
{
    ADUserLoginModel *userData = [[ADUserLoginModel alloc] initWithUsername:self.usernameField.text
                                                                   password:self.passwordField.text];
    return userData;
}

- (void) showLoading:(BOOL) show
{
    [self.signInButton showLoading:show];
}

- (void) showError:(BOOL) show
{
    self.usernameField.textColor = show ? [ADTheme alarmTextColor] : [UIColor whiteColor];
    self.passwordField.textColor = show ?[ADTheme alarmTextColor] : [UIColor whiteColor];
    self.errorLabel.hidden = !show;
    if (show) {
        [self shake];
    }
}

- (void) shake
{
    [self.buttonContainer.layer removeAllAnimations];
    [self.buttonContainer.layer addAnimation:[self shakeAnimationForView:self.buttonContainer] forKey:@"position"];
}

- (CABasicAnimation *) shakeAnimationForView:(UIView *) view
{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    shake.duration = 0.08;
    shake.repeatCount = 4;
    shake.autoreverses = YES;
    
    CGFloat shiftValue = 9;
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(view.layer.position.x - shiftValue,view.layer.position.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(view.layer.position.x + shiftValue, view.layer.position.y)]];
    return shake;
}

#pragma mark Keyboard

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    // We need reduce margin to login button
    CGFloat margin = 40;
    CGFloat height = keyboardFrame.size.height;
    self.keyboardHeight.constant = +height - margin;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.childContentView layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.keyboardHeight.constant = 0;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.childContentView layoutIfNeeded];
    }];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self showError:NO];
    self.currentTextField = textField;
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    UITextField *next = theTextField.ra_nextTextField;
    if (next) {
        [next becomeFirstResponder];
    } else {
        [self closeKeyboard];
    }
    
    return NO;
}

- (void) closeKeyboard  {
    [self.currentTextField resignFirstResponder];
}





@end
