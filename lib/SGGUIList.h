#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"
#import "PointerManager.h"


@interface SGGUIList : NSObject <PointerWrapper>
{
@package
    guilist pointer;
}

+ (NSArray *) arrayOfGUILists:(guilist *)firstPtr size:(int)sz;
+ (void) getGUILists:(guilist *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz;
+ (id)createWithId:(guilist)ptr;

- (id)initWithId:(guilist)ptr; 



#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) int activeItemIndex;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) NSString * activeItemText;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) SGFont * font;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) font_alignment fontAlignment;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) int itemCount;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) int largestStartIndex;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) int scrollIncrement;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) int startAt;
#endif


#if OBJC_NEW_PROPERTIES != 1
- (int)activeItemIndex;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setActiveItemIndex:(int)idx;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (NSString *)activeItemText;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (SGFont *)font;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setFont:(SGFont *)f;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (font_alignment)fontAlignment;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setFontAlignment:(font_alignment)align;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)itemCount;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)largestStartIndex;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)scrollIncrement;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)startAt;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setStartAt:(int)idx;
#endif
- (void)addBitmapItem:(SGBitmap *)img;
- (void)addImg:(SGBitmap *)img  andText:(NSString *)text;
- (void)addBitmapCell:(SGBitmapCell *)img;
- (void)addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text;
- (void)addTextItem:(NSString *)text;
- (int)bitmapItemIndex:(SGBitmap *)img;
- (int)cellItemIndex:(SGBitmapCell *)img;
- (void)clearItems;
- (int)indexOfTextItem:(NSString *)value;
- (NSString *)itemTextAtIndex:(int)idx;
- (void)removeItem:(int)idx;
@end
