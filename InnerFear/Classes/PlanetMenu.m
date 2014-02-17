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
    
    SPQuad* bgmask = [[SPQuad alloc] initWithWidth:background.width height:background.height color:0x000000];
    bgmask.alpha = 0.75;
    [self addChild:bgmask];
    
    SPTextField *textField = [SPTextField textFieldWithWidth:100 height:50
                                                        text:@"Close" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    textField.x = 0;
    textField.y = Sparrow.stage.height - 50;
    textField.hAlign = SPHAlignCenter;  // horizontal alignment
    textField.vAlign = SPVAlignCenter; // vertical alignment
    
    [self addChild:textField];
    
    __block PlanetMenu* that = self;
    __block SPTextField* closeField = textField;
    [textField addEventListenerForType:SP_EVENT_TYPE_TOUCH block:^(SPTouchEvent* event) {
        SPTouch *endTouch = [[event touchesWithTarget:closeField andPhase:SPTouchPhaseEnded] anyObject];
        
        if (endTouch) {
            [that removeFromParent];
            [self.planet removeEventListener:@selector(planetUpdated:) atObject:self forType:EVENT_TYPE_PLANET_FACTORY_UPDATE];
        }
    }];
    
    double rightcolumnwidth = 150.0;
    
    self.sapphireCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"0: Sapphire" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.sapphireCount.x = Sparrow.stage.width - rightcolumnwidth;
    self.sapphireCount.y = 50;
    self.sapphireCount.hAlign = SPHAlignRight;  // horizontal alignment
    [self addChild:self.sapphireCount];
        [self.sapphireCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    self.babylonCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"0: Babylon" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.babylonCount.x = Sparrow.stage.width - rightcolumnwidth;
    self.babylonCount.y = 100;
    self.babylonCount.hAlign = SPHAlignRight;  // horizontal alignment
    [self addChild:self.babylonCount];
        [self.babylonCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    
    self.makoCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"0: Mako" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.makoCount.x = Sparrow.stage.width - rightcolumnwidth;
    self.makoCount.y = 150;
    self.makoCount.hAlign = SPHAlignRight;  // horizontal alignment
    [self addChild:self.makoCount];
            [self.makoCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    self.fleetSapphireCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"Sapphire: 0" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.fleetSapphireCount.x = 0;
    self.fleetSapphireCount.y = 50;
    self.fleetSapphireCount.hAlign = SPHAlignLeft;  // horizontal alignment
    [self addChild:self.fleetSapphireCount];
            [self.fleetSapphireCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    self.fleetBabylonCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"Babylon: 0" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.fleetBabylonCount.x = 0;
    self.fleetBabylonCount.y = 100;
    self.fleetBabylonCount.hAlign = SPHAlignLeft;  // horizontal alignment
    [self addChild:self.fleetBabylonCount];
            [self.fleetBabylonCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    self.fleetMakoCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"Mako: 0" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.fleetMakoCount.x = 0;
    self.fleetMakoCount.y = 150;
    self.fleetMakoCount.hAlign = SPHAlignLeft;  // horizontal alignment
    [self addChild:self.fleetMakoCount];
            [self.fleetMakoCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    
    
    [self.planet addEventListener:@selector(planetUpdated:) atObject:self forType:EVENT_TYPE_PLANET_FACTORY_UPDATE];
}

- (void) planetUpdated: (SPEvent*) event
{
    NSArray* makoships = [self.planet makoShips];
    NSArray* sapphireships = [self.planet sapphireShips];
    NSArray* babylonships = [self.planet babylonShips];
    
    NSArray* fleetMakoships = [[Game instance].player makoShips];
    NSArray* fleetSapphireships = [[Game instance].player sapphireShips];
    NSArray* fleetBabylonships = [[Game instance].player babylonShips];
    
    self.sapphireCount.text = [NSString stringWithFormat:@"%d: Sapphire", sapphireships.count];
    self.makoCount.text = [NSString stringWithFormat:@"%d: Mako", makoships.count];
    self.babylonCount.text = [NSString stringWithFormat:@"%d: Babylon", babylonships.count];
    
    self.fleetSapphireCount.text = [NSString stringWithFormat:@"Sapphire: %d", fleetSapphireships.count];
    self.fleetMakoCount.text = [NSString stringWithFormat:@"Mako: %d", fleetMakoships.count];
    self.fleetBabylonCount.text = [NSString stringWithFormat:@"Babylon: %d", fleetBabylonships.count];
}

- (void) shipTouch: (SPTouchEvent*) event
{
    SPTouch* planetSapphire = [[event touchesWithTarget:self.sapphireCount andPhase:SPTouchPhaseEnded] anyObject];
    SPTouch* planetBabylon = [[event touchesWithTarget:self.babylonCount andPhase:SPTouchPhaseEnded] anyObject];
    SPTouch* planetMako = [[event touchesWithTarget:self.makoCount andPhase:SPTouchPhaseEnded] anyObject];
    SPTouch* fleetSapphire = [[event touchesWithTarget:self.fleetSapphireCount andPhase:SPTouchPhaseEnded] anyObject];
    SPTouch* fleetBabylon = [[event touchesWithTarget:self.fleetBabylonCount andPhase:SPTouchPhaseEnded] anyObject];
    SPTouch* fleetMako = [[event touchesWithTarget:self.fleetMakoCount andPhase:SPTouchPhaseEnded] anyObject];
    Ship* moveship = nil;
    if (planetBabylon)
    {
        moveship = [self.planet popBabylon];
        if (moveship)
        {
            [[Game instance].player.ships addObject: moveship];
        }
    }
    else if (planetMako)
    {
        moveship = [self.planet popMako];
        if (moveship)
        {
            [[Game instance].player.ships addObject: moveship];
        }

    }
    else if (planetSapphire)
    {
        moveship = [self.planet popSapphire];
        if (moveship)
        {
            [[Game instance].player.ships addObject: moveship];
        }

    }
    else if (fleetBabylon)
    {
        moveship = [[Game instance].player popBabylon];
        if (moveship)
        {
            [self.planet.ships addObject: moveship];
        }
    }
    else if (fleetMako)
    {
        moveship = [[Game instance].player popMako];
        if (moveship)
        {
            [self.planet.ships addObject: moveship];
        }

    }
    else if (fleetSapphire)
    {
        moveship = [[Game instance].player popSapphire];
        if (moveship)
        {
            [self.planet.ships addObject: moveship];
        }

    }
    
    [self planetUpdated: nil];
}

@end
