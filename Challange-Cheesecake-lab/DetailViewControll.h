//
//  DetailViewControll.h
//  Challange-Cheesecake-lab
//
//  Created by Air on 09/10/2015.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewControll : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *Image;
@property (strong, nonatomic) IBOutlet UILabel *lblAuthors;

@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UITextView *lblContent;
@property (strong, nonatomic) IBOutlet UITextView *txtTitle;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic)  NSString * Title;
@property (strong, nonatomic)  NSString * urlImage;
@property (strong, nonatomic)  NSString * Authors;
@property (strong, nonatomic)  NSString * Website;
@property (strong, nonatomic)  NSString * Date;
@property (strong, nonatomic)  NSString * Content;
@end
