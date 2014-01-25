package net.wg.gui.crewOperations
{
   import net.wg.infrastructure.base.meta.impl.CrewOperationsPopOverMeta;
   import net.wg.infrastructure.base.meta.ICrewOperationsPopOverMeta;
   import net.wg.gui.components.common.containers.GroupEx;
   import net.wg.gui.components.common.containers.VerticalGroupLayout;
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IWrapper;
   import net.wg.gui.components.popOvers.PopOver;


   public class CrewOperationsPopOver extends CrewOperationsPopOverMeta implements ICrewOperationsPopOverMeta
   {
          
      public function CrewOperationsPopOver() {
         super();
      }

      public var group:GroupEx;

      override protected function configUI() : void {
         super.configUI();
         addChild(this.group);
         this.group.layout = new VerticalGroupLayout();
         this.group.itemRendererClass = App.utils.classFactory.getClass("CrewOperationsIRenderer_UI");
         this.group.addEventListener(Event.RESIZE,this.groupResizeHandler,false,0,true);
         this.group.addEventListener(CrewOperationEvent.OPERATION_CHANGED,this.operationChangedHandler,false,0,true);
      }

      private function operationChangedHandler(param1:CrewOperationEvent) : void {
         param1.stopImmediatePropagation();
         invokeOperationS(param1.operationName);
         App.popoverMgr.hide();
      }

      private function groupResizeHandler(param1:Event) : void {
         setSize(this.group.width,this.group.height);
      }

      override public function set wrapper(param1:IWrapper) : void {
         super.wrapper = param1;
         PopOver(wrapper).title = App.utils.locale.makeString(CREW_OPERATIONS.WINDOW_TITLE);
      }

      public function as_update(param1:Object) : void {
         var _loc2_:CrewOperationsInitVO = new CrewOperationsInitVO(param1);
         this.group.dataProvider = _loc2_.castedOperations;
      }

      override protected function onDispose() : void {
         if(this.group)
         {
            this.group.removeEventListener(Event.RESIZE,this.groupResizeHandler);
            this.group.removeEventListener(CrewOperationEvent.OPERATION_CHANGED,this.operationChangedHandler);
            if(this.group.parent)
            {
               this.group.parent.removeChild(this.group);
            }
            trace(this);
            this.group.dispose();
            this.group = null;
         }
         super.onDispose();
      }
   }

}