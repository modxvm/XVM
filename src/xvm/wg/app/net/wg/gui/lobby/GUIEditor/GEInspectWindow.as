package net.wg.gui.lobby.GUIEditor
{
   import net.wg.dev.base.meta.impl.GEInspectWindowMeta;
   import net.wg.infrastructure.base.meta.IGEInspectWindowMeta;
   import flash.display.Sprite;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.events.ViewStackEvent;
   import flash.display.InteractiveObject;


   public class GEInspectWindow extends GEInspectWindowMeta implements IGEInspectWindowMeta
   {
          
      public function GEInspectWindow() {
         super();
         showWindowBg = false;
         canClose = false;
      }

      private static const TABS_DATA:Array;

      public static const CONTENT_TABS:Array = [
                                                  {
                                                     "label":"Application",
                                                     "linkage":""
                                                  }
                                               ,
                                                  {
                                                     "label":"EditingWindow",
                                                     "linkage":""
                                                  }
                                               ];

      private static function onComponentCreateHandler(param1:ComponentCreateEvent) : void {
         var _loc2_:Sprite = Sprite(param1.component);
         App.cursor.attachToCursor(_loc2_,0,0);
      }

      public var viewStack:ViewStack = null;

      public var tabs:ButtonBarEx = null;

      public var contentTabs:ButtonBarEx = null;

      public var componentsPanel:ComponentsPanel = null;

      public var fileBtn:SoundButtonEx = null;

      public var editBtn:SoundButtonEx = null;

      override public function updateStage(param1:Number, param2:Number) : void {
         super.updateStage(param1,param2);
      }

      override protected function configUI() : void {
         super.configUI();
         this.tabs.dataProvider = new DataProvider(TABS_DATA);
         this.contentTabs.dataProvider = new DataProvider(CONTENT_TABS);
         this.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
         this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangeHandler);
         this.viewStack.show("InspectorViewUI");
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         addEventListener(ComponentCreateEvent.COMPONENT_CREATE,onComponentCreateHandler);
         window.getBackground().visible = false;
         InteractiveObject(window).mouseEnabled = false;
         window.title = "";
      }

      override protected function onDispose() : void {
         removeEventListener(ComponentCreateEvent.COMPONENT_CREATE,onComponentCreateHandler);
         this.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
         this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangeHandler);
         this.viewStack.dispose();
         this.viewStack = null;
         this.tabs.dispose();
         this.tabs = null;
         this.contentTabs.dispose();
         this.contentTabs = null;
         this.componentsPanel.dispose();
         this.componentsPanel = null;
         this.fileBtn.dispose();
         this.fileBtn = null;
         this.editBtn.dispose();
         this.editBtn = null;
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
         window.x = -window.formBgPadding.left - 322;
         window.y = -window.formBgPadding.top - 102;
         invalidateSize();
      }

      private function onViewNeedUpdateHandler(param1:ViewStackEvent) : void {
          
      }

      private function onViewChangeHandler(param1:ViewStackEvent) : void {
          
      }
   }

}