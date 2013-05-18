//
//  CalculateViewController.h
//  percento
//
//  Created by Oscar Armstrong on 10/18/12.
//  Copyright (c) 2012 Oscar Armstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CalculateViewController : UIViewController <UITextFieldDelegate>
{
    int ruleCheck;
    int keyboardCheck;
    int toolBarCheck;
    // keyboard tool bar
	IBOutlet UIToolbar *toolBar;
}

@property (weak, nonatomic) IBOutlet UITextField *xInput;
@property (weak, nonatomic) IBOutlet UITextField *yInput;

@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFive;
@property (weak, nonatomic) IBOutlet UILabel *answer;

@property (weak, nonatomic) IBOutlet UIImageView *horizontalRule;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *prevButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *calculateButton;

@property (strong, nonatomic) NSString *tagRequest;

@property (nonatomic, strong) AppDelegate *app;

- (IBAction)close:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)calculate:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)prev:(id)sender;

@end
