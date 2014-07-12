package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.finstats.EfficiencyCritsBlock;
   import net.wg.gui.components.tooltips.finstats.EfficiencyBlock;
   import net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO;
   import net.wg.utils.ILocale;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import flash.text.TextFormat;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.events.UILoaderEvent;
   
   public class ToolTipFinalStats extends ToolTipSpecial
   {
      
      public function ToolTipFinalStats() {
         super();
         this.headerTF = content.headerTF;
         this.infoTF = content.infoTF;
         this.icon = content.icon;
      }
      
      private static var DEF_ICO_PATH:String = "../maps/icons/tooltip/";
      
      public var headerTF:TextField = null;
      
      public var icon:UILoaderAlt = null;
      
      public var infoTF:TextField = null;
      
      private var disabled:Boolean = true;
      
      private var critBlocks:Vector.<EfficiencyCritsBlock> = null;
      
      private var efficiencyBlock:EfficiencyBlock = null;
      
      override protected function configUI() : void {
         super.configUI();
      }
      
      override protected function redraw() : void {
         this.setData();
         updatePositions();
         super.redraw();
      }
      
      private function setData() : void {
         var _loc1_:ToolTipFinalStatsVO = null;
         var _loc6_:ILocale = null;
         _loc1_ = new ToolTipFinalStatsVO(_data);
         this.disabled = _loc1_.disabled;
         contentMargin.top = 17;
         contentMargin.bottom = 17;
         topPosition = bgShadowMargin.top + contentMargin.top;
         var _loc2_:Separator = null;
         separators = new Vector.<Separator>();
         this.critBlocks = new Vector.<EfficiencyCritsBlock>();
         var _loc3_:Number = 18;
         var _loc4_:* = "<br/>";
         if(_loc1_.disabled)
         {
            _loc3_ = 14;
            _loc4_ = "<br/><font size=\"4\"> </font><br/>";
         }
         var _loc5_:* = "";
         _loc6_ = App.utils.locale;
         switch(_loc1_.type)
         {
            case ToolTipFinalStatsVO.TYPE_KILL:
            case ToolTipFinalStatsVO.TYPE_TEAM_KILL:
               _loc5_ = _loc6_.makeString(BATTLE_RESULTS.common_tooltip(_loc1_.type + _loc1_.value + "/description"));
               break;
            default:
               _loc5_ = _loc6_.makeString(BATTLE_RESULTS.common_tooltip(_loc1_.type + "/description"));
         }
         _loc5_ = _loc4_ + Utils.instance.htmlWrapper(_loc5_,Utils.instance.COLOR_NORMAL,12,"$FieldFont");
         var _loc7_:String = Utils.instance.htmlWrapper(_loc6_.makeString(BATTLE_RESULTS.common_tooltip(_loc1_.type + "/header")),Utils.instance.COLOR_HEADER,_loc3_,"$TitleFont") + _loc5_;
         var _loc8_:TextFormat = new TextFormat();
         _loc8_.leading = 0;
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.multiline = true;
         this.headerTF.wordWrap = true;
         this.headerTF.htmlText = _loc7_;
         this.headerTF.setTextFormat(_loc8_);
         this.headerTF.x = bgShadowMargin.left + contentMargin.left * 2 + this.icon.width | 0;
         this.headerTF.y = this.disabled?topPosition - 3:topPosition - 5;
         this.headerTF.width = this.headerTF.textWidth + 5;
         this.icon.x = bgShadowMargin.left + contentMargin.left;
         this.icon.y = topPosition | 0;
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
         this.icon.source = DEF_ICO_PATH + _loc1_.type + ".png";
         this.headerTF.height = Math.max(this.headerTF.height,this.icon.y - this.headerTF.y + this.icon.height);
         if(this.disabled)
         {
            this.hideInfo();
            return;
         }
         topPosition = 80;
         _loc2_ = Utils.instance.createSeparate(content);
         _loc2_.y = topPosition | 0;
         separators.push(_loc2_);
         topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
         var _loc9_:Number = 0;
         var _loc10_:* = "";
         var _loc11_:* = "";
         switch(_loc1_.type)
         {
            case ToolTipFinalStatsVO.TYPE_STOTTED:
               break;
            case ToolTipFinalStatsVO.TYPE_ASSIST:
               _loc9_ = _loc1_.value;
               _loc10_ = _loc1_.values;
               _loc11_ = _loc1_.discript;
               break;
            case ToolTipFinalStatsVO.TYPE_CRITS:
               _loc9_ = _loc1_.value;
               if(_loc1_.critDamage)
               {
                  topPosition = this.createCritPart(ToolTipFinalStatsVO.CRIT_TYPE_DAMAGE,_loc1_.critDamage,topPosition);
               }
               if(_loc1_.critDestruction)
               {
                  topPosition = this.createCritPart(ToolTipFinalStatsVO.CRIT_TYPE_DISTRUCTION,_loc1_.critDestruction,topPosition);
               }
               if(_loc1_.critWound)
               {
                  topPosition = this.createCritPart(ToolTipFinalStatsVO.CRIT_TYPE_WOUND,_loc1_.critWound,topPosition);
               }
               break;
            case ToolTipFinalStatsVO.TYPE_DAMAGE:
               _loc10_ = _loc1_.values;
               _loc11_ = _loc1_.discript;
               break;
            case ToolTipFinalStatsVO.TYPE_KILL:
               break;
            case ToolTipFinalStatsVO.TYPE_TEAM_KILL:
               break;
         }
         if(!(_loc10_ == "") && !(_loc11_ == ""))
         {
            this.efficiencyBlock = App.utils.classFactory.getComponent("EfficiencyBlockUI",EfficiencyBlock);
            content.addChild(this.efficiencyBlock);
            this.efficiencyBlock.setData(_loc10_,_loc11_);
            this.efficiencyBlock.x = bgShadowMargin.left + contentMargin.left;
            this.efficiencyBlock.y = topPosition;
            topPosition = topPosition + (this.efficiencyBlock.actualHeight + Utils.instance.MARGIN_AFTER_BLOCK);
            _loc2_ = Utils.instance.createSeparate(content);
            _loc2_.y = topPosition | 0;
            separators.push(_loc2_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
         }
         if(_loc9_ != 0)
         {
            this.infoTF.x = bgShadowMargin.left + contentMargin.left;
            this.infoTF.y = topPosition | 0;
            this.infoTF.multiline = false;
            this.infoTF.wordWrap = false;
            this.infoTF.autoSize = TextFieldAutoSize.LEFT;
            this.infoTF.htmlText = Utils.instance.htmlWrapper(_loc6_.makeString(BATTLE_RESULTS.common_tooltip(_loc1_.type + "/total")),Utils.instance.COLOR_ADD_INFO,14,"$TitleFont") + " " + Utils.instance.htmlWrapper(_loc6_.integer(_loc1_.value),Utils.instance.COLOR_NUMBER,14,"$TitleFont");
            this.infoTF.width = this.infoTF.textWidth + 5;
         }
         else
         {
            this.hideInfo();
            _loc2_ = separators.pop();
            content.removeChild(_loc2_);
            _loc2_ = null;
         }
         _loc1_ = null;
         updatePositions();
         super.redraw();
      }
      
      private function hideInfo() : void {
         if(this.infoTF)
         {
            this.infoTF.x = 0;
            this.infoTF.y = 0;
            this.infoTF.width = 10;
            this.infoTF.visible = false;
         }
      }
      
      private function createCritPart(param1:String, param2:String, param3:Number) : Number {
         var _loc4_:EfficiencyCritsBlock = App.utils.classFactory.getComponent("EfficiencyCritsBlockUI",EfficiencyCritsBlock);
         content.addChild(_loc4_);
         _loc4_.setData(BATTLE_RESULTS.common_tooltip("crits/" + param1),param2);
         _loc4_.x = bgShadowMargin.left + contentMargin.left;
         _loc4_.y = param3;
         var param3:Number = param3 + (_loc4_.actualHeight + Utils.instance.MARGIN_AFTER_BLOCK);
         var _loc5_:Separator = Utils.instance.createSeparate(content);
         _loc5_.y = param3 | 0;
         separators.push(_loc5_);
         param3 = param3 + Utils.instance.MARGIN_AFTER_SEPARATE;
         this.critBlocks.push(_loc4_);
         return param3;
      }
      
      private function onIcoLoaded(param1:UILoaderEvent) : void {
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
         this.headerTF.x = this.icon.x + this.icon.width + contentMargin.left | 0;
         this.icon.alpha = this.disabled?0.3:1;
         updateSize();
      }
      
      override protected function onDispose() : void {
         var _loc1_:EfficiencyCritsBlock = null;
         if(this.efficiencyBlock)
         {
            content.removeChild(this.efficiencyBlock);
            this.efficiencyBlock = null;
         }
         if(this.critBlocks)
         {
            while(this.critBlocks.length > 0)
            {
               _loc1_ = this.critBlocks.pop();
               content.removeChild(_loc1_);
               _loc1_ = null;
            }
         }
         super.onDispose();
      }
   }
}
