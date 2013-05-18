//
//  HistoryViewController.h
//  percento
//
//  Created by Oscar Armstrong on 10/30/12.
//  Copyright (c) 2012 Oscar Armstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface HistoryViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) AppDelegate *app;

- (IBAction)close:(id)sender;

@end
