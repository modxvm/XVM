package net.wg.gui.lobby.GUIEditor
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.DropdownMenu;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.data.DataProvider;
   import flash.display.InteractiveObject;


   public class ComponentsPanel extends UIComponent implements IViewStackContent
   {
          
      public function ComponentsPanel() {
         super();
      }

      public var componentsList:ScrollingListEx = null;

      public var componentsType:DropdownMenu = null;

      override protected function configUI() : void {
         super.configUI();
         this.componentsType.selectedIndex = 0;
         this.componentsType.addEventListener(ListEvent.INDEX_CHANGE,this.onComponentsTypeIndexChangeHandler);
         this.componentsType.dataProvider = new DataProvider([{"label":GUIEditorHelper.TYPE_ALL},{"label":GUIEditorHelper.TYPE_SIMPLE},{"label":GUIEditorHelper.TYPE_STANDART},{"label":GUIEditorHelper.TYPE_ADVANCED},{"label":GUIEditorHelper.TYPE_NON_SMART},{"label":GUIEditorHelper.TYPE_SMART}]);
         this.updateComponentsList();
      }

      override protected function onDispose() : void {
         this.componentsType.removeEventListener(ListEvent.INDEX_CHANGE,this.onComponentsTypeIndexChangeHandler);
         this.componentsType.dispose();
         this.componentsType = null;
         this.componentsList.dispose();
         this.componentsList = null;
         super.onDispose();
      }

      private function updateComponentsList() : void {
         var _loc1_:String = this.componentsType.dataProvider[this.componentsType.selectedIndex].label;
         var _loc2_:Array = GUIEditorHelper.instance.getComponentsList(_loc1_);
         this.componentsList.dataProvider = new DataProvider(_loc2_);
      }

      private function onComponentsTypeIndexChangeHandler(param1:ListEvent) : void {
         this.updateComponentsList();
      }

      public function update(param1:Object) : void {
          
      }

      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
   }

}