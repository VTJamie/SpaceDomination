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
@property (nonatomic, assign) double shieldRegenerateEnhancement;
@property (nonatomic, assign) double accuracyEnhancement;

@property (nonatomic, assign) double attackPowerBoost;
@property (nonatomic, assign) double attackSpeedBoost;
@property (nonatomic, assign) double shieldRegenerateBoost;
@property (nonatomic, assign) double accuracyBoost;



@property (nonatomic, assign) double attackTimeTracker;
@property (nonatomic, assign) double shieldRegenerateTracker;

- (void) advanceShieldRegeneration: (double) timepassed;
- (BOOL) advanceFight: (Ship*) target timepassed: (double) timepassed;

@end
