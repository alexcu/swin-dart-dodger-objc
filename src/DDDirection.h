/**
 * @author  Alex Cummaudo
 * @typedef DDDirection
 * @date    12 Sep 2013
 * @brief   Defines the direction enumeration.
 */

// Direction type definition
typedef enum DDDirection //! Directional type definitions
{
    DDLEFT,     //!< Left direction
    DDRIGHT,    //!< Right direction
    DDUP,       //!< Upwards direction
    DDDOWN,     //!< Downwards direction
    DDX,        //!< X-axis direction (both Left and Right directions)
    DDY         //!< Y-axis direction (both Upwards and Downwards directions)
}
DDDirection;
