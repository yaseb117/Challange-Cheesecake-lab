//
//  MaserDetailViewController.h
//  Challange-Cheesecake-lab
//
//  Created by Air on 12/10/2015.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaserDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *lblImage;
@property (strong, nonatomic) IBOutlet UILabel *lblInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UITextView *lblContent;
@property (strong, nonatomic)  NSString * Title;
@property (strong, nonatomic)  NSString * urlImage;
@property (strong, nonatomic)  NSString * Authors;
@property (strong, nonatomic)  NSString * Website;
@property (strong, nonatomic)  NSString * Date;
@property (strong, nonatomic)  NSString * Content;
@end
