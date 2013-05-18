//
//  MainViewController.m
//  percento
//
//  Created by Oscar Armstrong on 10/18/12.
//  Copyright (c) 2012 Oscar Armstrong. All rights reserved.
//

#import "MainViewController.h"
#import "CalculateViewController.h"

@interface MainViewController ()
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender tag] < 4) {
        // Get reference to the destination view controller
        CalculateViewController *vc = [segue destinationViewController];
        NSString *tag = [NSString stringWithFormat:@"%d", [sender tag]];
        vc.tagRequest = tag;
    }
}

@end
