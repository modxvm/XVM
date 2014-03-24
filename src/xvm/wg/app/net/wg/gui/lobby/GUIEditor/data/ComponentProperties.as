package net.wg.gui.lobby.GUIEditor.data
{
   import flash.text.TextFieldAutoSize;


   public class ComponentProperties extends Object
   {
          
      public function ComponentProperties() {
         super();
      }

      private static const HTML_TEXT_HASH:Object;

      private static const TEXT_HASH:Object;

      private static const SELECTED_TEXT_HASH:Object;

      private static const CLASS_HASH:Object;

      private static const SUPER_CLASS_HASH:Object;

      private static const CURRENT_LABEL_HASH:Object;

      private static const CURRENT_FRAME_LABEL_HASH:Object;

      private static const TAB_ENABLED_HASH:Object;

      private static const MOUSE_ENABLED_HASH:Object;

      private static const DOUBLE_CLICK_ENABLED_HASH:Object;

      private static const VISIBLE_HASH:Object;

      private static const ENABLED_HASH:Object;

      private static const TAB_CHILDREN_HASH:Object;

      private static const MOUSE_CHILDREN_HASH:Object;

      private static const USE_HAND_CURSOR_HASH:Object;

      private static const MULTILINE_HASH:Object;

      private static const SELECTABLE_HASH:Object;

      private static const HAS_FOCUS_HASH:Object;

      private static const FOCUSED_HASH:Object;

      private static const SELECTED_HASH:Object;

      private static const BACKGROUND_HASH:Object;

      private static const BORDER_HASH:Object;

      private static const CONDENSE_WHITE_HASH:Object;

      private static const MOUSE_WHEEL_ENABLED_HASH:Object;

      private static const BUTTON_MODE_HASH:Object;

      private static const AUTOREPEAT_HASH:Object;

      private static const X_HASH:Object;

      private static const Y_HASH:Object;

      private static const WIDTH_HASH:Object;

      private static const HEIGHT_HASH:Object;

      private static const ROTATION_HASH:Object;

      private static const TEXT_WIDTH_HASH:Object;

      private static const TEXT_HEIGHT_HASH:Object;

      private static const TAB_INDEX_HASH:Object;

      private static const CURRENT_FRAME_HASH:Object;

      private static const NUM_CHILDREN_HASH:Object;

      private static const FRAMES_LOADED_HASH:Object;

      private static const TOTAL_FRAMES_HASH:Object;

      private static const NUMLINES_HASH:Object;

      private static const SCROLL_H_HASH:Object;

      private static const SCROLL_V_HASH:Object;

      private static const MAX_SCROLL_H_HASH:Object;

      private static const MAX_SCROLL_V_HASH:Object;

      private static const LENGTH_HASH:Object;

      private static const MAX_CHARS_HASH:Object;

      private static const SELECTION_BEGIN_INDEX_HASH:Object;

      private static const SELECTION_END_INDEX_HASH:Object;

      private static const ROW_COUNT_HASH:Object;

      private static const ROW_HEIGHT_HASH:Object;

      private static const ALPHA_HASH:Object;

      private static const SCALE_X_HASH:Object;

      private static const SCALE_Y_HASH:Object;

      private static const AUTOSIZE_HASH:Object;

      public static const HTML_TEXT:ComponentPropertyVO = new ComponentPropertyVO(HTML_TEXT_HASH);

      public static const TEXT:ComponentPropertyVO = new ComponentPropertyVO(TEXT_HASH);

      public static const SELECTED_TEXT:ComponentPropertyVO = new ComponentPropertyVO(SELECTED_TEXT_HASH);

      public static const CLASS:ComponentPropertyVO = new ComponentPropertyVO(CLASS_HASH);

      public static const SUPER_CLASS:ComponentPropertyVO = new ComponentPropertyVO(SUPER_CLASS_HASH);

      public static const CURRENT_LABEL:ComponentPropertyVO = new ComponentPropertyVO(CURRENT_LABEL_HASH);

      public static const CURRENT_FRAME_LABEL:ComponentPropertyVO = new ComponentPropertyVO(CURRENT_FRAME_LABEL_HASH);

      public static const TAB_ENABLED:ComponentPropertyVO = new ComponentPropertyVO(TAB_ENABLED_HASH);

      public static const MOUSE_ENABLED:ComponentPropertyVO = new ComponentPropertyVO(MOUSE_ENABLED_HASH);

      public static const DOUBLE_CLICK_ENABLED:ComponentPropertyVO = new ComponentPropertyVO(DOUBLE_CLICK_ENABLED_HASH);

      public static const VISIBLE:ComponentPropertyVO = new ComponentPropertyVO(VISIBLE_HASH);

      public static const ENABLED:ComponentPropertyVO = new ComponentPropertyVO(ENABLED_HASH);

      public static const TAB_CHILDREN:ComponentPropertyVO = new ComponentPropertyVO(TAB_CHILDREN_HASH);

      public static const MOUSE_CHILDREN:ComponentPropertyVO = new ComponentPropertyVO(MOUSE_CHILDREN_HASH);

      public static const USE_HAND_CURSOR:ComponentPropertyVO = new ComponentPropertyVO(USE_HAND_CURSOR_HASH);

      public static const MULTILINE:ComponentPropertyVO = new ComponentPropertyVO(MULTILINE_HASH);

      public static const SELECTABLE:ComponentPropertyVO = new ComponentPropertyVO(SELECTABLE_HASH);

      public static const HAS_FOCUS:ComponentPropertyVO = new ComponentPropertyVO(HAS_FOCUS_HASH);

      public static const FOCUSED:ComponentPropertyVO = new ComponentPropertyVO(FOCUSED_HASH);

      public static const SELECTED:ComponentPropertyVO = new ComponentPropertyVO(SELECTED_HASH);

      public static const BACKGROUND:ComponentPropertyVO = new ComponentPropertyVO(BACKGROUND_HASH);

      public static const BORDER:ComponentPropertyVO = new ComponentPropertyVO(BORDER_HASH);

      public static const CONDENSE_WHITE:ComponentPropertyVO = new ComponentPropertyVO(CONDENSE_WHITE_HASH);

      public static const MOUSE_WHEEL_ENABLED:ComponentPropertyVO = new ComponentPropertyVO(MOUSE_WHEEL_ENABLED_HASH);

      public static const BUTTON_MODE:ComponentPropertyVO = new ComponentPropertyVO(BUTTON_MODE_HASH);

      public static const AUTOREPEAT:ComponentPropertyVO = new ComponentPropertyVO(AUTOREPEAT_HASH);

      public static const X:ComponentPropertyVO = new ComponentPropertyVO(X_HASH);

      public static const Y:ComponentPropertyVO = new ComponentPropertyVO(Y_HASH);

      public static const WIDTH:ComponentPropertyVO = new ComponentPropertyVO(WIDTH_HASH);

      public static const HEIGHT:ComponentPropertyVO = new ComponentPropertyVO(HEIGHT_HASH);

      public static const ROTATION:ComponentPropertyVO = new ComponentPropertyVO(ROTATION_HASH);

      public static const TEXT_WIDTH:ComponentPropertyVO = new ComponentPropertyVO(TEXT_WIDTH_HASH);

      public static const TEXT_HEIGHT:ComponentPropertyVO = new ComponentPropertyVO(TEXT_HEIGHT_HASH);

      public static const TAB_INDEX:ComponentPropertyVO = new ComponentPropertyVO(TAB_INDEX_HASH);

      public static const CURRENT_FRAME:ComponentPropertyVO = new ComponentPropertyVO(CURRENT_FRAME_HASH);

      public static const NUM_CHILDREN:ComponentPropertyVO = new ComponentPropertyVO(NUM_CHILDREN_HASH);

      public static const FRAMES_LOADED:ComponentPropertyVO = new ComponentPropertyVO(FRAMES_LOADED_HASH);

      public static const TOTAL_FRAMES:ComponentPropertyVO = new ComponentPropertyVO(TOTAL_FRAMES_HASH);

      public static const NUMLINES:ComponentPropertyVO = new ComponentPropertyVO(NUMLINES_HASH);

      public static const SCROLL_H:ComponentPropertyVO = new ComponentPropertyVO(SCROLL_H_HASH);

      public static const SCROLL_V:ComponentPropertyVO = new ComponentPropertyVO(SCROLL_V_HASH);

      public static const MAX_SCROLL_H:ComponentPropertyVO = new ComponentPropertyVO(MAX_SCROLL_H_HASH);

      public static const MAX_SCROLL_V:ComponentPropertyVO = new ComponentPropertyVO(MAX_SCROLL_V_HASH);

      public static const LENGTH:ComponentPropertyVO = new ComponentPropertyVO(LENGTH_HASH);

      public static const MAX_CHARS:ComponentPropertyVO = new ComponentPropertyVO(MAX_CHARS_HASH);

      public static const SELECTION_BEGIN_INDEX:ComponentPropertyVO = new ComponentPropertyVO(SELECTION_BEGIN_INDEX_HASH);

      public static const SELECTION_END_INDEX:ComponentPropertyVO = new ComponentPropertyVO(SELECTION_END_INDEX_HASH);

      public static const ALPHA:ComponentPropertyVO = new ComponentPropertyVO(ALPHA_HASH);

      public static const SCALE_X:ComponentPropertyVO = new ComponentPropertyVO(SCALE_X_HASH);

      public static const SCALE_Y:ComponentPropertyVO = new ComponentPropertyVO(SCALE_Y_HASH);

      public static const AUTOSIZE:ComponentPropertyVO = new ComponentPropertyVO(AUTOSIZE_HASH);

      public static const ROW_COUNT:ComponentPropertyVO = new ComponentPropertyVO(ROW_COUNT_HASH);

      public static const ROW_HEIGHT:ComponentPropertyVO = new ComponentPropertyVO(ROW_HEIGHT_HASH);
   }

}