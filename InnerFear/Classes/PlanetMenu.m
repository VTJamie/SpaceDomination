//
//  PlanetMenu.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/10/14.
//
//

#import "PlanetMenu.h"
#import "Media.h"

@implementation PlanetMenu

- (id)initWithPlanet: (Planet*) planet
{
    if ((self = [super init]))
    {
        self.planet = planet;
        [self setup];
    }
    
    return self;
}

- (void)dealloc
{
    // release any resources here
    
}

- (void)setup
{
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"spacedock.png"];
    background.pivotX = 0;
    background.pivotY = 0;
    background.x = 0;
    background.y = 0;
    background.scaleX = Sparrow.stage.width / background.width ;
    background.scaleY = Sparrow.stage.height / background.height;
    //NSLog(@"%f, %f", background.width, background.height);
    [self addChild:background];
    
    
    SPImage *menubutton = [[SPImage alloc] initWithTexture: [Media atlasTexture:@"circuit"]];
    menubutton.pivotX = 0;
    menubutton.pivotY = 0;
    menubutton.x = 0;
    menubutton.y = 0;
    menubutton.scaleX = 200 / menubutton.width;
    menubutton.scaleY = 200 / menubutton.width;
    menubutton.alpha = 0.5;
    [self addChild:menubutton];
    
    __block PlanetMenu* that = self;
    [self addEventListenerForType:SP_EVENT_TYPE_TOUCH block:^(SPTouchEvent* event) {
        SPTouch *endTouch = [[event touchesWithTarget:menubutton andPhase:SPTouchPhaseEnded] anyObject];
        
        if (endTouch) {
            [that removeFromParent];
        }
    }];
    
    
}

@end
