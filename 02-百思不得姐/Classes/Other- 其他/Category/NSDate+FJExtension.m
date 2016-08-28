//
//  NSDate+FJExtension.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/25.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "NSDate+FJExtension.h"

@implementation NSDate (FJExtension)

- (NSDateComponents *)deltaFrom:(NSDate *)from{
    
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSCalendarUnit unit =NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    
    return  [calendar components:unit fromDate:self toDate:from options:0];

}

/**
 * 是否是今年
 */
- (BOOL)isThisYear{
    
   //日历
   NSCalendar *calendar = [NSCalendar currentCalendar];
    
   NSInteger nowYear= [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear= [calendar component:NSCalendarUnitYear fromDate:self];

    return nowYear = selfYear;
    
    
}

/**
 * 是否是今天
 */
- (BOOL)isThisDay{
    
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

   NSDateComponents *nowCmps= [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps= [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year
        && nowCmps.month == selfCmps.month
        && nowCmps.day == selfCmps.day;
    
}

//- (BOOL)isThisDay{
//    
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    
//    fmt.dateFormat = @"yyy-MM-dd HH:mm:ss";
//    
//    NSString *nowString =[fmt stringFromDate:[NSDate date]];
//    NSString *selfString =[fmt stringFromDate:self];
//
//    return [nowString isEqualToString:selfString];
//    
//}

/**
 * 是否是昨天
 */
- (BOOL)isYesterDay{
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyy-MM-dd HH:mm:ss";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate= [fmt dateFromString:[fmt stringFromDate:self]];

    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];

   NSDateComponents *cmps =[calendar components:NSCalendarUnitDay | NSCalendarUnitMonth| NSCalendarUnitYear  fromDate:selfDate toDate:nowDate options:0];
    
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1 ;
}


@end
