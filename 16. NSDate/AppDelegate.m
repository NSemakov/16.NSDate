//
//  AppDelegate.m
//  16. NSDate
//
//  Created by Admin on 26.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "NVStudent.h"
@interface AppDelegate ()
@property (strong,nonatomic) NSDate* acceleratedDate;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Uchenik
    NSMutableArray* arrayOfStudents=[[NSMutableArray alloc]init];
    NSCalendar* calendar=[NSCalendar currentCalendar];
    NSDateComponents* components=[[NSDateComponents alloc]init];
    
    NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSInteger currentYear=[calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    for (NSInteger i=0; i<30; i++) {
        NVStudent *student=[[NVStudent alloc]init];
        
        NSInteger year=arc4random_uniform(50-16)+16+1;
        
        components.year=currentYear-year;
        NSInteger month=arc4random_uniform(12)+1;
        components.month=month;
        NSDate* date=[calendar dateFromComponents:components];
        NSRange rangeOfDaysInMonth=[calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        NSInteger numberOfDaysInMonth=rangeOfDaysInMonth.length;
        NSInteger day=arc4random_uniform((unsigned int)numberOfDaysInMonth)+1;
        components.day=day;
        
        student.dateOfBirth=[calendar dateFromComponents:components];
        [arrayOfStudents addObject:student];
        
    }
    
    for (NVStudent * obj in arrayOfStudents){
        NSLog(@"date of Birth: %@",[formatter stringFromDate:obj.dateOfBirth]);
    }
    
    //----------
    //end of Uchenik
    
    //Student
    
    [arrayOfStudents sortUsingComparator:^NSComparisonResult(NVStudent* obj1, NVStudent* obj2) {
       return [obj1.dateOfBirth compare:obj2.dateOfBirth];
    }];
    
    for (NVStudent * obj in arrayOfStudents){
        NSLog(@"%@ %@ : %@",obj.firstname,obj.lastname,[formatter stringFromDate:obj.dateOfBirth]);
    }
    
    //----------
    //end of Student
    
    //Master
    self.acceleratedDate=[NSDate date];
    //NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(happyBirthday:) userInfo:arrayOfStudents repeats:YES];
    NVStudent* theYoungest=[arrayOfStudents lastObject];
    NVStudent* theOldest=[arrayOfStudents firstObject];
    
    //the oldest vs the youngest:
    
    NSDateComponents* comp=[calendar components:NSCalendarUnitYear |
                                                NSCalendarUnitMonth |
                                                NSCalendarUnitWeekOfMonth |
                            NSCalendarUnitDay fromDate:theOldest.dateOfBirth toDate:theYoungest.dateOfBirth options:0];
    NSLog(@"the oldest person older the youngest on %ld years %ld month %ld weeks %ld days",comp.year,comp.month,comp.weekOfMonth,comp.day);
    
    //----------
    //end of Master
    
    //Superman
    //13:
    NSDateFormatter *formatter2=[[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"cccc"];
    
    NSDateComponents *dateComp=[[NSDateComponents alloc]init];
    dateComp.year=currentYear;
    dateComp.day=1;
    for (NSInteger i=1;i<13;i++){
        dateComp.month=i;
        NSDate* date1 = [calendar dateFromComponents:dateComp];
        NSLog(@"%@",[formatter2 stringFromDate:date1]);
    }
    
    //14:
    
    NSDateFormatter *formatter3=[[NSDateFormatter alloc]init];
    [formatter3 setDateFormat:@"dd.MM.yyyy"];
    NSDateComponents *allSundays=[[NSDateComponents alloc]init];
    allSundays.year=currentYear;
    allSundays.month=1;
    allSundays.weekday=1;//1, because sunday,monday,...,saturday
    allSundays.weekdayOrdinal=1;
    NSDate *dateOfFirstSunday=[calendar dateFromComponents:allSundays];
    while ([calendar component:NSCalendarUnitYear fromDate:dateOfFirstSunday]<currentYear+1) {
        NSLog(@"sunday:%@",[formatter3 stringFromDate:dateOfFirstSunday]);
        dateOfFirstSunday=[calendar dateByAddingUnit:NSCalendarUnitWeekOfMonth value:1 toDate:dateOfFirstSunday options:0];
    }
    
    //15:
    NSDateComponents *firstSundayInMonth=[[NSDateComponents alloc]init];
    firstSundayInMonth.year=currentYear;
    firstSundayInMonth.month=1;
    firstSundayInMonth.weekday=1;//1, because sunday,monday,...,saturday
    firstSundayInMonth.weekdayOrdinal=1;
    NSDate *dateOfSunday=[calendar dateFromComponents:firstSundayInMonth];
    
    NSDateComponents *firstSaturdayInMonth=[[NSDateComponents alloc]init];
    firstSaturdayInMonth.year=currentYear;
    firstSaturdayInMonth.month=1;
    firstSaturdayInMonth.weekday=7;//7, because sunday,monday,...,saturday
    firstSaturdayInMonth.weekdayOrdinal=1;
    NSDate *dateOfSaturday=[calendar dateFromComponents:firstSaturdayInMonth];
    
     for (NSInteger i=1;i<13;i++){
         NSInteger countWeekend=0;
         NSRange rangeOfDaysInMonth= [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateOfSunday];
         NSInteger numberOfDaysInMonth=rangeOfDaysInMonth.length;
        while ([calendar component:NSCalendarUnitMonth fromDate:dateOfSunday]<i+1 &&
               [calendar component:NSCalendarUnitYear fromDate:dateOfSunday]==currentYear) {
            dateOfSunday=[calendar dateByAddingUnit:NSCalendarUnitWeekOfMonth value:1 toDate:dateOfSunday options:0];
            countWeekend++;
        }
         while ([calendar component:NSCalendarUnitMonth fromDate:dateOfSaturday]<i+1 &&
                [calendar component:NSCalendarUnitYear fromDate:dateOfSaturday]==currentYear) {
             dateOfSaturday=[calendar dateByAddingUnit:NSCalendarUnitWeekOfMonth value:1 toDate:dateOfSaturday options:0];
             countWeekend++;
         }
         NSLog(@"In %ld month %ld business days",i,numberOfDaysInMonth- countWeekend);
         
    }
    //----------
    //end of Superman
      return YES;
    
}
-(void) happyBirthday:(NSTimer*) timer{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    self.acceleratedDate=[calendar dateByAddingUnit:NSCalendarUnitDay value:2 toDate:self.acceleratedDate options:0];
    for (NVStudent *obj in timer.userInfo){
        
        NSInteger currentAcceleratedDay=[calendar component:NSCalendarUnitDay fromDate:self.acceleratedDate];
        NSInteger currentAcceleratedMonth=[calendar component:NSCalendarUnitMonth fromDate:self.acceleratedDate];
        NSInteger studentDayOfBirth=[calendar component:NSCalendarUnitDay fromDate:obj.dateOfBirth];
        NSInteger studentMonthOfBirth=[calendar component:NSCalendarUnitMonth fromDate:obj.dateOfBirth];
        NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"dd.MM.yyyy";
        if (currentAcceleratedDay==studentDayOfBirth && currentAcceleratedMonth==studentMonthOfBirth) {
            NSLog(@"Happy Birthday dear %@ %@ today:%@ birthday:%@",obj.firstname,obj.lastname,[formatter stringFromDate:self.acceleratedDate],[formatter stringFromDate:obj.dateOfBirth]);
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
