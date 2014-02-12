/**
 * @class   DDController
 * @author  Alex Cummaudo
 * @date    11 Sep 2013
 * @brief   Defines the class of the controller object
 *          which is responsible for the entire app (both
 *          in-game and non-in-game elements)
 */

#import <Foundation/Foundation.h>

// Forward reference classes referenced in interface
@class DDCanvas, DDGame;

@interface DDController : NSObject
{
    // Declare ivars
    DDCanvas*       _menuCanvas;    //!< Canvas for menu-only items to be drawn on
    int             _highScore;     //!< High score value loaded on controller initialisation
}

// Declare methods
-(id)   init;
-(void) update;
-(void) newGame;
+(void) killGame;

@end
