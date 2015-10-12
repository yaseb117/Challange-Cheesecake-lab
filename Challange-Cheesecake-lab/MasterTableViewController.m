//
//  MasterTableViewController.m
//  Challange-Cheesecake-lab
//
//  Created by Air on 12/10/2015.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "MasterTableViewController.h"
#import "MaserDetailViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString:@"http://www.ckl.io/challenge/"]
@interface MasterTableViewController ()

@end

@implementation MasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _sortedList=[[SortedList alloc]init];
    
    //fetch data in background then reload data because getting data from web take time
    dispatch_async(kBgQueue, ^{
        
        NSData* data = [NSData dataWithContentsOfURL:
                        kLatestKivaLoansURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
        NSLog(@"Yayyy, problem solved!");
        [self performSelectorOnMainThread:@selector(reloaddata) withObject:nil
                            waitUntilDone:YES];
        
        NSLog(@"table count %i",(int)_newsDist.count);
    });

}
//reload data
- (void)reloaddata {
    
   [ self.tableView reloadData];
}


//detching data

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    _newsDist=[[NSMutableArray alloc] init];
    NSError* error;
    NSString* newStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSData* datas=[newStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:datas //1
                          options:kNilOptions
                          error:&error];
    NSLog(@"Yayyy, nestanew!");
    // adding al the dictionnary in a array
    for (  NSMutableDictionary * performerDic in json) {
        
        
        [_newsDist addObject:performerDic];
    }
    //sorting the array by date with the functio "tableFusion" from SortedList Class
    _finalList=[[NSMutableArray alloc]initWithArray:[_sortedList tableFusion:_newsDist]];
   
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_finalList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //calling the prototype cell with her identifier
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //calling the prototype cell with there tags
    UIImageView*picture =(UIImageView *)[cell viewWithTag:110];
    UILabel *name=(UILabel*)[cell viewWithTag:100];
    
    NSDictionary *status = [self.finalList objectAtIndex:indexPath.row];
    NSString* img=[NSString stringWithFormat:@"%@",[status objectForKey:@"image"]];
    if([img isEqualToString:@"(null)"] || [ img isEqualToString:@"<null>"]) {
        
        picture.image=[UIImage imageNamed:@"404"];
    }else{
        picture.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[status valueForKey:@"image"]]]];
    }

    name.text=[status valueForKey:@"title"];
    return cell;
}
//sending data to detail view when i click select a row
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected row: %ld",(long)indexPath.row);
    //instanciate MaserDetailViewController with her identifier to access to it attribute
    MaserDetailViewController * DetailView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    NSDictionary *status = [self.finalList objectAtIndex:indexPath.row];
    NSString * title=[status objectForKey:@"title"];
    NSString * authors=[status objectForKey:@"authors"];
    NSString * website=[status objectForKey:@"website"];
    NSString * date=[status objectForKey:@"date"];
    NSString * content=[status objectForKey:@"content"];
    NSString * image=[status objectForKey:@"image"];
    
    //testing the image parsed if it's not null
    DetailView.Title =title;
    if (image !=(id)[NSNull null]) {
        DetailView.urlImage=image;
    }
    //set strings in detail view controller
    DetailView.Title =title;
    DetailView.Website=website;
    DetailView.Date=date;
    DetailView.Authors=authors;
    DetailView.Content=content;
    //mark celle as selected
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    
    //showing detal view controller
    [self.splitViewController showDetailViewController:DetailView sender:self];
    //[self.navigationController pushViewController:DetailView animated:YES];
    
    
}



@end
