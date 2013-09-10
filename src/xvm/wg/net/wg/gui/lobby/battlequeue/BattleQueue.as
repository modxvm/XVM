package net.wg.gui.lobby.battlequeue 
{
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.icons.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class BattleQueue extends net.wg.infrastructure.base.meta.impl.BattleQueueMeta implements net.wg.infrastructure.base.meta.IBattleQueueMeta
    {
        public function BattleQueue()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            this.titleFieldLevel.visible = false;
            this.listByLevel.visible = false;
            this.titleFieldType.visible = false;
            this.startButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onStartClick);
            this.exitButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onExitButton);
            App.gameInputMgr.setKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN, this.handleEscape, true);
            super.configUI();
            return;
        }

        internal function onExitButton(arg1:scaleform.clik.events.ButtonEvent):void
        {
            exitClickS();
            return;
        }

        internal function onStartClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            startClickS();
            return;
        }

        public function as_setTimer(arg1:String, arg2:String):void
        {
            if (arg2 != null) 
            {
                arg1 = arg1 + (" <font color=\"#FFFFFF\">" + arg2 + "</font>");
            }
            this.timerLabel.htmlText = arg1;
            return;
        }

        public function as_setType(arg1:Number):void
        {
            this.battleIcon.typeByNumber = arg1 + 1;
            this.battleIconBig.typeByNumber = arg1 + 1;
            this.titleField.text = MENU.loading_battletypes(arg1.toString());
            this.descriptionLabel.text = MENU.loading_battletypes_desc(arg1.toString());
            return;
        }

        public function as_setPlayers(arg1:String, arg2:Number):void
        {
            this.playersLabel.htmlText = arg1 + " <font color=\"#FFFFFF\">" + arg2.toString() + "</font>";
            return;
        }

        public function as_setListByLevel(arg1:Object):void
        {
            var loc1:*=null;
            loc1 = new Array();
            var loc2:*=0;
            while (loc2 < arg1.data.length) 
            {
                loc1.push({"type":arg1.data.length - loc2, "count":arg1.data[loc2]});
                ++loc2;
            }
            this.titleFieldLevel.text = arg1.title;
            this.titleFieldLevel.visible = true;
            this.listByLevel.visible = true;
            this.listByLevel.dataProvider = new scaleform.clik.data.DataProvider(loc1);
            return;
        }

        public function as_setListByType(arg1:Object):void
        {
            var loc1:*=null;
            loc1 = new Array();
            var loc2:*=0;
            while (loc2 < arg1.data.length) 
            {
                loc1.push({"type":arg1.data[loc2][0], "count":arg1.data[loc2][1]});
                ++loc2;
            }
            this.titleFieldType.text = arg1.title;
            this.titleFieldType.visible = true;
            this.listByType.visible = true;
            this.listByType.dataProvider = new scaleform.clik.data.DataProvider(loc1);
            return;
        }

        public function as_showStart(arg1:Boolean):void
        {
            this.startButton.visible = arg1;
            return;
        }

        public function as_showExit(arg1:Boolean):void
        {
            this.exitButton.visible = arg1;
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            this.x = arg1 - this.actualWidth >> 1;
            this.y = Math.min(-parent.y + (arg2 - this.actualHeight >> 1), 80);
            return;
        }

        protected override function onDispose():void
        {
            App.gameInputMgr.clearKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN);
            this.listByLevel.disposeRenderers();
            this.listByType.disposeRenderers();
            if (this.startButton.hasEventListener(scaleform.clik.events.ButtonEvent.CLICK)) 
            {
                this.startButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onStartClick);
            }
            if (this.exitButton.hasEventListener(scaleform.clik.events.ButtonEvent.CLICK)) 
            {
                this.exitButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onExitButton);
            }
            super.onDispose();
            return;
        }

        public override function toString():String
        {
            return "[WG BattleQueue " + name + "]";
        }

        internal function handleEscape(arg1:scaleform.clik.events.InputEvent):void
        {
            onEscapeS();
            return;
        }

        public var battleIconBig:net.wg.gui.components.icons.BattleTypeIcon;

        public var battleIcon:net.wg.gui.components.icons.BattleTypeIcon;

        public var titleField:flash.text.TextField;

        public var descriptionLabel:flash.text.TextField;

        public var timerLabel:flash.text.TextField;

        public var playersLabel:flash.text.TextField;

        public var titleFieldLevel:flash.text.TextField;

        public var titleFieldType:flash.text.TextField;

        public var exitButton:net.wg.gui.components.controls.SoundButtonEx;

        public var startButton:net.wg.gui.components.controls.SoundButtonEx;

        public var listByLevel:net.wg.gui.components.controls.ScrollingListEx;

        public var listByType:net.wg.gui.components.controls.ScrollingListEx;
    }
}
