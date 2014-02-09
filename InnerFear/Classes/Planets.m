//
//  Planets.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "Planets.h"
#import "CenterChangeEvent.h"
#import "Planet.h"

@implementation Planets


- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)setup
{
    for( int i = 0; i < 100; i++)
    {
        [self addChild:[[Planet alloc] init]];
    }
}

- (void) onCenterChange: (CenterChangeEvent*) event
{
 
}


@end
