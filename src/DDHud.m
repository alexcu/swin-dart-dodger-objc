/**
 * @class   DDHud
 * @author  Alex Cummaudo
 * @date    11 Sep 2013
 * @brief   Defines the HUD class, which contains elements
 *          to be drawn for information relay to the player
 */

// Import SwinGame Framework
#import "SwinGame.h"

// Import my interface
#import "DDHud.h"

@implementation DDHud

/**
 * @brief   The constructor for DDHud which intialises
 *          the font fields
 * @return  The class's self pointer
 */
-(id) init {
    if (self = [super init])
    {
        _smallFnt = [SGText loadFontFile:@"BitxMap.ttf" size:20];
        _largeFnt = [SGText loadFontFile:@"edunline.ttf" size:65];
    }
    return self;
}

/**
 * @brief   The draw method will vary depending on the
 *          _displayItems that need to be drawn
 * @param   items
 *          The dictionary of key/value pairs that will
 *          be added to the HUD (where key references position
 *          and value is the value to be drawn)
 */
-(void) drawWithItems:(NSDictionary*) items
{
    NSString* left          = [items objectForKey:@"left"];
    NSString* right         = [items objectForKey:@"right"];
    NSString* center        = [items objectForKey:@"center"];
    NSString* menu          = [items objectForKey:@"menu"];
    NSString* backCol       = [items objectForKey:@"backCol"];
    
    // Clear screen to back col if existing
    if ([backCol  isEqual: @"red"])  { [SGGraphics clearScreen:ColorRed];  }
    if ([backCol  isEqual: @"blue"]) { [SGGraphics clearScreen:ColorBlue]; }
    
    // Standard black box at bottom of screen
    [SGGraphics fill:ColorBlack
  rectangleOnScreenX:0
                   y:[SGGraphics screenHeight] -35
               width:[SGGraphics screenWidth]
              height:35];
    
    // If left string exists
    if (left)
    {
        [SGText drawText:left
                   color:ColorWhite
                    font:_smallFnt
                       x:30
                       y:[SGGraphics screenHeight] - 30];
        
    }
    
    // If right string exists
    if (right)
    {
        [SGText drawText:right
                   color:ColorWhite
                    font:_smallFnt
                       x:[SGGraphics screenWidth] - 120
                       y:[SGGraphics screenHeight] - 30];
    }
    
    // If centre string exists
    if (center)
    {
        [SGGraphics fill:ColorBlack
      rectangleOnScreenX:55
                       y:210
                   width:285
                  height:75];
        [SGText drawText:center
                   color:ColorWhite
                    font:_smallFnt
                       x:105
                       y:235];
    }
    
    // If menu is true
    if (menu)
    {
        SGColors* rndCol = [SGGraphics randomRGBColor:8];
        
        [SGGraphics fill:ColorBlack
      rectangleOnScreenX:55
                       y:145
                   width:285
                  height:200];
        [SGText drawText:@"DART"
                   color:rndCol
                    font:_largeFnt
            onScreenAtPt:[SGGeometry pointAtX:125 y:165]];
        [SGText drawText:@"DODGER"
                   color:rndCol
                    font:_largeFnt
            onScreenAtPt:[SGGeometry pointAtX:87 y:165+50]];
        
        [SGText drawText:@"Press P to Play / Pause"
                   color:ColorWhite
                    font:_smallFnt
            onScreenAtPt:[SGGeometry pointAtX:80 y:300]];

        // Delay for flashy colours
        [SGUtils delay:120];
    }
}

@end
