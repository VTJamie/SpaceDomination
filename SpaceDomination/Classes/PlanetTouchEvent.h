//
//  PlanetTouchEvent.h
//  SpaceDomination
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "SPEvent.h"
#import "Planet.h"

@interface PlanetTouchEvent : SPEvent

@property (nonatomic, retain) Planet* planet;

@end
