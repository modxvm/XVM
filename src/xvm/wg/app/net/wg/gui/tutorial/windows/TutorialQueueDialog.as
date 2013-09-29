package net.wg.gui.tutorial.windows 
{
    import flash.text.*;
    import net.wg.utils.*;
    
    public class TutorialQueueDialog extends net.wg.gui.tutorial.windows.TutorialDialog
    {
        public function TutorialQueueDialog()
        {
            this._timePointcuts = [];
            super();
            canClose = false;
            showWindowBg = false;
            isModal = true;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            messageField.wordWrap = true;
            messageField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.updateMessageText();
            App.utils.scheduler.scheduleTask(this.updateWaitingTime, 1000 * 60);
            App.utils.focusHandler.setFocus(submitBtn);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATE_MESSAGE)) 
            {
                messageField.htmlText = this._messageText;
            }
            return;
        }

        protected override function drawData():void
        {
            this.titleField.text = _data.title;
            return;
        }

        public override function as_setContent(arg1:Object):void
        {
            super.as_setContent(arg1);
            this._baseMessage = _data.message;
            this._playerTimeTextStart = _data.playerTimeTextStart;
            this._playerTimeTextEnd = _data.playerTimeTextEnd;
            this._avgTimeText = _data.avgTimeText;
            this._timePointcuts = _data.timePointcuts;
            this.updateMessageText();
            return;
        }

        public override function as_updateContent(arg1:Object):void
        {
            this._avgTimeText = arg1.avgTimeText;
            this.updateMessageText();
            return;
        }

        public function updateWaitingTime():void
        {
            this._waitingTime = this._waitingTime + 1;
            this.updateMessageText();
            App.utils.scheduler.scheduleTask(this.updateWaitingTime, 1000 * 60);
            return;
        }

        internal function updateMessageText():void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=null;
            if (messageField) 
            {
                loc2 = this._timePointcuts.length;
                loc3 = App.utils.locale;
                if (loc2 > 0) 
                {
                    if (this._waitingTime < this._timePointcuts[0]) 
                    {
                        loc1 = loc3.makeString(BATTLE_TUTORIAL.LABELS_LESS_N_MINUTES, {"minutes":this._timePointcuts[0].toString()});
                    }
                    else if (this._waitingTime > this._timePointcuts[(loc2 - 1)]) 
                    {
                        loc1 = loc3.makeString(BATTLE_TUTORIAL.LABELS_MORE_N_MINUTES, {"minutes":this._timePointcuts[(loc2 - 1)].toString()});
                        App.utils.scheduler.cancelTask(this.updateWaitingTime);
                    }
                    else 
                    {
                        loc1 = loc3.makeString(BATTLE_TUTORIAL.LABELS_MINUTES, {"minutes":this._waitingTime.toString()});
                    }
                }
                else 
                {
                    loc1 = loc3.makeString(BATTLE_TUTORIAL.LABELS_MINUTES, {"minutes":this._waitingTime.toString()});
                }
                this._messageText = this._baseMessage ? this._baseMessage : "";
                this._messageText = this._messageText + (this._playerTimeTextStart + loc1 + this._playerTimeTextEnd);
                this._messageText = this._messageText + this._avgTimeText;
                invalidate(INVALIDATE_MESSAGE);
            }
            return;
        }

        protected override function onPopulate():void
        {
            window.getBackground().visible = false;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            App.utils.scheduler.cancelTask(this.updateWaitingTime);
            this._timePointcuts = this._timePointcuts.splice(0, this._timePointcuts.length);
            return;
        }

        internal static const INVALIDATE_MESSAGE:String="invalidateMessage";

        public var titleField:flash.text.TextField;

        internal var _waitingTime:int=0;

        internal var _playerTimeTextStart:String="";

        internal var _playerTimeTextEnd:String="";

        internal var _avgTimeText:String="";

        internal var _timePointcuts:Array;

        internal var _baseMessage:String="";

        internal var _messageText:String="";
    }
}
