package net.wg.gui.lobby.demonstration
{
   import net.wg.infrastructure.base.meta.impl.DemonstratorWindowMeta;
   import net.wg.infrastructure.base.meta.IDemonstratorWindowMeta;
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.lobby.demonstration.data.DemonstratorVO;
   import scaleform.clik.events.ListEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.lobby.demonstration.data.MapItemVO;
   
   public class DemonstratorWindow extends DemonstratorWindowMeta implements IDemonstratorWindowMeta
   {
      
      public function DemonstratorWindow() {
         super();
      }
      
      public var listStandard:TileList;
      
      public var listAssault:TileList;
      
      public var listEncounter:TileList;
      
      public var scrollStandard:ScrollBar;
      
      public var scrollAssault:ScrollBar;
      
      public var scrollEncounter:ScrollBar;
      
      private var model:DemonstratorVO;
      
      public function as_setData(param1:Object) : void {
         this.model = new DemonstratorVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void {
         super.configUI();
         this.scrollStandard.visible = false;
         this.scrollAssault.visible = false;
         this.scrollEncounter.visible = false;
         this.listStandard.addEventListener(ListEvent.ITEM_CLICK,this.onMapItemClick);
         this.listAssault.addEventListener(ListEvent.ITEM_CLICK,this.onMapItemClick);
         this.listEncounter.addEventListener(ListEvent.ITEM_CLICK,this.onMapItemClick);
      }
      
      private function onStageClick(param1:MouseEvent) : void {
         this.updateScrollBars();
      }
      
      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.model))
         {
            this.listStandard.dataProvider = this.model.standard;
            this.listAssault.dataProvider = this.model.assault;
            this.listEncounter.dataProvider = this.model.encounter;
            App.utils.scheduler.envokeInNextFrame(this.updateScrollBars);
         }
      }
      
      override protected function onPopulate() : void {
         super.onPopulate();
         window.useBottomBtns = true;
         window.title = MENU.DEMONSTRATOR_WINDOW_TITLE;
      }
      
      override protected function onDispose() : void {
         super.onDispose();
         this.model.dispose();
         this.model = null;
         this.listStandard.removeEventListener(ListEvent.ITEM_CLICK,this.onMapItemClick);
         this.listAssault.removeEventListener(ListEvent.ITEM_CLICK,this.onMapItemClick);
         this.listEncounter.removeEventListener(ListEvent.ITEM_CLICK,this.onMapItemClick);
         this.listStandard.dataProvider.cleanUp();
         this.listStandard.dataProvider = null;
         this.listAssault.dataProvider.cleanUp();
         this.listAssault.dataProvider = null;
         this.listEncounter.dataProvider.cleanUp();
         this.listEncounter.dataProvider = null;
      }
      
      private function onMapItemClick(param1:ListEvent) : void {
         onMapSelectedS(MapItemVO(param1.itemData).id);
      }
      
      private function updateScrollBars() : void {
         this.scrollStandard.visible = this.scrollStandard.thumb.visible;
         this.scrollAssault.visible = this.scrollAssault.thumb.visible;
         this.scrollEncounter.visible = this.scrollEncounter.thumb.visible;
      }
   }
}
