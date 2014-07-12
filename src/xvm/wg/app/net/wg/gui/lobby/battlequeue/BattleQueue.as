package net.wg.gui.lobby.battlequeue
{
    import net.wg.infrastructure.base.meta.impl.BattleQueueMeta;
    import net.wg.infrastructure.base.meta.IBattleQueueMeta;
    import net.wg.gui.components.icons.BattleTypeIcon;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.ScrollingListEx;
    import scaleform.clik.events.ButtonEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.InputEvent;
    
    public class BattleQueue extends BattleQueueMeta implements IBattleQueueMeta
    {
        
        public function BattleQueue() {
            super();
        }
        
        public var battleIcon:BattleTypeIcon;
        
        public var titleField:TextField;
        
        public var descriptionLabel:TextField;
        
        public var timerLabel:TextField;
        
        public var playersLabel:TextField;
        
        public var titleFieldType:TextField;
        
        public var exitButton:SoundButtonEx;
        
        public var startButton:SoundButtonEx;
        
        public var listByType:ScrollingListEx;
        
        override protected function configUI() : void {
            this.titleFieldType.visible = false;
            this.listByType.mouseChildren = false;
            this.startButton.addEventListener(ButtonEvent.CLICK,this.onStartClick);
            this.exitButton.addEventListener(ButtonEvent.CLICK,this.onExitButton);
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
            super.configUI();
        }
        
        private function onExitButton(param1:ButtonEvent) : void {
            exitClickS();
        }
        
        private function onStartClick(param1:ButtonEvent) : void {
            startClickS();
        }
        
        public function as_setTimer(param1:String, param2:String) : void {
            if(param2 != null)
            {
                param1 = param1 + (" <font color=\"#FFFFFF\">" + param2 + "</font>");
            }
            this.timerLabel.htmlText = param1;
        }
        
        public function as_setType(param1:Number) : void {
            this.battleIcon.typeByNumber = param1 + 1;
            this.titleField.text = MENU.loading_battletypes(param1.toString());
            this.descriptionLabel.text = MENU.loading_battletypes_desc(param1.toString());
        }
        
        public function as_setPlayers(param1:String) : void {
            this.playersLabel.htmlText = param1;
        }
        
        public function as_setListByType(param1:Object) : void {
            var _loc2_:Array = null;
            _loc2_ = [];
            var _loc3_:uint = 0;
            while(_loc3_ < param1.data.length)
            {
                _loc2_.push({
                    "type":param1.data[_loc3_][0],
                    "count":param1.data[_loc3_][1]
                });
            _loc3_++;
        }
        this.titleFieldType.text = param1.title;
        this.titleFieldType.visible = true;
        this.listByType.visible = true;
        this.listByType.dataProvider = new DataProvider(_loc2_);
    }
    
    public function as_showStart(param1:Boolean) : void {
        this.startButton.visible = param1;
    }
    
    public function as_showExit(param1:Boolean) : void {
        this.exitButton.visible = param1;
    }
    
    override public function updateStage(param1:Number, param2:Number) : void {
        this.x = param1 - this.actualWidth >> 1;
        this.y = Math.min(-parent.y + (param2 - this.actualHeight >> 1),80);
    }
    
    override protected function onDispose() : void {
        App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
        this.listByType.disposeRenderers();
        if(this.startButton.hasEventListener(ButtonEvent.CLICK))
        {
            this.startButton.removeEventListener(ButtonEvent.CLICK,this.onStartClick);
        }
        if(this.exitButton.hasEventListener(ButtonEvent.CLICK))
        {
            this.exitButton.removeEventListener(ButtonEvent.CLICK,this.onExitButton);
        }
        super.onDispose();
    }
    
    override public function toString() : String {
        return "[WG BattleQueue " + name + "]";
    }
    
    private function handleEscape(param1:InputEvent) : void {
        onEscapeS();
    }
}
}
