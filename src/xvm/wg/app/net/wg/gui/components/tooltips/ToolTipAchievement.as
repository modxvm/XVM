package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.interfaces.ICounterComponent;
    import net.wg.data.managers.ITooltipProps;
    import flash.display.DisplayObject;
    import net.wg.gui.components.tooltips.VO.AchievementVO;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
    import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.achievements.GreyRibbonCounter;
    import net.wg.gui.components.controls.achievements.YellowRibbonCounter;
    import net.wg.gui.components.controls.achievements.BeigeCounter;
    import net.wg.gui.components.controls.achievements.RedCounter;
    import net.wg.data.constants.Values;
    
    public class ToolTipAchievement extends ToolTipSpecial
    {
        
        public function ToolTipAchievement()
        {
            super();
            this.headerTF = content.headerTF;
            this.descrTF = content.descrTF;
            this.historyTF = content.historyTF;
            this.addInfoTF = content.addInfoTF;
            this.vLeftTF = content.vLeftTF;
            this.notEnoughTF = content.notEnoughTF;
            this.isInDossierTF = content.isInDossierTF;
            this.whiteBg = content.whiteBg;
            this.whiteBg1 = content.whiteBg1;
            this.icon = content.icon;
            this.icon.autoSize = false;
            this.whiteBg.width = 10;
            this.whiteBg.visible = false;
            this.whiteBg1.width = 10;
            this.whiteBg1.visible = false;
            this.defaultBottomPadding = contentMargin.bottom;
        }
        
        private var headerTF:TextField = null;
        
        private var descrTF:TextField = null;
        
        private var historyTF:TextField = null;
        
        private var historyHeaderTF:TextField = null;
        
        private var vLeftTF:TextField = null;
        
        private var notEnoughTF:TextField = null;
        
        private var isInDossierTF:TextField = null;
        
        private var addInfoTF:TextField = null;
        
        private var whiteBg:Sprite = null;
        
        private var whiteBg1:Sprite = null;
        
        private var icon:UILoaderAlt = null;
        
        private var counter:ICounterComponent = null;
        
        private var flagsBlocks:Vector.<AchievementsCustomBlockItem> = null;
        
        private var TYPE_CLASS:String = "class";
        
        private var TYPE_SERIES:String = "series";
        
        private var TYPE_CUSTOM:String = "custom";
        
        private var TYPE_REPEATABLE:String = "repeatable";
        
        private var defaultBottomPadding:Number = 0;
        
        private var ICO_DIMENSION:Number = 180;
        
        private var ICO_SHADOW:Number = 16;
        
        private var isSeparateLast:Boolean = false;
        
        override public function build(param1:Object, param2:ITooltipProps) : void
        {
            super.build(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:AchievementsCustomBlockItem = null;
            if(content)
            {
                if(this.counter)
                {
                    content.removeChild(DisplayObject(this.counter));
                    this.counter = null;
                }
                if(this.historyHeaderTF)
                {
                    content.removeChild(this.historyHeaderTF);
                    this.historyHeaderTF = null;
                }
            }
            if(this.flagsBlocks)
            {
                while(this.flagsBlocks.length > 0)
                {
                    _loc1_ = this.flagsBlocks.pop();
                    _loc1_.dispose();
                    content.removeChild(_loc1_);
                    _loc1_ = null;
                }
            }
            super.onDispose();
        }
        
        override public function toString() : String
        {
            return "[WG ToolTipAchievement " + name + "]";
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function redraw() : void
        {
            var _loc4_:* = NaN;
            var _loc5_:AchievementVO = null;
            var _loc9_:String = null;
            var _loc10_:String = null;
            var _loc1_:ILocale = App.utils.locale;
            var _loc2_:uint = 0;
            var _loc3_:uint = 0;
            _loc4_ = 300;
            _loc5_ = new AchievementVO(_data);
            blockResults = new Vector.<ToolTipBlockResultVO>();
            this.flagsBlocks = new Vector.<AchievementsCustomBlockItem>();
            topPosition = bgShadowMargin.top + contentMargin.top;
            var _loc6_:Number = bgShadowMargin.left + contentMargin.left;
            var _loc7_:Separator = null;
            separators = new Vector.<Separator>();
            this.headerTF.autoSize = TextFieldAutoSize.LEFT;
            this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc5_.aName,Utils.instance.COLOR_HEADER,18,"$TitleFont");
            this.headerTF.width = this.headerTF.textWidth + 5;
            this.headerTF.x = _loc6_;
            this.headerTF.y = topPosition;
            topPosition = topPosition + (this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
            _loc4_ = Math.max(_loc4_,this.headerTF.width + bgShadowMargin.horizontal + contentMargin.horizontal);
            if(_loc5_.icon)
            {
                this.icon.source = _loc5_.icon;
                this.icon.sourceAlt = "../maps/icons/achievement/big/noImage.png";
                this.icon.y = topPosition - this.ICO_SHADOW;
                topPosition = topPosition + (this.ICO_DIMENSION + Utils.instance.MARGIN_AFTER_BLOCK - this.ICO_SHADOW * 2);
                _loc7_ = Utils.instance.createSeparate(content);
                _loc7_.y = topPosition;
                separators.push(_loc7_);
                topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            }
            else
            {
                this.icon.width = this.icon.height = 10;
                this.icon.visible = false;
            }
            this.applyDescriptionParams(_loc5_.description,_loc4_,_loc6_);
            this.applyClassParams(_loc5_,_loc6_);
            if((_loc5_.vehicles) && _loc5_.vehicles.length > 0)
            {
                _loc7_ = Utils.instance.createSeparate(content);
                _loc7_.y = topPosition;
                separators.push(_loc7_);
                this.whiteBg.y = topPosition;
                topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
                _loc3_ = _loc5_.params.length;
                _loc9_ = "";
                _loc2_ = 0;
                while(_loc2_ < _loc3_)
                {
                    _loc9_ = _loc9_ + Utils.instance.htmlWrapper(_loc1_.makeString(TOOLTIPS.ACHIEVEMENT_PARAMS + "/" + _loc5_.params[_loc2_].id),Utils.instance.COLOR_ADD_INFO,14,"$TitleFont");
                    _loc2_++;
                }
                this.vLeftTF.htmlText = _loc9_;
                this.vLeftTF.width = this.vLeftTF.textWidth + 5;
                this.vLeftTF.x = _loc6_;
                this.vLeftTF.y = topPosition;
                topPosition = topPosition + (this.vLeftTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
                _loc3_ = _loc5_.vehicles.length;
                _loc2_ = 0;
                while(_loc2_ < _loc3_)
                {
                    topPosition = this.addCustomBlock(content,_loc5_.vehicles[_loc2_],topPosition);
                    _loc2_++;
                }
                topPosition = topPosition + Utils.instance.MARGIN_AFTER_BLOCK;
                if(_loc5_.vehiclesLeft)
                {
                    _loc9_ = Utils.instance.htmlWrapper(_loc1_.makeString(TOOLTIPS.SUITABLEVEHICLE_MORE),Utils.instance.COLOR_ADD_INFO,14,"$TitleFont") + " " + Utils.instance.htmlWrapper(_loc5_.vehiclesLeft.toString(),Utils.instance.COLOR_NUMBER,14,"$TitleFont");
                    this.notEnoughTF.htmlText = _loc9_;
                    this.notEnoughTF.width = this.notEnoughTF.textWidth + 5;
                    this.notEnoughTF.x = _loc6_;
                    this.notEnoughTF.y = topPosition;
                    topPosition = topPosition + (this.notEnoughTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
                }
                else
                {
                    this.notEnoughTF.x = 0;
                    this.notEnoughTF.y = 0;
                    this.notEnoughTF.width = 10;
                    this.notEnoughTF.visible = false;
                }
                this.whiteBg.height = topPosition - this.whiteBg.y;
                this.whiteBg.visible = true;
                contentMargin.bottom = 0;
            }
            else
            {
                this.vLeftTF.x = 0;
                this.vLeftTF.y = 0;
                this.vLeftTF.width = 10;
                this.vLeftTF.visible = false;
                this.notEnoughTF.x = 0;
                this.notEnoughTF.y = 0;
                this.notEnoughTF.width = 10;
                this.notEnoughTF.visible = false;
            }
            var _loc8_:String = this.getInfoText(_loc5_.type,_loc5_.params,_loc5_.value,_loc5_.localizedValue,_loc5_.achievedOn,_loc5_.closeToRecord);
            if(_loc8_ != "")
            {
                this.counter = this.getInfoCounter(_loc5_.type,_loc5_.value,_loc5_.localizedValue,_component);
                _loc7_ = Utils.instance.createSeparate(content);
                _loc7_.y = topPosition;
                separators.push(_loc7_);
                this.whiteBg.y = topPosition;
                topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
                if(this.counter)
                {
                    this.counter.x = _loc6_;
                    this.counter.y = topPosition + 10 - (this.counter.height >> 1);
                    content.addChild(DisplayObject(this.counter));
                    this.addInfoTF.x = this.counter.x + this.counter.width + 10 | 0;
                }
                else
                {
                    this.addInfoTF.x = _loc6_;
                }
                this.addInfoTF.y = topPosition;
                this.addInfoTF.multiline = true;
                this.addInfoTF.wordWrap = true;
                this.addInfoTF.htmlText = _loc8_;
                this.addInfoTF.width = this.addInfoTF.textWidth + 5;
                this.addInfoTF.height = this.addInfoTF.textHeight + 5;
                if(this.counter)
                {
                    topPosition = Math.max(this.addInfoTF.y + this.addInfoTF.textHeight,this.counter.y + this.counter.height - 5) + Utils.instance.MARGIN_AFTER_BLOCK | 0;
                }
                else
                {
                    topPosition = this.addInfoTF.y + this.addInfoTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
                }
                this.whiteBg.height = topPosition - this.whiteBg.y;
                _loc7_ = Utils.instance.createSeparate(content);
                _loc7_.y = topPosition;
                separators.push(_loc7_);
                topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
                this.whiteBg.visible = true;
                contentMargin.bottom = 0;
                this.isSeparateLast = true;
            }
            else
            {
                this.addInfoTF.x = 0;
                this.addInfoTF.y = 0;
                this.addInfoTF.width = 10;
                this.addInfoTF.visible = false;
            }
            if(_loc5_.historyDescr)
            {
                this.isSeparateLast = false;
                _loc10_ = _loc1_.makeString(TOOLTIPS.ACHIEVEMENT_HISTORYDESCRIPTIONHEADER);
                this.historyHeaderTF = Utils.instance.addHeader("historyHeader",_loc6_,topPosition,_loc10_);
                content.addChild(this.historyHeaderTF);
                topPosition = this.historyHeaderTF.y + this.historyHeaderTF.textHeight + Utils.instance.MARGIN_AFTER_SUBHEADER | 0;
                this.historyTF.autoSize = TextFieldAutoSize.LEFT;
                this.historyTF.htmlText = Utils.instance.htmlWrapper(_loc5_.historyDescr,Utils.instance.COLOR_SUB_NORMAL,12,"$TextFont");
                this.historyTF.width = _loc4_ != 0?_loc4_ - _loc6_:this.historyTF.textWidth + 5;
                this.historyTF.x = _loc6_;
                this.historyTF.y = topPosition;
                topPosition = topPosition + (this.historyTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
                contentMargin.bottom = this.defaultBottomPadding;
            }
            else
            {
                this.historyTF.x = 0;
                this.historyTF.y = 0;
                this.historyTF.width = 10;
                this.historyTF.visible = false;
            }
            if(!_loc5_.isInDossier)
            {
                if(this.isSeparateLast)
                {
                    _loc7_ = separators.pop();
                    content.removeChild(_loc7_);
                    _loc7_ = null;
                }
                else
                {
                    this.whiteBg1.y = topPosition;
                    this.whiteBg1.visible = true;
                }
                _loc7_ = Utils.instance.createSeparate(content);
                _loc7_.y = topPosition;
                separators.push(_loc7_);
                topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
                this.isInDossierTF.y = topPosition;
                this.isInDossierTF.x = _loc6_;
                this.isInDossierTF.text = this.getNotAvailableText();
                this.isInDossierTF.width = this.isInDossierTF.textWidth + 5 | 0;
                topPosition = topPosition + (this.isInDossierTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
                if(this.whiteBg1.visible)
                {
                    this.whiteBg1.height = topPosition - _loc7_.y;
                }
                else
                {
                    this.whiteBg.height = topPosition - this.whiteBg.y;
                }
                contentMargin.bottom = 0;
                this.isSeparateLast = false;
            }
            else
            {
                this.isInDossierTF.x = 0;
                this.isInDossierTF.y = 0;
                this.isInDossierTF.width = 10;
                this.isInDossierTF.visible = false;
            }
            if(this.isSeparateLast)
            {
                _loc7_ = separators.pop();
                content.removeChild(_loc7_);
                _loc7_ = null;
            }
            _loc5_ = null;
            updatePositions();
            super.redraw();
        }
        
        protected function getNotAvailableText() : String
        {
            return TOOLTIPS.ACHIEVEMENT_ISNOTINDOSSIER;
        }
        
        protected function applyDescriptionParams(param1:String, param2:Number, param3:Number) : void
        {
            if(param1)
            {
                this.descrTF.autoSize = TextFieldAutoSize.LEFT;
                this.descrTF.htmlText = param1;
                this.descrTF.width = param2 != 0?param2 - param3:this.descrTF.textWidth + 5;
                this.descrTF.x = param3;
                this.descrTF.y = topPosition;
                topPosition = topPosition + (this.descrTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
            }
            else
            {
                this.descrTF.x = 0;
                this.descrTF.y = 0;
                this.descrTF.width = 10;
                this.descrTF.visible = false;
            }
        }
        
        protected function applyClassParams(param1:AchievementVO, param2:Number) : void
        {
            var _loc3_:ToolTipBlockResultVO = null;
            var _loc4_:ToolTipBlockVO = null;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc7_:String = null;
            _loc3_ = null;
            if(param1.classParams)
            {
                _loc4_ = new ToolTipBlockVO();
                _loc4_.leftText = "";
                _loc4_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
                _loc4_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
                _loc4_.contener = content;
                _loc4_.startYPos = topPosition;
                _loc4_.childrenNamePrefix = "classParams";
                _loc4_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
                _loc5_ = param1.classParams.length;
                _loc6_ = 0;
                while(_loc6_ < _loc5_)
                {
                    _loc4_.leftText = _loc4_.leftText + (Utils.instance.htmlWrapper(App.utils.locale.integer(param1.classParams[_loc6_]),Utils.instance.COLOR_NUMBER,12,"$TextFont") + "<br/>");
                    _loc7_ = ACHIEVEMENTS.achievement("rank" + (_loc5_ - _loc6_).toString());
                    _loc4_.rightTextList.push(new ToolTipBlockRightListItemVO(_loc7_));
                    _loc6_++;
                }
                _loc3_ = Utils.instance.createBlock(_loc4_,param2);
                blockResults.push(_loc3_);
                topPosition = _loc3_.startYPos;
                hasIcon = _loc3_.hasIcons?true:hasIcon;
                leftPartMaxW = _loc3_.leftPartMaxW > leftPartMaxW?_loc3_.leftPartMaxW:leftPartMaxW;
            }
        }
        
        override protected function updateSize() : void
        {
            super.updateSize();
            if(this.icon.visible)
            {
                this.icon.x = content.width + contentMargin.right + bgShadowMargin.right - this.ICO_DIMENSION >> 1;
            }
            var _loc1_:Number = content.width + contentMargin.right - bgShadowMargin.left;
            if(this.whiteBg.visible)
            {
                this.whiteBg.x = bgShadowMargin.left;
                this.whiteBg.width = _loc1_;
            }
            if(this.whiteBg1.visible)
            {
                this.whiteBg1.x = bgShadowMargin.left;
                this.whiteBg1.width = _loc1_;
            }
        }
        
        private function addCustomBlock(param1:MovieClip, param2:Object, param3:Number) : Number
        {
            var _loc4_:AchievementsCustomBlockItem = App.utils.classFactory.getComponent("AchievementsCustomBlockItem",AchievementsCustomBlockItem);
            _loc4_.setData(param2);
            _loc4_.x = bgShadowMargin.left + contentMargin.left;
            _loc4_.y = param3;
            param1.addChild(_loc4_);
            this.flagsBlocks.push(_loc4_);
            var param3:Number = param3 + 34;
            return param3;
        }
        
        private function getInfoText(param1:String, param2:Array, param3:Number, param4:String, param5:String = null, param6:Array = null) : String
        {
            var _loc11_:String = null;
            var _loc12_:String = null;
            var _loc13_:String = null;
            var _loc7_:* = "";
            var _loc8_:ILocale = App.utils.locale;
            var _loc9_:uint = 0;
            var _loc10_:uint = 0;
            if(param2)
            {
                _loc9_ = param2.length;
                _loc11_ = "";
                switch(param1)
                {
                    case this.TYPE_SERIES:
                        _loc10_ = 0;
                        while(_loc10_ < _loc9_)
                        {
                            _loc11_ = _loc8_.makeString(TOOLTIPS.ACHIEVEMENT_PARAMS + "/" + param2[_loc10_].id) + " " + param2[_loc10_].val;
                            _loc7_ = _loc7_ + Utils.instance.htmlWrapper(_loc11_,Utils.instance.COLOR_NORMAL,12,"$TextFont");
                            _loc10_++;
                        }
                        break;
                    case this.TYPE_CLASS:
                        _loc7_ = this.getClassInfoText(param3,param4,param2);
                        break;
                    case this.TYPE_REPEATABLE:
                        if(param3 > 0)
                        {
                            _loc7_ = Utils.instance.htmlWrapper(_loc8_.makeString(TOOLTIPS.ACHIEVEMENT_ALLACHIEVEMENTS),Utils.instance.COLOR_NORMAL,12,"$TextFont") + " " + Utils.instance.htmlWrapper(param4,Utils.instance.COLOR_NUMBER,12,"$TextFont");
                        }
                        break;
                }
            }
            if(param5)
            {
                _loc7_ = _loc7_ + ("<br/>" + Utils.instance.htmlWrapper(_loc8_.makeString(TOOLTIPS.ACHIEVEMENT_ACHIEVEDON) + param5,Utils.instance.COLOR_SUB_NORMAL,12,"$TextFont"));
            }
            if(param6)
            {
                _loc7_ = _loc7_ + ("<br/><font size=\"7\"></font><br/>" + Utils.instance.htmlWrapper(_loc8_.makeString(TOOLTIPS.ACHIEVEMENT_CLOSETORECORD),Utils.instance.COLOR_ADD_INFO,12,"$TextFont"));
                _loc9_ = param6.length;
                _loc10_ = 0;
                while(_loc10_ < _loc9_)
                {
                    _loc12_ = param6[_loc10_][0] + ": ";
                    _loc13_ = param6[_loc10_][1].toString();
                    _loc7_ = _loc7_ + ("<br/>" + Utils.instance.htmlWrapper(_loc12_,Utils.instance.COLOR_SUB_NORMAL,12,"$TextFont"));
                    _loc7_ = _loc7_ + Utils.instance.htmlWrapper(_loc13_,Utils.instance.COLOR_NUMBER,12,"$TextFont");
                    _loc10_++;
                }
            }
            return _loc7_;
        }
        
        protected function getClassInfoText(param1:Number, param2:String, param3:Array) : String
        {
            var _loc4_:* = "";
            var _loc5_:ILocale = App.utils.locale;
            if(param1 < 5)
            {
                _loc4_ = Utils.instance.htmlWrapper(_loc5_.makeString(TOOLTIPS.ACHIEVEMENT_CURRENTDEGREE) + " " + param2,Utils.instance.COLOR_NORMAL,12,"$TextFont");
            }
            var _loc6_:int = param3.length;
            var _loc7_:* = 0;
            while(_loc7_ < _loc6_)
            {
                if(_loc4_ != "")
                {
                    _loc4_ = _loc4_ + "<br/><font size=\"7\"></font><br/>";
                }
                _loc4_ = _loc4_ + (Utils.instance.htmlWrapper(_loc5_.makeString(TOOLTIPS.ACHIEVEMENT_PARAMS + "/" + ("left" + (param1 - 1))) + " " + _loc5_.makeString(TOOLTIPS.ACHIEVEMENT_PARAMS + "/" + param3[_loc7_].id),Utils.instance.COLOR_ADD_INFO,12,"$TextFont") + ": " + Utils.instance.htmlWrapper(_loc5_.numberWithoutZeros(param3[_loc7_].val),Utils.instance.COLOR_NUMBER,12,"$TextFont"));
                _loc7_++;
            }
            return _loc4_;
        }
        
        protected function getInfoCounter(param1:String, param2:Number, param3:String, param4:String) : ICounterComponent
        {
            var _loc5_:ICounterComponent = null;
            if(param3)
            {
                _loc5_ = null;
            }
            switch(param1)
            {
                case this.TYPE_SERIES:
                    if(param4 == COMPONENT_PROFILE_VEHICLE)
                    {
                        _loc5_ = App.utils.classFactory.getComponent("GreyCounter_UI",GreyRibbonCounter);
                    }
                    else
                    {
                        _loc5_ = App.utils.classFactory.getComponent("YellowCounter_UI",YellowRibbonCounter);
                    }
                    break;
                case this.TYPE_CLASS:
                    if(param2 < 5)
                    {
                        _loc5_ = App.utils.classFactory.getComponent("BeigeCounter_UI",BeigeCounter);
                    }
                    break;
                case this.TYPE_REPEATABLE:
                    _loc5_ = App.utils.classFactory.getComponent("RedCounter_UI",RedCounter);
                    break;
            }
            if(_loc5_)
            {
                _loc5_.text = param3 != Values.EMPTY_STR?param3:"0";
                _loc5_.validateNow();
            }
            return _loc5_;
        }
    }
}
