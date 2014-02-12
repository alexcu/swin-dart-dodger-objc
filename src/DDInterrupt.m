/**
 * @class   DDInterrupt
 * @author  Alex Cummaudo
 * @date    02 Oct 2013
 * @brief   Defines the class of interrupts which allow
 *          specific interrupts to occur anywhere when
 *          signalled in the program in any class
 */

// Import my interface
#import "DDInterrupt.h"

// Import interfaces of other classes used
#import "DDController.h"

@implementation DDInterrupt

/**
 * @brief   The killGame interrupt signals the DDController
 *          to destroy its current game and set its game to
 *          false, thereby returning the player back to the
 *          main menu (i.e. at the end of a game etc.)
 * @note    This method is called directly on this class (i.e.,
 *          [DDController killGame];)
 */
+(void) killGame
{
    [DDController killGame];
}

@end
