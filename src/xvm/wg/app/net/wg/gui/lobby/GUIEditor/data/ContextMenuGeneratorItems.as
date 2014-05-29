package net.wg.gui.lobby.GUIEditor.data
{
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.data.components.ContextItem;
   import __AS3__.vec.*;


   public class ContextMenuGeneratorItems extends Object implements IContextMenuGeneratorItems
   {
          
      public function ContextMenuGeneratorItems() {
         new Vector.<String>(5)[0] = DEVELOPMENT.EDITOR_CONTEXTMENU_NEW;
         new Vector.<String>(5)[1] = DEVELOPMENT.EDITOR_CONTEXTMENU_OPEN;
         new Vector.<String>(5)[2] = DEVELOPMENT.EDITOR_CONTEXTMENU_SAVE;
         new Vector.<String>(5)[3] = DEVELOPMENT.EDITOR_CONTEXTMENU_SAVE_AS;
         new Vector.<String>(5)[4] = DEVELOPMENT.EDITOR_CONTEXTMENU_CLOSE_EDITOR;
         this.labelsForFileMenu = new Vector.<String>(5);
         new Vector.<String>(4)[0] = DEVELOPMENT.EDITOR_CONTEXTMENU_UNDO;
         new Vector.<String>(4)[1] = DEVELOPMENT.EDITOR_CONTEXTMENU_CUT;
         new Vector.<String>(4)[2] = DEVELOPMENT.EDITOR_CONTEXTMENU_COPY;
         new Vector.<String>(4)[3] = DEVELOPMENT.EDITOR_CONTEXTMENU_PASTE;
         this.labelsForEditMenu = new Vector.<String>(4);
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