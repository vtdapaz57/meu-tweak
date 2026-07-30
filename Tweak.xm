#import <UIKit/UIKit.h>

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self createUrielPanel];
    });
}

%new
- (void)createUrielPanel {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (!keyWindow) return;
    
    UIView *panel = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 200, 340)];
    panel.backgroundColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.1 alpha:0.92];
    panel.layer.cornerRadius = 18;
    panel.layer.borderColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.8 alpha:0.8].CGColor;
    panel.layer.borderWidth = 2.0;
    panel.layer.shadowColor = [UIColor cyanColor].CGColor;
    panel.layer.shadowOpacity = 0.3;
    panel.layer.shadowRadius = 10;
    panel.tag = 9998;
    
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 200, 30)];
    header.text = @"⚡ URIEL STREAM ⚡";
    header.textColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.8 alpha:1.0];
    header.font = [UIFont boldSystemFontOfSize:16];
    header.textAlignment = NSTextAlignmentCenter;
    [panel addSubview:header];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10, 45, 180, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    [panel addSubview:line1];
    
    // Stream Mode
    UILabel *lblStream = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, 100, 25)];
    lblStream.text = @"📡 Stream Mode";
    lblStream.textColor = [UIColor whiteColor];
    lblStream.font = [UIFont systemFontOfSize:13];
    [panel addSubview:lblStream];
    
    UISwitch *switchStream = [[UISwitch alloc] initWithFrame:CGRectMake(140, 52, 50, 30)];
    switchStream.onTintColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.8 alpha:1.0];
    switchStream.tag = 100;
    [switchStream addTarget:self action:@selector(toggleStream:) forControlEvents:UIControlEventValueChanged];
    [panel addSubview:switchStream];
    
    // ESP
    UILabel *lblESP = [[UILabel alloc] initWithFrame:CGRectMake(15, 95, 100, 25)];
    lblESP.text = @"👁️ ESP";
    lblESP.textColor = [UIColor whiteColor];
    lblESP.font = [UIFont systemFontOfSize:13];
    [panel addSubview:lblESP];
    
    UISwitch *switchESP = [[UISwitch alloc] initWithFrame:CGRectMake(140, 92, 50, 30)];
    switchESP.onTintColor = [UIColor colorWithRed:1.0 green:0.2 blue:0.2 alpha:1.0];
    switchESP.tag = 101;
    [switchESP addTarget:self action:@selector(toggleESP:) forControlEvents:UIControlEventValueChanged];
    [panel addSubview:switchESP];
    
    // FOV
    UILabel *lblFOV = [[UILabel alloc] initWithFrame:CGRectMake(15, 135, 100, 25)];
    lblFOV.text = @"🔭 FOV";
    lblFOV.textColor = [UIColor whiteColor];
    lblFOV.font = [UIFont systemFontOfSize:13];
    [panel addSubview:lblFOV];
    
    UILabel *lblFOVValue = [[UILabel alloc] initWithFrame:CGRectMake(140, 135, 50, 25)];
    lblFOVValue.text = @"90°";
    lblFOVValue.textColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.8 alpha:1.0];
    lblFOVValue.font = [UIFont boldSystemFontOfSize:14];
    lblFOVValue.textAlignment = NSTextAlignmentRight;
    lblFOVValue.tag = 200;
    [panel addSubview:lblFOVValue];
    
    UISlider *sliderFOV = [[UISlider alloc] initWithFrame:CGRectMake(15, 165, 170, 30)];
    sliderFOV.minimumValue = 60.0;
    sliderFOV.maximumValue = 120.0;
    sliderFOV.value = 90.0;
    sliderFOV.tintColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.8 alpha:1.0];
    sliderFOV.tag = 201;
    [sliderFOV addTarget:self action:@selector(changeFOV:) forControlEvents:UIControlEventValueChanged];
    [panel addSubview:sliderFOV];
    
    // AIM
    UIButton *btnAim = [UIButton buttonWithType:UIButtonTypeSystem];
    btnAim.frame = CGRectMake(15, 210, 170, 35);
    [btnAim setTitle:@"🎯 AIM ASSIST (SIM)" forState:UIControlStateNormal];
    [btnAim setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnAim.backgroundColor = [UIColor colorWithRed:0.2 green:0.5 blue:0.8 alpha:0.6];
    btnAim.layer.cornerRadius = 8;
    btnAim.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [btnAim addTarget:self action:@selector(aimAssistAction) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:btnAim];
    
    // RECOIL
    UIButton *btnRecoil = [UIButton buttonWithType:UIButtonTypeSystem];
    btnRecoil.frame = CGRectMake(15, 255, 170, 35);
    [btnRecoil setTitle:@"🔫 ANTI-RECOIL (SIM)" forState:UIControlStateNormal];
    [btnRecoil setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnRecoil.backgroundColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:0.6];
    btnRecoil.layer.cornerRadius = 8;
    btnRecoil.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [btnRecoil addTarget:self action:@selector(antiRecoilAction) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:btnRecoil];
    
    // FOOTER
    UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, 200, 20)];
    footer.text = @"🛡️ SAFE MODE | ACADEMIC";
    footer.textColor = [UIColor grayColor];
    footer.font = [UIFont systemFontOfSize:9];
    footer.textAlignment = NSTextAlignmentCenter;
    [panel addSubview:footer];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragPanel:)];
    [panel addGestureRecognizer:pan];
    
    [keyWindow addSubview:panel];
}

