package net.wg.gui.lobby.GUIEditor.data
{
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.data.components.ContextItem;
   
   public class ContextMenuGeneratorItems extends Object implements IContextMenuGeneratorItems
   {
      
      public function ContextMenuGeneratorItems() {
         this.labelsForFileMenu = new <String>[DEVELOPMENT.EDITOR_CONTEXTMENU_NEW,DEVELOPMENT.EDITOR_CONTEXTMENU_OPEN,DEVELOPMENT.EDITOR_CONTEXTMENU_SAVE,DEVELOPMENT.EDITOR_CONTEXTMENU_SAVE_AS,DEVELOPMENT.EDITOR_CONTEXTMENU_CLOSE_EDITOR];
         this.labelsForEditMenu = new <String>[DEVELOPMENT.EDITOR_CONTEXTMENU_UNDO,DEVELOPMENT.EDITOR_CONTEXTMENU_CUT,DEVELOPMENT.EDITOR_CONTEXTMENU_COPY,DEVELOPMENT.EDITOR_CONTEXTMENU_PASTE];
         super();
      }
      
      public static const FILE_TYPE:String = "fileType";
      
      public static const EDIT_TYPE:String = "editType";
      
      private var labelsForFileMenu:Vector.<String>;
      
      private var labelsForEditMenu:Vector.<String>;
      
      public function generateItemsContextMenu(param1:String) : Vector.<IContextItem> {
         var _loc4_:Vector.<String> = null;
         var _loc2_:Vector.<IContextItem> = new Vector.<IContextItem>();
         if(param1 == FILE_TYPE)
         {
            _loc4_ = this.labelsForFileMenu;
         }
         if(param1 == EDIT_TYPE)
         {
            _loc4_ = this.labelsForEditMenu;
         }
         var _loc3_:* = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_.push(new ContextItem(_loc4_[_loc3_],_loc4_[_loc3_]));
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
