package net.wg.gui.lobby.hangar.ammunitionPanel
{
   import flash.display.MovieClip;
   
   public class ModuleSlot extends DeviceSlot
   {
      
      public function ModuleSlot() {
         super();
      }
      
      private var _level:int = 0;
      
      private var _slotType:int = 0;
      
      public var icon:MovieClip;
      
      override protected function configUI() : void {
         super.configUI();
         if(this.icon)
         {
            this.icon.mouseEnabled = this.icon.mouseChildren = false;
         }
      }
      
      public function get slotType() : int {
         return this._slotType;
      }
      
      public function set slotType(param1:int) : void {
         this._slotType = param1;
         if(this._slotType > 1)
         {
            this.icon.gotoAndStop(this.slotType);
         }
      }
      
      public function get level() : int {
         return this._level;
      }
      
      public function set level(param1:int) : void {
         this._level = param1;
         if(this.level > 0 && (levelMC))
         {
            levelMC.visible = true;
            levelMC.gotoAndStop(this.level);
         }
         else if(levelMC)
         {
            levelMC.visible = false;
         }
         
      }
      
      override protected function applyIconData(param1:*) : void {
         super.applyIconData(param1);
         if(param1)
         {
            this.level = param1.icon;
         }
         else
         {
            this.level = 0;
         }
      }
   }
}
