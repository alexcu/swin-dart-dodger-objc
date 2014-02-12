#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"
#import "PointerManager.h"


@interface SGRegion : NSObject <PointerWrapper>
{
@package
    region pointer;
}

+ (NSArray *) arrayOfRegions:(region *)firstPtr size:(int)sz;
+ (void) getRegions:(region *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz;
+ (id)createWithId:(region)ptr;

- (id)initWithId:(region)ptr; 



#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) BOOL checkboxState;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) int height;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) NSString * iD;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) SGGUIList * list;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) int listActiveItemIndex;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) SGFont * listFont;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) font_alignment listFontAlignment;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) int listItemCount;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) NSString * listItemText;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) int listStartAt;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) SGPanel * parentPanel;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) BOOL regionActive;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) SGFont * textboxFont;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) NSString * textboxText;
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
- (BOOL)checkboxState;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setCheckboxState:(BOOL)val;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)height;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (NSString *)iD;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (SGGUIList *)list;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)listActiveItemIndex;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (SGFont *)listFont;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (font_alignment)listFontAlignment;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setListFontAlignment:(font_alignment)align;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)listItemCount;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (NSString *)listItemText;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)listStartAt;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setListStartAt:(int)idx;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (SGPanel *)parentPanel;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (BOOL)regionActive;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setRegionActive:(BOOL)b;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (SGFont *)textboxFont;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (NSString *)textboxText;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setTextboxText:(NSString *)s;
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
- (void)addBitmapCell:(SGBitmapCell *)img;
- (void)addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text;
- (void)listAddBitmap:(SGBitmap *)img  andText:(NSString *)text;
- (void)listAddBitmapItem:(SGBitmap *)img;
- (void)listAddTextItem:(NSString *)text;
- (void)listClearItems;
- (NSString *)listItemTextAtIndex:(int)idx;
- (void)listRemoveActiveItem;
- (void)registerEventCallback:(guievent_callback)callback;
- (void)toggleActive;
@end
