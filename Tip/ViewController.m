//
//  ViewController.m
//  
//
//  Created by Abe Schonfeld on 9/20/15.
//
//

#import "ViewController.h"
#import "ASValueTrackingSlider.h"
#import "SettingsViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *tipSlider;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;

@end

@implementation ViewController

- (IBAction)billAmountChanged {
    [self updateValues];
    [self setDefaultBill];
}

- (IBAction)tipChanged {
    [self updateValues];
}

- (IBAction)saveDefaultPressed:(id)sender {
    [self setDefaultTip];
}

- (void)updateValues {
    float tipPercent = [self getTipPercent];
    float billAmount = [self.billTextField.text floatValue];
    float total = (1.0 + tipPercent) * billAmount;
    float tip;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundDown];
    
    self.tipPercentLabel.text = [NSString stringWithFormat:@"+ %2.f percent tip", tipPercent * 100];
    
    if ([self roundUpToNearestDollar]) {
        total = ceilf(total);
        tip = total -  billAmount;
        
    } else {
        tip = tipPercent * billAmount;
    }
    
    self.tipLabel.text = [formatter stringFromNumber: [NSNumber numberWithFloat: tip]];
    self.totalLabel.text = [formatter stringFromNumber: [NSNumber numberWithFloat: total]];
}

- (float)getTipPercent {
    return roundf(self.tipSlider.value) / 100;
}

- (void)setDefaultTip {
    float currentTip = self.tipSlider.value;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:(currentTip) forKey:@"defaultTip"];
}

- (float)getDefaultTip {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if ([defaults objectForKey:@"defaultTip"] != nil) {
        return [defaults floatForKey:@"defaultTip"];
    } else {
        return 15.0;
    }
}
- (void)setDefaultBill {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: self.billTextField.text forKey: @"defaultBill"];
    [defaults setObject: [NSDate date] forKey: @"billEnteredTime"];
}

- (float)getDefaultBill {
    return [[NSUserDefaults standardUserDefaults] floatForKey: @"defaultBill"];
}


- (BOOL)isDefaultBillValid {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"defaultBill"] != nil) {
        NSDate *billEneteredTime = [defaults objectForKey: @"billEnteredTime"];
        NSTimeInterval timeSinceBillEnetered = fabs([billEneteredTime timeIntervalSinceNow]);
        if (timeSinceBillEnetered < 60 * 10) {
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}

- (bool) roundUpToNearestDollar {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"roundUpToNearestDollar"] == nil) {
        return false;
    } else {
        return [defaults boolForKey: @"roundUpToNearestDollar"];
    }
}


- (void)setTipToDefault {
    self.tipSlider.value = [self getDefaultTip];
}

- (IBAction)onSettingsButton:(id)sender {
    [self presentViewController:[[SettingsViewController alloc] init] animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tipSlider setMaxFractionDigitsDisplayed:0];
    self.tipSlider.value = [self getDefaultTip];
    

    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}




- (void)viewDidAppear:(BOOL)animated {
    [self.billTextField becomeFirstResponder];
    if ([self isDefaultBillValid]) {
        self.billTextField.text = [NSString stringWithFormat: @"%.02f", [self getDefaultBill]];
    }
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
