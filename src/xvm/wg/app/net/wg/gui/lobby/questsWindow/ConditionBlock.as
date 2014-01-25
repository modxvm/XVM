package net.wg.gui.lobby.questsWindow
{
   import net.wg.gui.lobby.questsWindow.components.ResizableContainer;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import flash.events.Event;
   import net.wg.gui.lobby.questsWindow.data.RequirementBlockVO;
   import scaleform.clik.constants.InvalidationType;


   public class ConditionBlock extends RequirementBlock
   {
          
      public function ConditionBlock() {
         super();
      }

      private static const SEPARATOR_PADDING:int = 15;

      private static const VERTICAL_PADDING:int = 12;

      public var topConditions:ResizableContainer;

      public var topSeparator:Sprite;

      public var lowerSeparator:Sprite;

      override protected function configUI() : void {
         super.configUI();
         this.topConditions.visible = false;
         this.topConditions.contentAlign = TextFieldAutoSize.RIGHT;
         this.topSeparator.visible = false;
         this.lowerSeparator.visible = false;
         this.topConditions.x = LEFT_PADDING;
         this.topConditions.verticalPadding = VERTICAL_PADDING;
         this.topConditions.bottomPadding = SEPARATOR_PADDING;
         this.topConditions.addEventListener(Event.RESIZE,this.layoutBlocks);
      }

      override protected function onDispose() : void {
         this.topConditions.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.topConditions.dispose();
         this.topConditions = null;
         this.topSeparator = null;
         this.lowerSeparator = null;
         super.onDispose();
      }

      override public function setData(param1:Object) : void {
         this.topConditions.isReadyForLayout = false;
         super.setData(param1);
      }

      override protected function draw() : void {
         var _loc1_:RequirementBlockVO = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(data)
            {
               _loc1_ = new RequirementBlockVO(data);
               description.setLabels(_loc1_.title,_loc1_.description);
               blocksContainer.setData(_loc1_.containerElements);
               this.topConditions.setData(_loc1_.topConditions);
            }
            else
            {
               isReadyForLayout = true;
               setSize(this.width,0);
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }

      override protected function layoutBlocks(param1:Event) : void {
         var _loc2_:* = false;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         if((blocksContainer.isReadyForLayout) && (description.isReadyForLayout) && (this.topConditions.isReadyForLayout))
         {
            _loc2_ = this.topConditions.height > 0;
            blocksContainer.visible = true;
            description.visible = true;
            this.lowerSeparator.visible = this.topSeparator.visible = this.topConditions.visible = _loc2_;
            _loc3_ = Math.round(description.y + description.height);
            this.topSeparator.y = Math.round(_loc3_);
            this.topConditions.y = Math.round(this.topSeparator.y + SEPARATOR_PADDING);
            this.lowerSeparator.y = Math.round(this.topConditions.y + this.topConditions.height);
            blocksContainer.y = _loc3_;
            if(_loc2_)
            {
               _loc5_ = Math.round(this.lowerSeparator.y - this.topSeparator.y);
               blocksContainer.y = _loc3_ + _loc5_ + SEPARATOR_PADDING;
            }
            _loc4_ = Math.round(blocksContainer.y + blocksContainer.height);
            setSize(this.width,_loc4_);
            isReadyForLayout = true;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
   }

}