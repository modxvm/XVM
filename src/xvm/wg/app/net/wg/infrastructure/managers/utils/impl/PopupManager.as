package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.utils.IPopUpManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import scaleform.clik.managers.PopUpManager;
   import flash.display.MovieClip;
   import net.wg.utils.IUtils;


   public class PopupManager extends Object implements IPopUpManager
   {
          
      public function PopupManager() {
         super();
      }

      public function show(param1:DisplayObject, param2:Number=0, param3:Number=0, param4:DisplayObjectContainer=null) : void {
         PopUpManager.show(param1,param2 - MovieClip(App.instance).x,param3 - MovieClip(App.instance).y,param4);
      }

      public function create(param1:String, param2:Object, param3:DisplayObjectContainer=null) : DisplayObject {
         var _loc4_:DisplayObject = App.utils.classFactory.getObject(param1,param2) as DisplayObject;
         App.utils.asserter.assertNotNull(_loc4_,"object for \'" + param1 + "\' was not found.");
         this.show(_loc4_,param2.x,param2.y,param3);
         return _loc4_;
      }

      public function get popupCanvas() : DisplayObjectContainer {
         return PopUpManager.popupCanvas;
      }

      public function remove(param1:DisplayObject) : void {
         App.utils.asserter.assert(this.contains(param1),"can\'t remove popup \'" + param1 + "\' because it\'s not a child of popupCanvas");
         App.utils.commons.releaseReferences(param1);
         this.popupCanvas.removeChild(param1);
      }

      public function removeAll() : void {
         var _loc3_:DisplayObject = null;
         var _loc1_:DisplayObjectContainer = this.popupCanvas;
         var _loc2_:IUtils = App.utils;
         while(_loc1_.numChildren)
         {
            _loc3_ = _loc1_.getChildAt(_loc1_.numChildren-1);
            _loc2_.commons.releaseReferences(_loc3_);
            _loc1_.removeChild(_loc3_);
         }
      }

      public function contains(param1:DisplayObject) : Boolean {
         return this.popupCanvas.contains(param1);
      }
   }

}