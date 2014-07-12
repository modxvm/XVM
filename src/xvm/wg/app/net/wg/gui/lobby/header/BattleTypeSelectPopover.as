package net.wg.gui.lobby.header
{
   import net.wg.infrastructure.base.meta.impl.BattleTypeSelectPopoverMeta;
   import net.wg.infrastructure.base.meta.IBattleTypeSelectPopoverMeta;
   import net.wg.gui.historicalBattles.controls.SimpleVehicleList;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.components.controls.events.FancyRendererEvent;
   import net.wg.gui.components.popOvers.PopOverConst;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.entity.IIdentifiable;
   import flash.events.MouseEvent;
   
   public class BattleTypeSelectPopover extends BattleTypeSelectPopoverMeta implements IBattleTypeSelectPopoverMeta
   {
      
      public function BattleTypeSelectPopover() {
         super();
         UIID = 97;
      }
      
      public var list:SimpleVehicleList;
      
      private var items:Array;
      
      private const PREBATTLE_ACTION_NAME_SORTIE:String = "sortie";
      
      override protected function configUI() : void {
         super.configUI();
         if(!hasEventListener(ListEvent.INDEX_CHANGE))
         {
            addEventListener(FancyRendererEvent.RENDERER_CLICK,this.onFightSelect,false,0,true);
         }
      }
      
      override protected function initLayout() : void {
         popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
         super.initLayout();
      }
      
      override protected function draw() : void {
         var _loc1_:Array = null;
         var _loc2_:* = 0;
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.items))
         {
            this.list.rowCount = this.items.length;
            _loc1_ = [];
            _loc2_ = 0;
            while(_loc2_ < this.items.length)
            {
               _loc1_.push(new BattleSelectDropDownVO(this.items[_loc2_]));
               _loc2_++;
            }
            this.list.dataProvider = new DataProvider(_loc1_);
            this.updateSelectedItem();
            this.list.validateNow();
            setSize(this.list.width,this.list.height);
         }
      }
      
      private function updateSelectedItem() : void {
         if(this.list.selectedIndex == -1)
         {
            this.list.selectedIndex = this.list.getFirstSelectablePosition(0,true);
         }
         else if(this.list.selectedIndex < this.list.getFirstSelectablePosition(this.list.dataProvider.length - 1,false))
         {
            this.list.selectedIndex = this.list.getFirstSelectablePosition(this.list.selectedIndex,true);
         }
         else
         {
            this.list.selectedIndex = this.list.getFirstSelectablePosition(0,true);
         }
         
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         setFocus(this.list);
      }
      
      private function onFightSelect(param1:FancyRendererEvent) : void {
         param1.stopImmediatePropagation();
         var _loc2_:String = BattleSelectDropDownVO(param1.target.data).data;
         if(_loc2_ == this.PREBATTLE_ACTION_NAME_SORTIE)
         {
            App.eventLogManager.logUIElement(IIdentifiable(this),MouseEvent.CLICK,0);
         }
         selectFightS(BattleSelectDropDownVO(param1.target.data).data);
         App.popoverMgr.hide();
      }
      
      public function as_update(param1:Array) : void {
         this.items = param1;
         invalidateData();
      }
      
      override protected function onDispose() : void {
         if(this.items)
         {
            this.items.splice(0,this.items.length);
         }
         this.items = null;
         removeEventListener(FancyRendererEvent.RENDERER_CLICK,this.onFightSelect);
         super.onDispose();
      }
   }
}
