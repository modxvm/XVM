package net.wg.gui.lobby.customization.renderers
{
   import __AS3__.vec.Vector;
   import net.wg.data.constants.SoundTypes;


   public class CamouflageItemRenderer extends CustomizationItemRenderer
   {
          
      public function CamouflageItemRenderer() {
         super();
         soundId = SoundTypes.CAMOUFLAGE_RENDERER;
      }

      override protected function setState(param1:String) : void {
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         super.setState(param1);
         var _loc2_:Vector.<String> = getStatePrefixes();
         var _loc3_:Array = _stateMap[param1];
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return;
         }
         do
         {
            _loc6_ = _loc2_.pop().toString();
            _loc4_ = _loc3_.length-1;
            while(_loc4_ >= 0)
            {
               _loc5_ = _loc6_ + _loc3_[_loc4_];
               if(_loc5_ != border.state)
               {
                  border.state = _loc5_;
               }
               _loc4_--;
            }
         }
         while(_loc2_.length > 0);
      }
   }

}