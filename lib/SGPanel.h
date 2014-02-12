#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"
#import "PointerManager.h"


@interface SGPanel : NSObject <PointerWrapper>
{
@package
    panel pointer;
}

+ (NSArray *) arrayOfPanels:(panel *)firstPtr size:(int)sz;
+ (void) getPanels:(panel *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz;
+ (id)createWithId:(panel)ptr;

- (id)initWithId:(panel)ptr; 

- (id)initFromFile:(NSString *)filename;
- (id)initWithName:(NSString *)name  fromFile:(NSString *)filename;


#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) BOOL active;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) BOOL clicked;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) BOOL draggable;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) NSString * fileName;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) int height;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) BOOL isDragging;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) NSString * name;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) BOOL visible;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) int width;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) float x;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) float y;
#endif


#if OBJC_NEW_PROPERTIES != 1
- (BOOL)active;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (BOOL)clicked;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (BOOL)draggable;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setDraggable:(BOOL)b;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (NSString *)fileName;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)height;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (BOOL)isDragging;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (NSString *)name;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (BOOL)visible;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)width;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (float)x;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (float)y;
#endif
- (void)activate;
- (int)activeRadioButtonIndexWithID:(NSString *)id;
- (BOOL)checkboxStateWithId:(NSString *)s;
- (void)deactivate;
- (void)hide;
- (void)move:(SGVector *)mvmt;
- (BOOL)pointInRegion:(SGPoint2D *)pt;
- (BOOL)point:(SGPoint2D *)pt  inRegionKind:(guielement_kind)kind;
- (SGRegion *)regionWithID:(NSString *)ID;
- (void)selectRadioButton:(NSString *)id;
- (void)show;
- (void)showDialog;
- (void)toggleActivate;
- (void)toggleCheckBoxWithID:(NSString *)id;
- (void)toggleVisible;
- (void)free;
@end
