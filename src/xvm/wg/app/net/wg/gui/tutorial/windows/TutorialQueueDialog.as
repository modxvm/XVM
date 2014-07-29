package net.wg.gui.tutorial.windows
{
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.display.InteractiveObject;
    import net.wg.utils.ILocale;
    
    public class TutorialQueueDialog extends TutorialDialog
    {
        
        public function TutorialQueueDialog()
        {
            this._timePointcuts = [];
            super();
            canClose = false;
            showWindowBg = false;
            isModal = true;
        }
        
        private static var INVALIDATE_MESSAGE:String = "invalidateMessage";
        
        public var titleField:TextField;
        
        private var _waitingTime:int = 0;
        
        private var _playerTimeTextStart:String = "";
        
        private var _playerTimeTextEnd:String = "";
        
        private var _avgTimeText:String = "";
        
        private var _timePointcuts:Array;
        
        private var _baseMessage:String = "";
        
        private var _messageText:String = "";
        
        override protected function configUI() : void
        {
            super.configUI();
            messageField.wordWrap = true;
            messageField.autoSize = TextFieldAutoSize.LEFT;
            this.updateMessageText();
            App.utils.scheduler.scheduleTask(this.updateWaitingTime,1000 * 60);
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(submitBtn);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALIDATE_MESSAGE))
            {
                messageField.htmlText = this._messageText;
            }
        }
        
        override protected function drawData() : void
        {
            this.titleField.text = _data.title;
        }
        
        override public function as_setContent(param1:Object) : void
        {
            super.as_setContent(param1);
            this._baseMessage = _data.message;
            this._playerTimeTextStart = _data.playerTimeTextStart;
            this._playerTimeTextEnd = _data.playerTimeTextEnd;
            this._avgTimeText = _data.avgTimeText;
            this._timePointcuts = _data.timePointcuts;
            this.updateMessageText();
        }
        
        override public function as_updateContent(param1:Object) : void
        {
            this._avgTimeText = param1.avgTimeText;
            this.updateMessageText();
        }
        
        public function updateWaitingTime() : void
        {
            this._waitingTime = this._waitingTime + 1;
            this.updateMessageText();
            App.utils.scheduler.scheduleTask(this.updateWaitingTime,1000 * 60);
        }
        
        private function updateMessageText() : void
        {
            var _loc1_:String = null;
            var _loc2_:* = NaN;
            var _loc3_:ILocale = null;
            if(messageField)
            {
                _loc2_ = this._timePointcuts.length;
                _loc3_ = App.utils.locale;
                if(_loc2_ > 0)
                {
                    if(this._waitingTime < this._timePointcuts[0])
                    {
                        _loc1_ = _loc3_.makeString(BATTLE_TUTORIAL.LABELS_LESS_N_MINUTES,{"minutes":this._timePointcuts[0].toString()});
                    }
                    else if(this._waitingTime > this._timePointcuts[_loc2_ - 1])
                    {
                        _loc1_ = _loc3_.makeString(BATTLE_TUTORIAL.LABELS_MORE_N_MINUTES,{"minutes":this._timePointcuts[_loc2_ - 1].toString()});
                        App.utils.scheduler.cancelTask(this.updateWaitingTime);
                    }
                    else
                    {
                        _loc1_ = _loc3_.makeString(BATTLE_TUTORIAL.LABELS_MINUTES,{"minutes":this._waitingTime.toString()});
                    }
                    
                }
                else
                {
                    _loc1_ = _loc3_.makeString(BATTLE_TUTORIAL.LABELS_MINUTES,{"minutes":this._waitingTime.toString()});
                }
                this._messageText = this._baseMessage?this._baseMessage:"";
                this._messageText = this._messageText + (this._playerTimeTextStart + _loc1_ + this._playerTimeTextEnd);
                this._messageText = this._messageText + this._avgTimeText;
                invalidate(INVALIDATE_MESSAGE);
            }
        }
        
        override protected function onPopulate() : void
        {
            window.getBackground().visible = false;
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            App.utils.scheduler.cancelTask(this.updateWaitingTime);
            this._timePointcuts = this._timePointcuts.splice(0,this._timePointcuts.length);
        }
    }
}
