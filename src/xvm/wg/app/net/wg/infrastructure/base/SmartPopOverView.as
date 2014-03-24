package net.wg.infrastructure.base
{
   import net.wg.infrastructure.base.meta.impl.SmartPopOverViewMeta;
   import net.wg.infrastructure.base.meta.ISmartPopOverViewMeta;
   import flash.events.Event;
   import net.wg.gui.components.popOvers.SmartPopOver;


   public class SmartPopOverView extends SmartPopOverViewMeta implements ISmartPopOverViewMeta
   {
          
      public function SmartPopOverView() {
         super();
      }

      override protected function configUI() : void {
         super.configUI();
         stage.addEventListener(Event.RESIZE,this.stageResizeHandler,false,0,true);
         this.stageResizeHandler(null);
      }

      protected function stageResizeHandler(param1:Event) : void {
         SmartPopOver(wrapper).setStageDimensions(stage.stageWidth,stage.stageHeight);
      }

      public function as_setPositionKeyPoint(param1:Number, param2:Number) : void {
         SmartPopOver(wrapper).setPositionKeyPoint(param1,param2);
      }

      override protected function onDispose() : void {
         if(stage)
         {
            stage.removeEventListener(Event.RESIZE,this.stageResizeHandler);
         }
         super.onDispose();
      }
   }

}