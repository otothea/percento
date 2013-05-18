//
//  HistoryViewController.m
//  percento
//
//  Created by Oscar Armstrong on 10/30/12.
//  Copyright (c) 2012 Oscar Armstrong. All rights reserved.
//

#import "HistoryViewController.h"
#import "PercentoHistory.h"

@interface HistoryViewController ()
@end

@implementation HistoryViewController
@synthesize context;
@synthesize historyArray;
@synthesize app;

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    app = [[UIApplication sharedApplication] delegate];
    
    [self getHistory];
}

#pragma mark - Request History From Core Data

- (void) getHistory
{
    context = [app managedObjectContext];

    // Define Entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PercentoHistory" inManagedObjectContext:context];
    
    // Define Request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // Set Request
    [request setFetchBatchSize:20];
    [request setEntity:entity];
    
    // here's where you specify the sort
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortArray = [NSArray arrayWithObject:sort];
    [request setSortDescriptors: sortArray];
    
    // Set Error
    NSError *error;
    
    // Fetch Array
    NSMutableArray *newArray = [[context executeFetchRequest:request error:&error] mutableCopy];
    [self setHistoryArray:newArray];
    
    // Reload Table
    [self.tableView reloadData];
}

#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [historyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryCell"];
    }
    
    PercentoHistory *history = [historyArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [history question]; 
    cell.detailTextLabel.text = [history answer];
         
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Close Modal View Method

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - The Rest

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {    
    [super viewDidUnload];
}

@end
