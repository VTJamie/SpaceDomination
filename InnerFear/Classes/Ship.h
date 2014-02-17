//
//  Ship.h
//  InnerFear
//
//  Created by Jamieson Abbott on 2/16/14.
//
//

#import <Foundation/Foundation.h>

@interface Ship : NSObject

@property (nonatomic, assign) double attackPower;
@property (nonatomic, assign) double attackSpeed;
@property (nonatomic, assign) double maxShields;
@property (nonatomic, assign) double currentShields;
@property (nonatomic, assign) double accuracy;
@property (nonatomic, assign) double cost;

@property (nonatomic, assign) double attackPowerEnhancement;
@property (nonatomic, assign) double attackSpeedEnhancement;
@property (nonatomic, assign) double maxShieldsEnhancement;
@property (nonatomic, assign) double accuracyEnhancement;


@property (nonatomic, assign) double timeelapsed;

- (BOOL) advanceFight: (Ship*) target timepassed: (double) timepassed;

@end
