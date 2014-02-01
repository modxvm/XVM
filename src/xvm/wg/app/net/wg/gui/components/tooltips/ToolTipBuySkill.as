package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import flash.display.Sprite;
   import net.wg.gui.lobby.tankman.SkillItemViewMini;
   import net.wg.gui.components.tooltips.VO.Dimension;
   import flashx.textLayout.formats.TextAlign;
   import net.wg.utils.IClassFactory;
   import net.wg.data.constants.Linkages;
   import flash.display.MovieClip;


   public class ToolTipBuySkill extends ToolTipBase
   {
          
      public function ToolTipBuySkill() {
         super();
         this._maxWidth = 283 - (this._leftMargin + this._rightMargin);
         this._bottomMargin = 5;
         this.marginAfterSeparate = 15;
      }

      private static const LINE_HEIGHT:Number = 22;

      public var header:TextField;

      public var separate_mc:Sprite;

      public var skillLevel:SkillItemViewMini;

      public var skillCount:SkillItemViewMini;

      private var _maxWidth:Number = 0;

      private var _bottomMargin:Number = 12;

      private var marginAfterSeparate:Number = 8;

      private var _leftMargin:Number = 18;

      private var _rightMargin:Number = 18;

      private var _topMargin:Number = 12;

      override public function toString() : String {
         return "[BuySkillToolTip]";
      }

      override protected function redraw() : void {
         this.setContent();
         super.redraw();
      }

      override protected function updateSize() : void {
         var _loc1_:Dimension = null;
         _loc1_ = this.getContDimension();
         background.x = background.y = 0;
         background.width = _loc1_.width + this._leftMargin + this._rightMargin;
         this.separate_mc.x = background.width - this.separate_mc.width >> 1;
         background.height = _loc1_.height + this._topMargin + this._bottomMargin;
      }

      private function setContent() : void {
         var _loc1_:* = NaN;
         _loc1_ = this._topMargin;
         this.header.x = this._leftMargin;
         this.header.y = _loc1_;
         this.header.autoSize = TextAlign.LEFT;
         this.header.text = TOOLTIPS.BUYSKILL_HEADER;
         _loc1_ = _loc1_ + Math.round(this.header.textHeight + this._topMargin);
         this.separate_mc.y = _loc1_;
         _loc1_ = _loc1_ + this.marginAfterSeparate;
         var _loc2_:Number = Number(_data.count);
         var _loc3_:Number = Number(_data.level);
         if(_loc3_ == 100)
         {
            _loc2_++;
            _loc3_ = 0;
         }
         var _loc4_:IClassFactory = App.utils.classFactory;
         if(_loc3_ > 0)
         {
            this.skillLevel = _loc4_.getComponent(Linkages.SKILL_ITEM_VIEW_MINI,MovieClip);
            this.skillLevel.x = this._leftMargin;
            addChild(this.skillLevel);
         }
         if(_loc2_ > 1)
         {
            this.skillCount = _loc4_.getComponent(Linkages.SKILL_ITEM_VIEW_MINI,SkillItemViewMini);
            addChild(this.skillCount);
            this.skillCount.x = this._leftMargin;
            this.skillCount.y = _loc1_;
            this.skillCount.type = _loc2_ > 2?SkillItemViewMini.TYPE_NEW_SKILLS:SkillItemViewMini.TYPE_NEW_SKILL;
            this.skillCount.text = "<font size=\"12\" color=\"#7B7969\" face=\"$FieldFont\">" + App.utils.locale.makeString(TOOLTIPS.BUYSKILL_FULLY,{"count":"<font size=\"12\" face=\"$TitleFont\" color=\"#FFAC34\">" + String(_loc2_-1) + " x 100%</font>"}) + "</font>";
            if(_loc3_ > 0)
            {
               this.skillLevel.y = Math.round(this.skillCount.y + LINE_HEIGHT);
            }
         }
         else
         {
            if(_loc3_ > 0)
            {
               this.skillLevel.y = _loc1_;
            }
         }
         if(_loc3_ > 0)
         {
            this.skillLevel.type = SkillItemViewMini.TYPE_CURRENT_NEW_SKILL;
            this.skillLevel.text = "<font size=\"12\" color=\"#7B7969\" face=\"$FieldFont\">" + App.utils.locale.makeString(TOOLTIPS.BUYSKILL_PARTLY,{"count":"<font size=\"12\" face=\"$TitleFont\" color=\"#F06532\">" + String(_loc3_) + "%</font>"}) + "</font>";
            this.skillLevel.x = this._leftMargin;
         }
      }

      private function getContDimension() : Dimension {
         var _loc1_:Dimension = new Dimension();
         _loc1_.width = this.separate_mc.width - (this._leftMargin + this._rightMargin);
         _loc1_.width = _loc1_.width > this.header.textWidth?_loc1_.width:this.header.textWidth;
         _loc1_.height = this.header.x + this.header.textHeight;
         if(this.skillCount)
         {
            _loc1_.width = _loc1_.width > this.skillCount.width?_loc1_.width:this.skillCount.width;
         }
         if(this.skillLevel)
         {
            _loc1_.width = _loc1_.width > this.skillLevel.width?_loc1_.width:this.skillLevel.width;
         }
         _loc1_.width = _loc1_.width < this._maxWidth?this._maxWidth:_loc1_.width;
         _loc1_.width = Math.round(_loc1_.width);
         _loc1_.height = this.skillLevel?Math.round(this.skillLevel.y + this.skillLevel.height - 6):this.skillCount?Math.round(this.skillCount.y + this.skillCount.height - 6):_loc1_.height;
         return _loc1_;
      }
   }

}