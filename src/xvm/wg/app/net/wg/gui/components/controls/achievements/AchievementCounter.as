package net.wg.gui.components.controls.achievements
{
    import net.wg.gui.lobby.battleResults.CustomAchievement;
    import flash.utils.getDefinitionByName;
    import net.wg.data.constants.Tooltips;
    import net.wg.gui.events.UILoaderEvent;
    import flash.events.MouseEvent;
    
    public class AchievementCounter extends CustomAchievement
    {
        
        public function AchievementCounter()
        {
            super();
        }
        
        public static var COUNTER_TYPE_INVALID:String = "cTypeInv";
        
        public static var COUNTER_VALUE_INVALID:String = "cValueInv";
        
        public static var LAYOUT_INVALID:String = "layoutInvalid";
        
        protected var counter:CounterComponent;
        
        private var _counterType:String;
        
        private var _oldCounterType:String;
        
        private var _counterValue:String;
        
        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            this.applyData();
        }
        
        public function get counterType() : String
        {
            return this._counterType;
        }
        
        public function set counterType(param1:String) : void
        {
            if(this._counterType != param1)
            {
                this._counterType = param1;
                invalidate(COUNTER_TYPE_INVALID);
            }
        }
        
        public function get counterValue() : String
        {
            return this._counterValue;
        }
        
        public function set counterValue(param1:String) : void
        {
            this._counterValue = param1;
            invalidate(COUNTER_VALUE_INVALID);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            loader.mouseChildren = false;
            loader.buttonMode = false;
            this.buttonMode = false;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(COUNTER_TYPE_INVALID))
            {
                if(this._oldCounterType != this._counterType)
                {
                    this._oldCounterType = this._counterType;
                    if(this.counter)
                    {
                        this.counter.parent.removeChild(this.counter);
                        this.counter = null;
                    }
                    if((this._counterType) && !(this._counterType == ""))
                    {
                        if(App.utils)
                        {
                            this.counter = App.utils.classFactory.getComponent(this._counterType,CounterComponent);
                        }
                        else
                        {
                            this.counter = getDefinitionByName(this._counterType) as CounterComponent;
                        }
                        invalidate(LAYOUT_INVALID);
                    }
                }
            }
            if((isInvalid(COUNTER_VALUE_INVALID)) && (this.counter))
            {
                this.counter.text = data.hasOwnProperty("localizedValue")?data.localizedValue:"0";
                this.counter.validateNow();
                invalidate(LAYOUT_INVALID);
            }
            if(isInvalid(LAYOUT_INVALID))
            {
                this.applyLayoutChanges();
            }
        }
        
        override protected function onDispose() : void
        {
            if((this.counter) && (contains(this.counter)))
            {
                removeChild(this.counter);
            }
            super.onDispose();
        }
        
        protected function applyLayoutChanges() : void
        {
            if((this.counter) && (!(loader.width == 0)) && !(loader.height == 0))
            {
                this.counter.x = loader.x + loader.originalWidth - this.counter.actualWidth ^ 0;
                this.counter.y = loader.y + loader.originalHeight - this.counter.actualHeight - this.counter.receiveBottomPadding() ^ 0;
                addChild(this.counter);
            }
        }
        
        protected function applyData() : void
        {
            if(data)
            {
                if(data.hasOwnProperty("counterType"))
                {
                    this.counterType = data["counterType"];
                }
            }
        }
        
        protected function showToolTip() : void
        {
            if(data)
            {
                if(data.name == "markOfMastery")
                {
                    App.toolTipMgr.showSpecial(Tooltips.MARK_OF_MASTERY,null,data.block,data.name,data.value);
                }
                else if(data.name == "marksOnGun")
                {
                    App.toolTipMgr.showSpecial(Tooltips.MARKS_ON_GUN_ACHIEVEMENT,null,data.dossierType,data.dossierCompDescr,data.block,data.name,data.isRare,data.isDossierForCurrentUser);
                }
                else
                {
                    App.toolTipMgr.showSpecial(Tooltips.ACHIEVEMENT,null,data.dossierType,data.dossierCompDescr,data.block,data.name,data.isRare,data.isDossierForCurrentUser);
                }
                
            }
        }
        
        override protected function onComplete(param1:UILoaderEvent) : void
        {
            super.onComplete(param1);
            invalidate(LAYOUT_INVALID);
        }
        
        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            super.handleMouseRollOver(param1);
            this.showToolTip();
        }
        
        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            super.handleMouseRollOut(param1);
            App.toolTipMgr.hide();
        }
    }
}
