//
//  MaserDetailViewController.m
//  Challange-Cheesecake-lab
//
//  Created by Air on 12/10/2015.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "MaserDetailViewController.h"

@interface MaserDetailViewController ()

@end

@implementation MaserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-ipad"]];
   
    //hide all element if there no element selected in the Master table
    if (_Title==nil) {
        [_lblInfo setHidden:YES];
        [_lblTitle setHidden:YES];
        [_lblContent setHidden:YES];
        [_lblDate setHidden:YES];
    }else{
        
        _lblTitle.text=_Title;
        _lblTitle.backgroundColor=[UIColor clearColor];
        //test if the image is not nil
        if( _urlImage==nil) {
            
            _lblImage.image=[UIImage imageNamed:@"404"];
        }else{
            
            _lblImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_urlImage]]];
        }
        //show all the detal
        _lblTitle.text=_Title;
        _lblTitle.backgroundColor=[UIColor clearColor];

        _lblDate.text=_Date;
        //concatination of authors an website in the same label
        _lblInfo.text=[NSString stringWithFormat:@"From %@ for website : %@", _Authors, _Website];
        _lblContent.text=_Content;
        _lblContent.backgroundColor=[UIColor clearColor];
        [_lblContent setFont:[UIFont boldSystemFontOfSize:15]];
    }
    
    
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
