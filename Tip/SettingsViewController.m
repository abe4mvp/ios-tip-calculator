//
//  SettingsViewController.m
//  Tip
//
//  Created by Abe Schonfeld on 9/27/15.
//  Copyright (c) 2015 Abe Schonfeld. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *roundUpSwitch;

@end

@implementation SettingsViewController
- (IBAction)roundUpSwitchChanged:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setBool: self.roundUpSwitch.on forKey:@"roundUpToNearestDollar"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)backButtonPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:vc animated:true completion:nil];
}

- (bool) currentRoundingState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if ([defaults objectForKey: @"roundUpToNearestDollar"] == nil) {
        return false;
    } else {
        return [defaults boolForKey:@"roundUpToNearestDollar"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.roundUpSwitch.on = [self currentRoundingState];
    
    
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
