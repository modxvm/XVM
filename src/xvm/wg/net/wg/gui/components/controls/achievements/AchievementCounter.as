package net.wg.gui.components.controls.achievements 
{
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.battleResults.*;
    import net.wg.gui.lobby.profile.data.*;
    
    public class AchievementCounter extends net.wg.gui.lobby.battleResults.CustomAchievement
    {
        public function AchievementCounter()
        {
            super();
            return;
        }

        protected override function onComplete(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            super.onComplete(arg1);
            invalidate(LAYOUT_INVALID);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            mouseChildren = true;
            loader.mouseChildren = false;
            loader.buttonMode = true;
            this.buttonMode = true;
            loader.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.loaderMouseRollOver, false, 0, true);
            loader.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.loaderMouseRollOut, false, 0, true);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            super.draw();
            if (isInvalid(COUNTER_TYPE_INVALID)) 
            {
                if (this._counterType != GREY) 
                    if (this._counterType != YELLOW) 
                        if (this._counterType != RED) 
                            if (this._counterType != BEIGE) 
                                if (this._counterType == SMALL) 
                                    loc1 = "SmallCounter_UI";
                            else 
                                loc1 = "BeigeCounter_UI";
                        else 
                            loc1 = "RedCounter_UI";
                    else 
                        loc1 = "YellowCounter_UI";
                else 
                    loc1 = "GreyCounter_UI";
                if (this.currentCounterClassName != loc1) 
                {
                    this.currentCounterClassName = loc1;
                    if (this.counter) 
                    {
                        this.counter.parent.removeChild(this.counter);
                        this.counter = null;
                    }
                    if (loc1 && !(loc1 == "")) 
                    {
                        if (App.utils) 
                            this.counter = App.utils.classFactory.getComponent(loc1, net.wg.gui.components.controls.achievements.CounterComponent);
                        else 
                            this.counter = flash.utils.getDefinitionByName(loc1) as net.wg.gui.components.controls.achievements.CounterComponent;
                        invalidate(LAYOUT_INVALID);
                    }
                }
            }
            if (isInvalid(COUNTER_VALUE_INVALID) && this.counter) 
            {
                this.counter.text = data.hasOwnProperty("value") ? data.value : "0";
                this.counter.validateNow();
                invalidate(LAYOUT_INVALID);
            }
            if (isInvalid(LAYOUT_INVALID)) 
                this.applyLayoutChanges();
            return;
        }

        protected function applyLayoutChanges():void
        {
            if (this.counter && !(loader.width == 0) && !(loader.height == 0)) 
            {
                this.counter.x = loader.x + loader.originalWidth - this.counter.actualWidth ^ 0;
                this.counter.y = loader.y + loader.originalHeight - this.counter.actualHeight - this.counter.receiveBottomPadding() ^ 0;
                addChild(this.counter);
            }
            return;
        }

        public override function set data(arg1:Object):void
        {
            super.data = arg1;
            this.applyData();
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.setData(arg1);
            return;
        }

        protected function applyData():void
        {
            if (data) 
                if (data.hasOwnProperty("counterType")) 
                    this.counterType = data["counterType"];
            return;
        }

        public function get counterType():String
        {
            return this._counterType;
        }

        public function set counterType(arg1:String):void
        {
            this._counterType = arg1;
            invalidate(COUNTER_TYPE_INVALID);
            return;
        }

        public function get counterValue():String
        {
            return this._counterValue;
        }

        public function set counterValue(arg1:String):void
        {
            this._counterValue = arg1;
            invalidate(COUNTER_VALUE_INVALID);
            return;
        }

        protected override function handleStageChange(arg1:flash.events.Event):void
        {
            if (arg1.type == flash.events.Event.ADDED_TO_STAGE) 
            {
                removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleStageChange, false);
                addEventListener(flash.events.Event.RENDER, validateNow, false, 0, true);
                addEventListener(flash.events.Event.ENTER_FRAME, handleEnterFrameValidation, false, 0, true);
                if (stage != null) 
                    stage.invalidate();
            }
            return;
        }

        protected function loaderMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            var loc1:*=data as net.wg.gui.lobby.profile.data.ProfileAchievementVO;
            if (loc1) 
                if (loc1.name != "markOfMastery") 
                    App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.ACHIEVMENT, null, loc1.dossierType, loc1.dossierCompDescr, loc1.name, loc1.isRare, loc1.isDossierForCurrentUser);
                else 
                    App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANK_CLASS, null, loc1.name, loc1.value);
            return;
        }

        protected function loaderMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            App.toolTipMgr.hide();
            return;
        }

        public override function dispose():void
        {
            if (loader) 
            {
                loader.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.loaderMouseRollOver);
                loader.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.loaderMouseRollOut);
            }
            if (this.counter && contains(this.counter)) 
                removeChild(this.counter);
            super.dispose();
            return;
        }

        public static const COUNTER_TYPE_INVALID:String="cTypeInv";

        public static const COUNTER_VALUE_INVALID:String="cValueInv";

        public static const LAYOUT_INVALID:String="layoutInvalid";

        public static const NONE:String="";

        public static const RED:String="red";

        public static const GREY:String="grey";

        public static const YELLOW:String="yellow";

        public static const BEIGE:String="beige";

        public static const SMALL:String="small";

        protected var counter:net.wg.gui.components.controls.achievements.CounterComponent;

        internal var currentCounterClassName:String;

        internal var _counterType:String;

        internal var _counterValue:String;
    }
}
