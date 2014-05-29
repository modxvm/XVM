package net.wg.gui.lobby.fortifications.cmp.build.impl
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
   import flash.geom.Point;


   public class HitAreaControl extends SoundButtonEx
   {
          
      public function HitAreaControl() {
         super();
      }

      public var generalBuildingsHit:MovieClip;

      public var baseBuildingHit:MovieClip;

      public var trowelHit:MovieClip;

      public function setData(param1:String, param2:Number, param3:Boolean) : void {
         var _loc4_:* = param2 == FORTIFICATION_ALIASES.STATE_TROWEL;
         var _loc5_:* = param1 == FORTIFICATION_ALIASES.FORT_BASE_BUILDING;
         enabled = true;
         if((_loc4_) && !param3)
         {
            enabled = false;
            this.generalBuildingsHit.visible = true;
         }
         else
         {
            this.generalBuildingsHit.visible = !_loc5_ && !_loc4_;
         }
         this.baseBuildingHit.visible = _loc5_;
         this.trowelHit.visible = (_loc4_) && (param3);
      }

      override protected function onDispose() : void {
         this.generalBuildingsHit = null;
         this.baseBuildingHit = null;
         this.trowelHit = null;
         super.onDispose();
      }

      public function get absPosition() : Point {
         return localToGlobal(new Point(0,0));
      }
   }

}