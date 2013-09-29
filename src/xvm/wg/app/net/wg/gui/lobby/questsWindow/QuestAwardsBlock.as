package net.wg.gui.lobby.questsWindow 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class QuestAwardsBlock extends scaleform.clik.core.UIComponent
    {
        public function QuestAwardsBlock()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.awardTF.text = QUESTS.QUESTS_TABS_AWARD_TEXT;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }

        public function setAwards(arg1:String):void
        {
            this._awardsStr = arg1;
            this.awardDescrTF.htmlText = this._awardsStr;
            invalidateData();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (this._awardsStr) 
                {
                    loc2 = 20;
                    if (this.awardDescrTF.numLines > 1) 
                    {
                        loc2 = 10;
                    }
                    else 
                    {
                        loc2 = 20;
                    }
                    this.awardTF.y = TEXT_TOP + loc2;
                    this.awardDescrTF.y = TEXT_TOP + loc2 + 1;
                    loc3 = this.awardDescrTF.y + this.awardDescrTF.textHeight + loc2;
                    this.maskMC.height = loc3 <= this.flagBody.height ? loc3 : this.flagBody.height;
                    this.flagBottom.y = (this.maskMC.height - 1);
                    loc1 = this.maskMC.height;
                }
                else 
                {
                    loc1 = 0;
                }
                setSize(this.width, loc1);
                dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE));
            }
            return;
        }

        internal static const TEXT_TOP:int=4;

        public var awardTF:flash.text.TextField;

        public var awardDescrTF:flash.text.TextField;

        public var flagBottom:flash.display.MovieClip;

        public var flagBody:flash.display.MovieClip;

        public var maskMC:flash.display.MovieClip;

        internal var _awardsStr:String="";
    }
}
