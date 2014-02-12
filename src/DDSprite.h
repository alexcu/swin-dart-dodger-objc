/**
 * @class   DDSprite
 * @author  Alex Cummaudo
 * @date    10 Sep 2013
 * @brief   Defines the parent class for all drawable
 *          sprites.
 */

#import <Foundation/Foundation.h>

// Import DDDirection Enumeration
#import "DDDirection.h"

// Forward reference classes referenced in interface
@class SGPoint2D, SGBitmap;
@class DDGame;

@interface DDSprite : NSObject
{
    // Declare ivars
    SGBitmap*   _bitmap;    //!< The SwinGame bitmap that is drawn to the screen on the
                            //!< invocation of this sprite's draw method
    SGPoint2D*  _position;  //!< Defines the current position of this sprite on the screen
                            //!< where the origin is at the top left of the bitmap
    DDGame*     _game;      //!< Defines the current game this sprite exists within
}

// Declare properties
@property (readonly)  SGPoint2D* position;  //!< Readwrite access to the position of
                                            //!< this sprite, used by children of
                                            //!< DDSprites---no protected scope in Obj-C
@property (readonly)  SGPoint2D* centre;    //!< Calculates the centre of the position
                                            //!< relative to the centrepoint of the bitmap
                                            //!< via the centre method, used by:
                                            //!<   - children, such as DDBalloon
                                            //!<     and DDBackground to work out positioning
                                            //!<     in some of their methods
                                            //!<   - DDCanvas in debug mode to label the name
                                            //!<     and other details of the sprite under
                                            //!<     its centre

// Declare methods
-(id)   initWithBitmapFile:(NSString*)fileName atX:(int)xPos atY:(int)yPos
                    inGame:(DDGame*)game;
-(id)   initWithBitmapFile:(NSString*)fileName atStaticX:(int)xPos inGame:(DDGame*) game;
-(id)   initWithBitmapFile:(NSString*)fileName atStaticY:(int)yPos inGame:(DDGame*) game;
-(void) kill;
-(void) draw;

@end
