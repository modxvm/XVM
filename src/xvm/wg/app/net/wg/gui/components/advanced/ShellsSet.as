package net.wg.gui.components.advanced
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.hangar.maintenance.data.ShellVO;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Linkages;


   public class ShellsSet extends UIComponent
   {
          
      public function ShellsSet() {
         this.shellViews = [];
         super();
      }

      private static const ITEMS_GAP:Number = 3;

      protected var data:Array = null;

      private var shellViews:Array;

      public function setData(param1:Array) : void {
         this.data = param1;
         validateNow();
      }

      override protected function draw() : void {
         var _loc1_:ShellButton = null;
         var _loc2_:ShellVO = null;
         var _loc3_:* = NaN;
         var _loc4_:* = 0;
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.data))
         {
            _loc3_ = 0;
            this.clearRenderers();
            this.shellViews = [];
            _loc4_ = 0;
            while(_loc4_ < this.data.length)
            {
               _loc2_ = this.data[_loc4_];
               _loc1_ = App.utils.classFactory.getComponent(Linkages.SHELL_BUTTON,ShellButton);
               _loc1_.id = _loc2_.id;
               _loc1_.ammunitionType = _loc2_.type;
               _loc1_.ammunitionIcon = _loc2_.icon;
               _loc1_.count = String(_loc2_.count);
               _loc1_.label = _loc2_.label;
               _loc1_.mouseEnabled = false;
               _loc1_.validateNow();
               _loc1_.x = _loc3_;
               _loc3_ = _loc3_ + (_loc1_.width + ITEMS_GAP);
               addChild(_loc1_);
               this.shellViews.push(_loc1_);
               _loc4_++;
            }
         }
      }

      override protected function onDispose() : void {
         if(this.data)
         {
            this.data.splice(0);
            this.data = null;
         }
         this.clearRenderers();
         super.onDispose();
      }

      private function clearRenderers() : void {
         var _loc1_:ShellButton = null;
         for each (_loc1_ in this.shellViews)
         {
            removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
         }
         this.shellViews = this.shellViews.splice(0);
         this.shellViews = null;
      }
   }

}