package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.lobby.questsWindow.data.QuestDataVO;
   import __AS3__.vec.Vector;


   public class QuestBlock extends UIComponent
   {
          
      public function QuestBlock() {
         super();
      }

      private static const AWARDS_TOP_PADDING:int = 13;

      public var header:HeaderBlock;

      public var infoBlock:MiddleInfoBlock;

      public var awards:QuestAwardsBlock;

      public var bg:MovieClip;

      public var bottomBg:MovieClip;

      private var _showAwards:Boolean = false;

      private var _showNextTasks:Boolean = false;

      public var nextTasksList:SubtasksList;

      override protected function configUI() : void {
         super.configUI();
         this.header.addEventListener(Event.RESIZE,this.layoutBlocks);
         this.infoBlock.addEventListener(Event.RESIZE,this.layoutBlocks);
         this.awards.addEventListener(Event.RESIZE,this.layoutBlocks);
      }

      public function setData(param1:Object) : void {
         var _loc2_:QuestDataVO = null;
         _loc2_ = new QuestDataVO(param1);
         this._showAwards = Boolean(_loc2_.award);
         this._showNextTasks = Boolean(_loc2_.nextTasks.length);
         this.header.setData(_loc2_.header);
         this.infoBlock.setData(_loc2_.info);
         this.awards.setAwards(_loc2_.award);
         this.awards.visible = this._showAwards;
         this.nextTasksList.setData(_loc2_.nextTasks);
         this.nextTasksList.validateNow();
      }

      public function setAvailableQuests(param1:Vector.<String>) : void {
         this.nextTasksList.checkDisabledQuests(param1);
         this.infoBlock.subtasksList.checkDisabledQuests(param1);
      }

      private function layoutBlocks(param1:Event) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc6_:* = NaN;
         _loc2_ = this.header.height;
         _loc3_ = this.infoBlock.height;
         var _loc4_:Number = this._showAwards?this.awards.height - AWARDS_TOP_PADDING:0;
         var _loc5_:Number = this._showNextTasks?this.nextTasksList.height:0;
         _loc6_ = _loc3_ + _loc4_ + _loc5_;
         this.bg.y = _loc2_;
         this.infoBlock.y = Math.round(_loc2_);
         this.awards.y = _loc2_ + _loc3_ - AWARDS_TOP_PADDING;
         this.nextTasksList.y = _loc2_ + _loc3_ + _loc4_;
         this.bg.height = _loc6_;
         this.bottomBg.y = this.bg.y + _loc6_ - 2;
         this.awards.visible = this._showAwards;
         this.nextTasksList.visible = this._showNextTasks;
         var _loc7_:Number = _loc2_ + _loc6_ + this.bottomBg.height;
         setSize(this.width,_loc7_);
         dispatchEvent(new Event(Event.RESIZE));
      }

      override public function dispose() : void {
         this.header.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.infoBlock.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.awards.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.header.dispose();
         this.infoBlock.dispose();
         this.awards.dispose();
         this.nextTasksList.dispose();
         super.dispose();
      }
   }

}