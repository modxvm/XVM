package net.wg.gui.cyberSport.controls
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class SettingRosterVO extends DAAPIDataClass
   {
          
      public function SettingRosterVO(param1:Object=null) {
         super(param1);
      }

      public var nationIDRange:Array = null;

      public var vLevelRange:Array = null;

      public var vTypeRange:Array = null;

      override public function dispose() : void {
         super.dispose();
         this.nationIDRange.splice(0,this.nationIDRange.length);
         this.vLevelRange.splice(0,this.vLevelRange.length);
         this.vTypeRange.splice(0,this.vTypeRange.length);
      }
   }

}