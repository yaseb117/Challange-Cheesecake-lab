//
//  ViewController.h
//  Challange-Cheesecake-lab
//
//  Created by Air on 09/10/2015.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortedList.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (strong,nonatomic) NSMutableArray * getWebsite;
@property (strong,nonatomic) NSMutableArray * getImage;
@property (strong,nonatomic) NSMutableArray * getDate;
@property (strong,nonatomic) NSMutableArray * getTitle;
@property (strong,nonatomic) NSMutableArray * getContent;
@property (strong,nonatomic) NSMutableArray * getAuthor;
@property (strong,nonatomic) NSMutableArray * newsDist;
@property (strong,nonatomic) SortedList * sortedList;
@property (strong,nonatomic) NSMutableArray * finalList;
@end

