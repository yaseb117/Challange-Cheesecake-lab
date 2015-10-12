//
//  DetailViewControll.m
//  Challange-Cheesecake-lab
//
//  Created by Air on 09/10/2015.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "DetailViewControll.h"

@implementation DetailViewControll

-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"mchet");
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
     self.scrollView.contentSize =CGSizeMake(self.view.bounds.size.width, 610);
      NSLog(@"%@ %i",_urlImage , (int)_urlImage.length);
    //_lblTitle.text =_Title;
    _txtTitle.text=_Title;
    _txtTitle.backgroundColor=[UIColor clearColor];
    _txtTitle.font=[UIFont fontWithName:@"BodoniSvtyTwoOSITCTT-Bold" size:20];
    //_Image.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_urlImage]]];
    if([_urlImage isEqualToString:@"(null)"] || [ _urlImage isEqualToString:@"<null>"] || _urlImage==nil) {
        
        _Image.image=[UIImage imageNamed:@"404"];
    }else{
        _Image.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_urlImage]]];
    }

    _lblDate.text=_Date;
    _lblAuthors.text=[NSString stringWithFormat:@"From %@ for website : %@", _Authors, _Website];
    _lblContent.text=_Content;
    _lblContent.backgroundColor=[UIColor clearColor];
    [_lblContent setFont:[UIFont boldSystemFontOfSize:15]];
    //[_txtTitle setFont:[UIFont boldSystemFontOfSize:15]];
}


@end
