//
//  TimeFactory.h
//  InnerFear
//
//  Created by Jamieson Abbott on 2/13/14.
//
//

#import <Foundation/Foundation.h>

@interface ShipFactory : NSObject



@property (nonatomic, assign) int unitSize;
@property (nonatomic, assign) double timeForUnit;
@property (nonatomic, assign) double currentTime;
@property (nonatomic, assign) double accumulatedUnits;
@property (nonatomic, retain) NSMutableArray* shiporder;


- (id) initWithTimeForUnit: (double) timeForUnit unitSize: (int) unitSize;
- (int) getUnit: (double) timePassed;
- (NSArray*) getBuildUnits: (double) timePassed;

@end
