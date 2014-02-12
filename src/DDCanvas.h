/**
 * @class   DDCanvas
 * @author  Alex Cummaudo
 * @date    11 Sep 2013
 * @brief   Defines the class of the canvas object which
 *          holds all graphical objects
 */

#import <Foundation/Foundation.h>

// Forward reference classes referenced in interface
@class DDHud, DDSprite;

@interface DDCanvas : NSObject
{
    // Declare ivars
    NSMutableArray*         _sprites;   //!< Defines a collection of sprites that the canvas
                                        //!< will draw when it is asked to draw
    DDHud*                  _hud;       //!< Defines the HUD that the canvas will draw when
                                        //!< it is asked to draw
}

// Declare methods
-(id)   init;
-(void) addSprite:(DDSprite*) sprite;
-(void) removeSprite:(DDSprite*) sprite;
-(id)   getSprite:(Class) class;
-(void) drawWithItems:(NSDictionary*) data;
-(void) drawDebug;

@end