%new
- (void)toggleStream:(UISwitch *)sender {
    if (sender.isOn) {
        [self showAlertWithTitle:@"📡 STREAM MODE" message:@"Ativado! (Simulação)"];
        UIView *panel = [self getPanel];
        panel.layer.borderColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.5 alpha:0.8].CGColor;
    } else {
        [self showAlertWithTitle:@"📡 STREAM MODE" message:@"Desativado."];
        UIView *panel = [self getPanel];
        panel.layer.borderColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.8 alpha:0.8].CGColor;
    }
}

%new
- (void)toggleESP:(UISwitch *)sender {
    if (sender.isOn) {
        [self showAlertWithTitle:@"👁️ ESP" message:@"Ativado! (Simulação)"];
        UIView *panel = [self getPanel];
        panel.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        [self showAlertWithTitle:@"👁️ ESP" message:@"Desativado."];
        UIView *panel = [self getPanel];
        panel.layer.borderColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.8 alpha:0.8].CGColor;
    }
}

%new
- (void)changeFOV:(UISlider *)slider {
    int value = (int)slider.value;
    UILabel *label = (UILabel *)[[self getPanel] viewWithTag:200];
    label.text = [NSString stringWithFormat:@"%d°", value];
    UIView *panel = [self getPanel];
    float percent = (value - 60) / 60.0;
    panel.backgroundColor = [UIColor colorWithRed:0.05 green:0.05 + (percent * 0.3) blue:0.1 alpha:0.92];
}

%new
- (void)aimAssistAction {
    [self showAlertWithTitle:@"🎯 AIM ASSIST" message:@"Simulação acadêmica."];
}

%new
- (void)antiRecoilAction {
    [self showAlertWithTitle:@"🔫 ANTI-RECOIL" message:@"Simulação acadêmica."];
}

%new
- (UIView *)getPanel {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    return [keyWindow viewWithTag:9998];
}

%new
- (void)dragPanel:(UIPanGestureRecognizer *)gesture {
    UIView *panel = gesture.view;
    CGPoint translation = [gesture translationInView:panel.superview];
    panel.center = CGPointMake(panel.center.x + translation.x, panel.center.y + translation.y);
    [gesture setTranslation:CGPointZero inView:panel.superview];
}

%new
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title 
                                                                   message:msg 
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    [root presentViewController:alert animated:YES completion:nil];
}

%end
