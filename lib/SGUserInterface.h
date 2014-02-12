#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"
#import "SGPoint2D.h"
#import "SGVector.h"
#import "SGRectangle.h"
#import "SGFinger.h"
#import "SGResolution.h"
#import "SGCircle.h"
#import "SGAccelerometerMotion.h"
#import "SGLineSegment.h"
#import "SGTriangle.h"
#import "SGSoundEffect.h"
#import "SGMusic.h"
#import "SGMatrix2D.h"
#import "SGAnimationScript.h"
#import "SGAnimation.h"
#import "SGBitmap.h"
#import "SGBitmapCell.h"
#import "SGSprite.h"
#import "SGTimer.h"
#import "SGFont.h"
#import "SGDirectionAngles.h"
#import "SGCharacter.h"
#import "SGGUIList.h"
#import "SGGUILabel.h"
#import "SGGUICheckbox.h"
#import "SGPanel.h"
#import "SGRegion.h"
#import "SGGUITextbox.h"
#import "SGGUIRadioGroup.h"
#import "SGConnection.h"
#import "SGArduinoDevice.h"


@interface SGUserInterface : NSObject
{
  
}

+ (void)activatePanel:(SGPanel *)p;
+ (SGRegion *)activeRadioButton:(SGGUIRadioGroup *)grp;
+ (SGRegion *)activeRadioButtonWithID:(NSString *)id;
+ (SGRegion *)activeRadioButtonOnPanel:(SGPanel *)pnl  withId:(NSString *)id;
+ (int)activeRadioButtonIndex:(SGGUIRadioGroup *)RadioGroup;
+ (int)activeRadioButtonIndexFromID:(NSString *)id;
+ (int)activeRadioButtonIndexOnPanel:(SGPanel *)pnl  withId:(NSString *)id;
+ (SGPanel *)activeTextBoxParent;
+ (int)activeTextIndex;
+ (BOOL)buttonNamedClicked:(NSString *)name;
+ (BOOL)buttonClicked:(SGRegion *)r;
+ (SGGUICheckbox *)checkboxFromRegion:(SGRegion *)r;
+ (void)checkBox:(SGGUICheckbox *)chk  setCheckBoxState:(BOOL)val;
+ (void)checkbox:(NSString *)id  setState:(BOOL)val;
+ (void)region:(SGRegion *)r  setCheckBotState:(BOOL)val;
+ (void)checkboxOnPanel:(SGPanel *)pnl  withID:(NSString *)id  setState:(BOOL)val;
+ (BOOL)checkboxStateFromRegion:(SGRegion *)r;
+ (BOOL)checkboxState:(NSString *)s;
+ (BOOL)checkboxStateFromCheckbox:(SGGUICheckbox *)chk;
+ (BOOL)panel:(SGPanel *)p  checkboxStateForId:(NSString *)s;
+ (void)deactivatePanel:(SGPanel *)p;
+ (void)deactivateTextBox;
+ (BOOL)dialogCancelled;
+ (BOOL)dialogComplete;
+ (NSString *)dialogPath;
+ (void)dialogSetPath:(NSString *)fullname;
+ (void)drawGUIAsVectors:(BOOL)b;
+ (void)drawInterface;
+ (void)finishReadingText;
+ (void)freePanel:(SGPanel *)pnl;
+ (BOOL)gUIClicked;
+ (void)gUISetActiveTextboxFromRegion:(SGRegion *)r;
+ (void)gUISetActiveTextboxNamed:(NSString *)name;
+ (void)gUISetActiveTextbox:(SGGUITextbox *)t;
+ (void)gUISetBackgroundColor:(color)c;
+ (void)gUISetBackgroundColorInactive:(color)c;
+ (void)gUISetForegroundColor:(color)c;
+ (void)gUISetForegroundColorInactive:(color)c;
+ (SGGUITextbox *)gUITextBoxOfTextEntered;
+ (BOOL)gUITextEntryComplete;
+ (BOOL)hasPanel:(NSString *)name;
+ (void)hidePanelNamed:(NSString *)name;
+ (void)hidePanel:(SGPanel *)p;
+ (int)indexOfLastUpdatedTextBox;
+ (BOOL)isDragging;
+ (BOOL)panelIsDragging:(SGPanel *)pnl;
+ (font_alignment)labelAlignementFromRegion:(SGRegion *)r;
+ (font_alignment)labelAlignment:(SGGUILabel *)lbl;
+ (SGFont *)labelFromRegionGetFont:(SGRegion *)r;
+ (SGFont *)labelFont:(SGGUILabel *)l;
+ (SGGUILabel *)labelFromRegion:(SGRegion *)r;
+ (void)labelFromRegion:(SGRegion *)r  setAlignment:(font_alignment)align;
+ (void)label:(SGGUILabel *)tb  setAlignment:(font_alignment)align;
+ (void)label:(SGGUILabel *)l  setFont:(NSString *)s;
+ (void)label:(SGGUILabel *)lb  setText:(NSString *)newString;
+ (void)labelForRegion:(SGRegion *)r  setText:(NSString *)newString;
+ (void)labelWithId:(NSString *)id  setText:(NSString *)newString;
+ (void)labelOnPanel:(SGPanel *)pnl  withId:(NSString *)id  setText:(NSString *)newString;
+ (NSString *)labelTextFromRegion:(SGRegion *)r;
+ (NSString *)labelText:(SGGUILabel *)lb;
+ (NSString *)labelTextWithId:(NSString *)id;
+ (NSString *)textOfLabelOnPanel:(SGPanel *)pnl  withId:(NSString *)id;
+ (int)listActiveItemIndex:(SGGUIList *)lst;
+ (int)listActiveItemIndexWithId:(NSString *)id;
+ (int)listActiveItemIndexFromRegion:(SGRegion *)r;
+ (int)listActiveItemIndexOnPanel:(SGPanel *)pnl  withId:(NSString *)id;
+ (NSString *)listActiveItemText:(SGGUIList *)list;
+ (NSString *)listActiveItemTextFromRegion:(SGRegion *)r;
+ (NSString *)listWithIdActiveItemText:(NSString *)ID;
+ (NSString *)listActiveItemTextOnPanel:(SGPanel *)pnl  withId:(NSString *)ID;
+ (void)list:(SGGUIList *)lst  addBitmap:(SGBitmap *)img;
+ (void)listWithId:(NSString *)id  addBitmap:(SGBitmap *)img;
+ (void)list:(SGGUIList *)lst  addBitmapCell:(SGBitmapCell *)img;
+ (void)list:(SGGUIList *)lst  addText:(NSString *)text;
+ (void)listWithId:(NSString *)id  addText:(NSString *)text;
+ (void)listForRegion:(SGRegion *)r  addBitmap:(SGBitmap *)img;
+ (void)region:(SGRegion *)r  addBitmapCell:(SGBitmapCell *)img;
+ (void)listWithId:(NSString *)id  addBitmapCell:(SGBitmapCell *)img;
+ (void)listOfRegion:(SGRegion *)r  addText:(NSString *)text;
+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  addBitmap:(SGBitmap *)img;
+ (void)region:(SGRegion *)r  addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text;
+ (void)list:(SGGUIList *)lst  addItemBitmap:(SGBitmap *)img  withText:(NSString *)text;
+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  addBitmapCell:(SGBitmapCell *)img;
+ (void)listById:(NSString *)id  addBitmap:(SGBitmap *)img  andText:(NSString *)text;
+ (void)listForRegion:(SGRegion *)r  addBitmap:(SGBitmap *)img  andText:(NSString *)text;
+ (void)list:(SGGUIList *)lst  addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text;
+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  addText:(NSString *)text;
+ (void)listWithId:(NSString *)id  addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text;
+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text;
+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  addBitmap:(SGBitmap *)img  andText:(NSString *)text;
+ (int)list:(SGGUIList *)lst  indexOfBitmap:(SGBitmap *)img;
+ (int)list:(SGGUIList *)lst  indexOfCell:(SGBitmapCell *)img;
+ (void)listclearItemsWithId:(NSString *)id;
+ (void)listClearItems:(SGGUIList *)lst;
+ (void)listClearItemsFromRegion:(SGRegion *)r;
+ (void)clearItemsListOnPanel:(SGPanel *)pnl  withId:(NSString *)id;
+ (SGFont *)listFont:(SGGUIList *)lst;
+ (SGFont *)listFontFromRegion:(SGRegion *)r;
+ (font_alignment)listFontAlignment:(SGGUIList *)lst;
+ (font_alignment)listFontAlignmentFromRegion:(SGRegion *)r;
+ (SGGUIList *)listFromRegion:(SGRegion *)r;
+ (int)listItemCount:(SGGUIList *)lst;
+ (int)listItemCountFromRegion:(SGRegion *)r;
+ (int)listItemCountWithId:(NSString *)id;
+ (int)listItemCountFrom:(SGPanel *)pnl  withId:(NSString *)id;
+ (NSString *)listWithId:(NSString *)id  textAtIndex:(int)idx;
+ (NSString *)list:(SGGUIList *)lst  textAtIndex:(int)idx;
+ (NSString *)listForRegion:(SGRegion *)r  textAtIndex:(int)idx;
+ (NSString *)listOnPanel:(SGPanel *)pnl  withId :(NSString *)id  textAtIndex:(int)idx;
+ (int)listLargestStartIndex:(SGGUIList *)lst;
+ (void)listRemoveActiveItemFromRegion:(SGRegion *)r;
+ (void)listRemoveActiveItemFromId:(NSString *)id;
+ (void)listRemoveActiveItemOnPanel:(SGPanel *)pnl  withId:(NSString *)id;
+ (void)listWithId:(NSString *)id  removeItemAtIndex:(int)idx;
+ (void)list:(SGGUIList *)lst  removeItemAtIndex:(int)idx;
+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  removeItemAtIndex:(int)idx;
+ (int)listScrollIncrement:(SGGUIList *)lst;
+ (void)listSetActiveItemWithId:(NSString *)id  atIndex:(int)idx;
+ (void)list:(SGGUIList *)lst  setActiveItemIndex:(int)idx;
+ (void)listSetActiveItemFromPane:(SGPanel *)pnl  withId:(NSString *)id  at:(int)idx;
+ (void)list:(SGGUIList *)lst  setFont:(SGFont *)f;
+ (void)listForRegion:(SGRegion *)r  setFontAlignment:(font_alignment)align;
+ (void)list:(SGGUIList *)lst  setFontAlignment:(font_alignment)align;
+ (void)listForRegion:(SGRegion *)r  setStartat:(int)idx;
+ (void)list:(SGGUIList *)lst  setStartAt:(int)idx;
+ (int)listStartAt:(SGGUIList *)lst;
+ (int)listStartingAtFromRegion:(SGRegion *)r;
+ (int)list:(SGGUIList *)lst  indexOfText:(NSString *)value;
+ (SGPanel *)loadPanel:(NSString *)filename;
+ (SGPanel *)loadPanelNamed:(NSString *)name  fromFile:(NSString *)filename;
+ (void)panel:(SGPanel *)p  moveBy:(SGVector *)mvmt;
+ (SGPanel *)createPanelNamed:(NSString *)pnlName;
+ (BOOL)panelActive:(SGPanel *)pnl;
+ (SGPanel *)panelAtPoint:(SGPoint2D *)pt;
+ (SGPanel *)panelClicked;
+ (BOOL)panelWasClicked:(SGPanel *)pnl;
+ (BOOL)panelDraggable:(SGPanel *)p;
+ (NSString *)panelFilename:(SGPanel *)pnl;
+ (int)panelHeight:(SGPanel *)p;
+ (int)panelNamedHeight:(NSString *)name;
+ (NSString *)panelName:(SGPanel *)pnl;
+ (SGPanel *)panelNamed:(NSString *)name;
+ (void)panel:(SGPanel *)p  setDraggable:(BOOL)b;
+ (BOOL)panelVisible:(SGPanel *)p;
+ (int)panelNamedWidth:(NSString *)name;
+ (int)panelWidth:(SGPanel *)p;
+ (float)panelX:(SGPanel *)p;
+ (float)panelY:(SGPanel *)p;
+ (BOOL)pointInRegion:(SGPoint2D *)pt  ofPanel:(SGPanel *)p;
+ (BOOL)pointInRegion:(SGPoint2D *)pt  ofPanel:(SGPanel *)p  kind:(guielement_kind)kind;
+ (SGGUIRadioGroup *)radioGroupFromId:(NSString *)id;
+ (SGGUIRadioGroup *)radioGroupOnPanel:(SGPanel *)pnl  withId:(NSString *)id;
+ (SGGUIRadioGroup *)radioGroupFromRegion:(SGRegion *)r;
+ (BOOL)regionActive:(SGRegion *)forRegion;
+ (SGRegion *)regionOnPanel:(SGPanel *)p  atPoint:(SGPoint2D *)pt;
+ (SGRegion *)regionClicked;
+ (NSString *)regionClickedID;
+ (int)regionHeight:(SGRegion *)r;
+ (NSString *)regionID:(SGRegion *)r;
+ (SGRegion *)regionOfLastUpdatedTextBox;
+ (SGPanel *)regionPanel:(SGRegion *)r;
+ (int)regionWidth:(SGRegion *)r;
+ (SGRegion *)globalRegionWithID:(NSString *)ID;
+ (SGRegion *)regionOfPanel:(SGPanel *)pnl  withId:(NSString *)ID;
+ (float)regionX:(SGRegion *)r;
+ (float)regionY:(SGRegion *)r;
+ (void)region:(SGRegion *)r  registerEventCallback:(guievent_callback)callback;
+ (void)releaseAllPanels;
+ (void)releasePanel:(NSString *)name;
+ (void)selectRadioButton:(SGRegion *)r;
+ (void)selectRadioButtonWithID:(NSString *)id;
+ (void)radioGroup:(SGGUIRadioGroup *)rGroup  selectButton:(SGRegion *)r;
+ (void)radioButtonOnPanel:(SGPanel *)pnl  withId:(NSString *)id;
+ (void)radioGroup:(SGGUIRadioGroup *)rGroup  selectButtonIdx:(int)idx;
+ (void)region:(SGRegion *)forRegion  setActive:(BOOL)b;
+ (void)showOpenDialog;
+ (void)showOpenDialogWithType:(file_dialog_select_type)select;
+ (void)showPanel:(SGPanel *)p;
+ (void)showPanelNamed:(NSString *)name;
+ (void)showPanelDialog:(SGPanel *)p;
+ (void)showSaveDialog;
+ (void)showSaveDialogWithType:(file_dialog_select_type)select;
+ (SGFont *)textBoxFont:(SGGUITextbox *)tb;
+ (SGFont *)textBoxFontFromRegion:(SGRegion *)r;
+ (SGGUITextbox *)textBoxFromID:(NSString *)id;
+ (SGGUITextbox *)textboxFromRegion:(SGRegion *)r;
+ (NSString *)textBoxText:(SGGUITextbox *)tb;
+ (NSString *)textboxTextWithId:(NSString *)id;
+ (NSString *)textboxTextFromRegion:(SGRegion *)r;
+ (NSString *)textboxTextOnPanel:(SGPanel *)pnl  withId:(NSString *)id;
+ (font_alignment)textBoxAlignmentFromRegion:(SGRegion *)r;
+ (font_alignment)textboxAlignment:(SGGUITextbox *)tb;
+ (void)textboxForRegion:(SGRegion *)r  setAlignment:(font_alignment)align;
+ (void)textbox:(SGGUITextbox *)tb  setAlignment:(font_alignment)align;
+ (void)textbox:(SGGUITextbox *)Tb  setFont:(SGFont *)f;
+ (void)textboxForId:(NSString *)id  setInt:(int)i;
+ (void)textboxWithId:(NSString *)id  setFloat:(float)single;
+ (void)textboxForRegion:(SGRegion *)r  setText:(NSString *)s;
+ (void)textbox:(SGGUITextbox *)tb  setText:(NSString *)s;
+ (void)textboxWithId:(NSString *)id  setText:(NSString *)s;
+ (void)textboxForRegion:(SGRegion *)r  setInt:(int)i;
+ (void)textbox:(SGGUITextbox *)tb  setInt:(int)i;
+ (void)textbox:(SGGUITextbox *)tb  setFloat:(float)single;
+ (void)textboxForRegion:(SGRegion *)r  setFloat:(float)single;
+ (void)textboxOnPanel:(SGPanel *)pnl  withId:(NSString *)id  setText:(NSString *)s;
+ (void)textboxOnPanel:(SGPanel *)pnl  withId:(NSString *)id  setInt:(int)i;
+ (void)textboxOnPanel:(SGPanel *)pnl  withId:(NSString *)id  setFloat:(float)single;
+ (void)toggleActivatePanel:(SGPanel *)p;
+ (void)toggleCheckboxStateFromID:(NSString *)id;
+ (void)toggleCheckboxState:(SGGUICheckbox *)c;
+ (void)toggleCheckBoxOnPanel:(SGPanel *)pnl  withID:(NSString *)id;
+ (void)toggleRegionActive:(SGRegion *)forRegion;
+ (void)toggleShowPanel:(SGPanel *)p;
+ (void)updateInterface;








@end

