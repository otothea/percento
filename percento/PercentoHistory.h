//
//  PercentoHistory.h
//  percento
//
//  Created by Oscar Armstrong on 11/2/12.
//  Copyright (c) 2012 Oscar Armstrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PercentoHistory : NSManagedObject

@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSString * date;

@end
