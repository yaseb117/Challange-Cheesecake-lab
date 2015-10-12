//
//  MasterTableViewController.h
//  Challange-Cheesecake-lab
//
//  Created by Air on 12/10/2015.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortedList.h"
@interface MasterTableViewController : UITableViewController
//@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray * newsDist;
@property (strong,nonatomic) SortedList * sortedList;
@property (strong,nonatomic) NSMutableArray * finalList;
@end
