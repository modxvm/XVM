package net.wg.gui.notification 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public class ServiceMessage extends scaleform.clik.core.UIComponent
    {
        public function ServiceMessage()
        {
            super();
            return;
        }

        protected function updateAfterStateChange():void
        {
            isInvalid(LAYOUT_INVALID);
            return;
        }

        public function get messageTopOffset():Number
        {
            return this._messageTopOffset;
        }

        public function set messageTopOffset(arg1:Number):void
        {
            this._messageTopOffset = arg1;
            invalidate(LAYOUT_INVALID);
            return;
        }

        public function get messageBottomOffset():Number
        {
            return this._messageBottomOffset;
        }

        public function set messageBottomOffset(arg1:Number):void
        {
            this._messageBottomOffset = arg1;
            invalidate(LAYOUT_INVALID);
            return;
        }

        public function get buttonPadding():int
        {
            return this._buttonPadding;
        }

        public function set buttonPadding(arg1:int):void
        {
            this._buttonPadding = arg1;
            invalidate(LAYOUT_INVALID);
            return;
        }

        public override function get width():Number
        {
            return actualWidth;
        }

        public override function get height():Number
        {
            return actualHeight;
        }

        public override function dispose():void
        {
            this.textField.removeEventListener(flash.events.TextEvent.LINK, this.onMessageLinkClick);
            this.textField.removeEventListener(flash.events.MouseEvent.CLICK, this.onMessageMouseClick);
            this.btnMoreInfo.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.btnClickHandler);
            this.icon.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.iconLoadingCompleteHandler);
            this.icon.removeEventListener(net.wg.gui.events.UILoaderEvent.IOERROR, this.iconLoadingErrorHandler);
            removeEventListener(flash.events.MouseEvent.CLICK, this.componentClickHandler);
            super.dispose();
            return;
        }

        
        {
            allowBgFill = ["action"];
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*=new flash.text.StyleSheet();
            loc1.setStyle("a:link", {"color":LINK_COLOR_NORMAL, "textDecoration":"underline"});
            loc1.setStyle("a:hover", {"color":LINK_COLOR_HOVER, "textDecoration":"underline"});
            this.textField.styleSheet = loc1;
            this.textField.htmlText = "A long time ago, in a galaxy far, far away..." + "It is a period of civil war. Rebel spaceships, striking from a hidden base, " + "have won their first victory against the evil Galactic Empire.";
            this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.textField.multiline = true;
            this.textField.wordWrap = true;
            this.textField.selectable = true;
            this.background.tabEnabled = false;
            this.markerMc.tabEnabled = false;
            this.btnMoreInfo.tabEnabled = false;
            this.btnMoreInfo.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.btnClickHandler, false, 0, true);
            this.btnMoreInfo.label = App.utils ? App.utils.locale.makeString(MESSENGER.SERVICECHANNELMESSAGES_BATTLERESULTS_BUTTON) : "more info...";
            this.textField.addEventListener(flash.events.TextEvent.LINK, this.onMessageLinkClick, false, 0, true);
            this.textField.addEventListener(flash.events.MouseEvent.CLICK, this.onMessageMouseClick, false, 0, true);
            this.icon.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.iconLoadingCompleteHandler, false, 0, true);
            this.icon.addEventListener(net.wg.gui.events.UILoaderEvent.IOERROR, this.iconLoadingErrorHandler, false, 0, true);
            addEventListener(flash.events.MouseEvent.CLICK, this.componentClickHandler, false, 0, true);
            return;
        }

        internal function onMessageLinkClick(arg1:flash.events.TextEvent):void
        {
            if (!this._isTFClickedByMBR) 
                dispatchEvent(new net.wg.gui.notification.ServiceMessageEvent(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_LINK_CLICKED, true, false, arg1.text));
            return;
        }

        internal function onMessageMouseClick(arg1:flash.events.MouseEvent):void
        {
            this._isTFClickedByMBR = App.utils.commons.isRightButton(arg1);
            return;
        }

        internal function iconLoadingErrorHandler(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            this.icon.visible = false;
            return;
        }

        internal function iconLoadingCompleteHandler(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            invalidate(LAYOUT_INVALID);
            return;
        }

        public function set data(arg1:Object):void
        {
            this._data = arg1 as net.wg.gui.notification.NotificationInfoVO;
            invalidate(DATA_INVALID);
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=0;
            super.draw();
            if (isInvalid(DATA_INVALID)) 
            {
                if (this._data) 
                {
                    loc1 = this._data.messageVO;
                    this.textField.htmlText = loc1.message;
                    loc2 = loc1.type;
                    if (loc2) 
                        this.markerMc.gotoAndStop(loc2);
                    if (loc1.icon) 
                        this.icon.source = loc1.icon;
                    if (loc1.defaultIcon) 
                        this.icon.sourceAlt = loc1.defaultIcon;
                    if (!(loc2 == null) && allowBgFill.join().indexOf(loc2, 0) > -1) 
                    {
                        this.bmpFill.visible = true;
                        this.bmpFill.repeat = "all";
                        this.bmpFill.startPos = "TL";
                        this.bmpFill.source = loc2 + "BgFill";
                        this.bmpFill.setSize(100, 50);
                    }
                    else 
                        this.bmpFill.visible = false;
                    this.btnMoreInfo.visible = loc1.showMoreVO.enabled;
                }
                invalidate(LAYOUT_INVALID);
            }
            if (isInvalid(LAYOUT_INVALID)) 
            {
                this.textField.y = this._messageTopOffset;
                loc3 = 0;
                if (this.btnMoreInfo.visible) 
                    loc3 = this.btnMoreInfo.height + this._buttonPadding + 8;
                loc4 = this.textField.height;
                loc5 = Math.round(loc4 + this._messageTopOffset + this._messageBottomOffset + loc3);
                loc6 = 3;
                this.icon.x = loc6 + Math.round((this.textField.x - loc6 - this.icon.width) / 2);
                if (this.textField.textHeight < this.icon.height) 
                    this.icon.y = Math.round(this.textField.y + (-this.icon.height + this.textField.textHeight) / 2 + 2);
                this.markerMc.height = loc5 - 2 * this.markerMc.y;
                this.background.height = loc5;
                if (this.btnMoreInfo.visible) 
                    this.btnMoreInfo.y = loc4 + this.textField.y + this._buttonPadding;
                if (this.bmpFill.visible) 
                    this.bmpFill.setSize(this.markerMc.width, loc5 - 2 * this.bmpFill.y);
                dispatchEvent(new flash.events.Event(RESIZED));
            }
            return;
        }

        protected function componentClickHandler(arg1:flash.events.MouseEvent):void
        {
            dispatchEvent(new net.wg.gui.notification.ServiceMessageEvent(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_AREA_CLICKED, true));
            return;
        }

        protected function btnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(new net.wg.gui.notification.ServiceMessageEvent(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_BUTTON_CLICKED, true));
            return;
        }

        internal static const DATA_INVALID:String="dataInv";

        internal static const LAYOUT_INVALID:String="layoutInv";

        internal static const LINK_COLOR_NORMAL:String="#E2D2A2";

        internal static const LINK_COLOR_HOVER:String="#FF0000";

        public static const RESIZED:String="resized";

        public var background:flash.display.MovieClip;

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        public var bmpFill:net.wg.gui.components.controls.BitmapFill;

        public var markerMc:flash.display.MovieClip;

        public var btnMoreInfo:net.wg.gui.components.controls.SoundButtonEx;

        public var textField:flash.text.TextField;

        internal var _messageTopOffset:int=3;

        internal var _messageBottomOffset:int=4;

        internal var _buttonPadding:int=10;

        internal var _isTFClickedByMBR:Boolean=false;

        internal var _data:net.wg.gui.notification.NotificationInfoVO;

        internal static var allowBgFill:Array;
    }
}
