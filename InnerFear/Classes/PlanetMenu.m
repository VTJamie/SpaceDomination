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
    menubutton.scaleY = 100 / menubutton.width;
    menubutton.scaleX = 100 / menubutton.width;
    menubutton.x = 0;
    menubutton.y = Sparrow.stage.height - menubutton.height;
    menubutton.alpha = 0.75;
    [self addChild:menubutton];
    
    SPTextField *textField = [SPTextField textFieldWithWidth:menubutton.width height:menubutton.height
                                                        text:@"Close" fontName:@"Helvetica" fontSize:12.0f color:0xff0000];
    textField.x = 0;
    textField.y = Sparrow.stage.height - menubutton.height;
    textField.hAlign = SPHAlignCenter;  // horizontal alignment
    textField.vAlign = SPVAlignCenter; // vertical alignment
    
    [self addChild:textField];
    
    __block PlanetMenu* that = self;
    __block SPTextField* closeField = textField;
    [textField addEventListenerForType:SP_EVENT_TYPE_TOUCH block:^(SPTouchEvent* event) {
        SPTouch *endTouch = [[event touchesWithTarget:closeField andPhase:SPTouchPhaseEnded] anyObject];
        
        if (endTouch) {
            [that removeFromParent];
        }
    }];
    
    
}

@end
