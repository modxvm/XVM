package net.wg.gui.lobby.fortifications.utils.impl
{
   import net.wg.gui.lobby.fortifications.utils.IFortsControlsAligner;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.data.constants.Errors;
   import flash.display.DisplayObject;


   public class FortsControlsAligner extends Object implements IFortsControlsAligner
   {
          
      public function FortsControlsAligner() {
         super();
      }

      private static var ms_instance:IFortsControlsAligner = null;

      public static function get instance() : IFortsControlsAligner {
         if(ms_instance == null)
         {
            ms_instance = new FortsControlsAligner();
         }
         return ms_instance;
      }

      public function centerControl(param1:IUIComponentEx) : void {
         App.utils.asserter.assertNotNull(param1,"control" + Errors.CANT_NULL);
         param1.x = Math.round((App.appWidth - param1.width) / 2);
      }

      public function rightControl(param1:DisplayObject, param2:Number) : void {
         App.utils.asserter.assertNotNull(param1,"control" + Errors.CANT_NULL);
         param1.x = App.appWidth - param1.width - param2;
      }
   }

}