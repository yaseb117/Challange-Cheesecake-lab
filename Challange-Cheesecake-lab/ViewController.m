//
//  ViewController.m
//  Challange-Cheesecake-lab
//
//  Created by Air on 09/10/2015.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "ViewController.h"
#import "DiceTableViewCell.h"
#import "DetailViewControll.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString:@"http://www.ckl.io/challenge/"]
@interface ViewController ()
@property (assign, nonatomic) CGPoint lastContentOffset;
@end


//the same think as MasterTableViewController

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //tho provide information fromthe Viewcontroll to view and invers
    _tableView.dataSource=self;
    _tableView.delegate=self;
   

    [self.tableView registerNib:[UINib nibWithNibName:@"DiceTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiceTableViewCell"];

    _sortedList=[[SortedList alloc]init];
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
- (void)reloaddata {
    
    [_tableView reloadData];
}
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
    
   NSMutableDictionary *performerDic = [[NSMutableDictionary alloc] init];
    for ( performerDic in json) {


        [_newsDist addObject:performerDic];
    }
    _finalList=[[NSMutableArray alloc]initWithArray:[_sortedList tableFusion:_newsDist]];
   
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    DiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiceTableViewCell" forIndexPath:indexPath];
    NSDictionary *status = [self.finalList objectAtIndex:indexPath.row];
    NSLog(@"image %@",[status valueForKey:@"image"]);
    NSString* img=[NSString stringWithFormat:@"%@",[status objectForKey:@"image"]];
    if([img isEqualToString:@"(null)"] || [ img isEqualToString:@"<null>"]) {
   
        cell.imageViewBackground.image=[UIImage imageNamed:@"404"];
    }else{
        cell.imageViewBackground.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[status valueForKey:@"image"]]]];
    }
        cell.titlelbl.text =[status valueForKey:@"title"];
    
        return cell;
}


//to allow effect of parallax in Image in the Table view cell
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    DiceTableViewCellScrollDirection scrollDirection = ScrollDirectionNone;
    
    if (self.lastContentOffset.x > scrollView.contentOffset.x)
    {
        scrollDirection = ScrollDirectionRight;
    }
    else if (self.lastContentOffset.x < scrollView.contentOffset.x)
    {
        scrollDirection = ScrollDirectionLeft;
    }
    else if (self.lastContentOffset.y > scrollView.contentOffset.y)
    {
        scrollDirection = ScrollDirectionDown;
        //        NSLog(@"DOWN");
    }
    else if (self.lastContentOffset.y < scrollView.contentOffset.y)
    {
        scrollDirection = ScrollDirectionUp;
        //        NSLog(@"UP");
    }
    else
    {
        scrollDirection = ScrollDirectionCrazy;
    }
    
    self.lastContentOffset = scrollView.contentOffset;
    
    id notificationObject = [NSNumber numberWithInteger:scrollDirection];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DiceTableViewCellDirectionNotification object:notificationObject];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected row: %ld",(long)indexPath.row);
    
    DetailViewControll * DetailView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    NSDictionary *status = [self.finalList objectAtIndex:indexPath.row];
    NSString * title=[status objectForKey:@"title"];
    NSString * authors=[status objectForKey:@"authors"];
    NSString * website=[status objectForKey:@"website"];
    NSString * date=[status objectForKey:@"date"];
    NSString * content=[status objectForKey:@"content"];
    NSString * image=[status objectForKey:@"image"];
    
    DetailView.Title =title;
    if (image !=(id)[NSNull null]) {
        DetailView.urlImage=image;
    }
    //DetailView.urlImage=image;
    DetailView.Website=website;
    DetailView.Date=date;
    DetailView.Authors=authors;
    DetailView.Content=content;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    [self.navigationController pushViewController:DetailView animated:YES];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [_finalList count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat heightForRowAtIndexPath = 160.0f;
    
    return heightForRowAtIndexPath;
}



@end
