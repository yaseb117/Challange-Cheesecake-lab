//
//  SortedList.m
//  RESideMenuStoryboardsExample
//
//  Created by Air on 27/08/2015.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

#import "SortedList.h"

@implementation SortedList

//convert NSString to NSdate to allow the comparison of  2 date

- (NSDate*)DateConvertor:(NSString*)trashDate {
    
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc]init];

    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDate *date  = [dateFormatter dateFromString:trashDate];
    return date;
}




// compare the 2 NSDate
-(BOOL)ComapreDate:(NSDate *)date1 with:(NSDate*) date2{
    Boolean result=NO;
    NSComparisonResult resultComp = [date1 compare:date2];
    switch (resultComp)
    {
        case NSOrderedAscending:result=YES; //NSLog(@"%@ is in future from %@", date1, date2);
            break;
        case NSOrderedDescending: result=NO;// NSLog(@"%@ is in past from %@", date1, date2);
            break;
        case NSOrderedSame: result=YES;//NSLog(@"%@ is the same as %@", date1, date2);
            break;
        default:
            break;
    }
    return result;
    
}
//sort the dictonaries in NSMutable Array by date
//the main idea is to compare each date in is article to the othe article and put the lastest one in a array
-(NSMutableArray *)tableFusion:(NSMutableArray*) fbtable {
  
    NSDictionary* replacmet;
  
    int index;
    //selecting the dictionarie to compare
    for (int i=0; i<fbtable.count; i++) {
        NSDictionary*dict1=[fbtable objectAtIndex:i];
        //getting the sate string
        NSString* dateString1=[dict1 objectForKey:@"date"];
        
        //convarte string to date
        NSDate *dateI =[self DateConvertor:dateString1];
        //saving the index and dictionary like it's the lastest one
        replacmet=dict1;
        index=i;
        //test if we are not out of bounds of the table
        
        if (i< (fbtable.count-1)) {
            
       //now we have our first date we have to compare it to the other w beginig with the next one ine in the array that's why we use j+1
            for (int j=i+1; j<fbtable.count; j++) {
             //preparing the second dictionary to be comared
                NSDictionary*dict2=[fbtable objectAtIndex:j];
                NSString* dateString2=[dict2 objectForKey:@"date"];
            
                NSDate *dateJ =[self DateConvertor:dateString2];
             
                if ([self ComapreDate:dateI with:dateJ]){
                    //wich mean the sond one is in future fron the first then replace this elemebt by the new one
                    replacmet=dict2;
                    dateI=dateJ;
                    index=j;
                }
            }
            // we move to j+2 and next
        }
        
        [fbtable removeObjectAtIndex:i];
        [fbtable insertObject:replacmet atIndex:i];
        [fbtable removeObjectAtIndex:index];
        [fbtable insertObject:dict1 atIndex:index];
        // we move to i+2 and next
        
    }
    NSLog(@"sorted end");
    return fbtable;
}




@end
