//
//  CalculateViewController.m
//  percento
//
//  Created by Oscar Armstrong on 10/18/12.
//  Copyright (c) 2012 Oscar Armstrong. All rights reserved.
//

#import "CalculateViewController.h"
#import "PercentoHistory.h"

@interface CalculateViewController ()
@end

@implementation CalculateViewController

@synthesize xInput;
@synthesize yInput;
@synthesize closeButton;
@synthesize calculateButton;
@synthesize nextButton;
@synthesize prevButton;
@synthesize tagRequest;
@synthesize labelOne;
@synthesize labelTwo;
@synthesize labelThree;
@synthesize labelFour;
@synthesize labelFive;
@synthesize answer;
@synthesize horizontalRule;
@synthesize app;

#pragma mark - View Control Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
    // SET THE APP DELEGATE
    app = [[UIApplication sharedApplication] delegate];
    
    ruleCheck = 0;
    keyboardCheck = 0;
    toolBarCheck = 0;
    
    if ([tagRequest isEqualToString:@"1"]) {
        [closeButton setTitle:@"what is __ % of __ ?" forState:UIControlStateNormal];
        [labelOne setText:@"what is"];
        [labelTwo setText:@"%"];
        [labelThree setText:@"of"];
        [labelFour setText:@"?"];
    }
    else if ([tagRequest isEqualToString:@"2"]) {
        [closeButton setTitle:@"__ is what % of __ ?" forState:UIControlStateNormal];
        [labelOne setText:@""];
        [labelTwo setText:@"is what %"];
        [labelThree setText:@"of"];
        [labelFour setText:@"?"];
    }
    else if ([tagRequest isEqualToString:@"3"]) {
        [closeButton setTitle:@"__ is __ % of what ?" forState:UIControlStateNormal];
        [labelOne setText:@""];
        [labelTwo setText:@"is"];
        [labelThree setText:@""];
        [labelFour setText:@"% of what?"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fixView:) name:@"fixView" object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marks - Keyboard Stuff

- (IBAction) next:(id)sender
{
    [xInput resignFirstResponder];
    [yInput becomeFirstResponder];
}

- (IBAction) prev:(id)sender
{
    [xInput becomeFirstResponder];
    [yInput resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [xInput resignFirstResponder];
    [yInput resignFirstResponder];
    [self animateViewDown];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateViewUp];
}

- (void)textFieldDidFinishEditing:(UITextField *)textField
{
    [self animateViewDown];
}

#pragma mark - Animation Methods

- (void)animateViewUp
{
    if (keyboardCheck == 0) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 46);
        [UIView commitAnimations];
        
        [toolBar setHidden:NO];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        toolBar.center = CGPointMake(toolBar.center.x, toolBar.center.y - 170);
        [UIView commitAnimations];
        
        keyboardCheck = 1;
    }
}

- (void)animateViewDown
{
    if (keyboardCheck == 1) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 46);
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        toolBar.center = CGPointMake(toolBar.center.x, toolBar.center.y + 170);
        [UIView commitAnimations];
        [toolBar setHidden:YES];
        
        keyboardCheck = 0;
    }
}

- (void)animateRuleUp
{
    if (ruleCheck == 1) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        horizontalRule.center = CGPointMake(horizontalRule.center.x, horizontalRule.center.y - 60);
        [UIView commitAnimations];
        ruleCheck = 0;
    }
}

- (void)animateRuleDown
{
    if (ruleCheck == 0) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        horizontalRule.center = CGPointMake(horizontalRule.center.x, horizontalRule.center.y + 60);
        [UIView commitAnimations];
        ruleCheck = 1;
    }
}

#pragma mark - Calculation Methods

- (IBAction)calculate:(id)sender
{
    if (xInput.text.length != 0 && yInput.text.length != 0) {
        
        float x = [xInput.text floatValue];
        float y = [yInput.text floatValue];
        
        if ([tagRequest isEqualToString:@"1"]) {
            
            float floatAnswer = (x / 100) * y;
            
            NSString * stringAnswer = [NSString stringWithFormat:@"%1.2f", floatAnswer];
            answer.text = stringAnswer;
            
            NSString *labelFiveString = [NSString stringWithFormat:@"(%1.2f / 100) * %1.2f =", x, y];
            [labelFive setText:labelFiveString];

        }
        if ([tagRequest isEqualToString:@"2"]) {

            float floatAnswer = (x / y) * 100;

            NSString * stringAnswer = [NSString stringWithFormat:@"%1.2f%%", floatAnswer];
            answer.text = stringAnswer;
            
            NSString *labelFiveString = [NSString stringWithFormat:@"(%1.2f / %1.2f) * 100 =", x, y];
            [labelFive setText:labelFiveString];

        }
        if ([tagRequest isEqualToString:@"3"]) {
            
            float floatAnswer = (x / y) * 100;

            NSString * stringAnswer = [NSString stringWithFormat:@"%1.2f", floatAnswer];
            answer.text = stringAnswer;
            
            NSString *labelFiveString = [NSString stringWithFormat:@"(%1.2f / %1.2f) * 100 =", x, y];
            [labelFive setText:labelFiveString];

        }
        
        [self animateRuleDown];
        
        [answer setHidden:NO];
        [self addToHistory];
        
        // hide toolbar and lower view
        [self animateViewDown];
        [xInput resignFirstResponder];
        [yInput resignFirstResponder];
    }
}

#pragma mark - Add New History Row

- (void)addToHistory
{
    NSManagedObjectContext *context = [app managedObjectContext];
    
    PercentoHistory *history = [NSEntityDescription insertNewObjectForEntityForName:@"PercentoHistory" inManagedObjectContext:context];
    if ([tagRequest isEqualToString:@"1"]) {
        history.question = [NSString stringWithFormat:@"what is %@%% of %@?", xInput.text, yInput.text];
        history.answer = answer.text;
    }
    if ([tagRequest isEqualToString:@"2"]) {
        history.question = [NSString stringWithFormat:@"%@ is what %% of %@?", xInput.text, yInput.text];
        history.answer = [NSString stringWithFormat:@"%@",answer.text];
    }
    if ([tagRequest isEqualToString:@"3"]) {
        history.question = [NSString stringWithFormat:@"%@ is %@%% of what?", xInput.text, yInput.text];
        history.answer = answer.text;
    }
    
    NSDate *date = [[NSDate alloc] init];    
    history.date = date;
}

#pragma mark - Clear Method

- (IBAction)clear:(id)sender
{
    [answer setHidden:YES];
    labelFive.text = @"";
    xInput.text = @"";
    yInput.text = @"";
    [self animateRuleUp];
}

#pragma mark - Close Method

- (IBAction)close:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 

- (void)viewDidUnload
{
    [self setXInput:nil];
    [self setYInput:nil];
    [self setCloseButton:nil];
    [self setLabelOne:nil];
    [self setLabelTwo:nil];
    [self setLabelThree:nil];
    [self setLabelFour:nil];
    [self setLabelFive:nil];
    [self setCalculateButton:nil];
    [self setHorizontalRule:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}

-(void)fixView:(NSNotification *) notification
{
    [xInput resignFirstResponder];
    [yInput resignFirstResponder];
    [self animateViewDown];
}

@end
