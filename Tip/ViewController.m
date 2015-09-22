//
//  ViewController.m
//  
//
//  Created by Abe Schonfeld on 9/20/15.
//
//

#import "ViewController.h"
#import "ASValueTrackingSlider.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *tipSlider;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;


@end

@implementation ViewController


-(float)getTipPercent {
    return roundf(self.tipSlider.value) / 100;
}



-(void)updateValues {
    float tipPercent = [self getTipPercent];
    float billAmount = [self.billTextField.text floatValue];
    
    
    self.tipLabel.text = [NSString stringWithFormat:@"%.02f", tipPercent * billAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%.02f", (1 + tipPercent) * billAmount];
}

- (IBAction)tipChanged:(id)sender {
    [self updateValues];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tipSlider setMaxFractionDigitsDisplayed:0];
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
