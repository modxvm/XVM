package net.wg.gui.lobby.training 
{
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.icons.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class TrainingForm extends net.wg.infrastructure.base.meta.impl.TrainingFormMeta implements net.wg.infrastructure.base.meta.ITrainingFormMeta
    {
        public function TrainingForm()
        {
            this.provider = [];
            super();
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            this.setViewSize(arg1, arg2);
            return;
        }

        public final override function setViewSize(arg1:Number, arg2:Number):void
        {
            this._myWidth = arg1;
            invalidateSize();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.updateStage(App.appWidth, App.appHeight);
            this.ownerTitle.text = MENU.TRAINING_OWNERTITLE;
            this.playersTitle.text = MENU.TRAINING_PLAYERSTITLE;
            this.titleField.text = MENU.TRAINING_TITLE;
            this.descriptionLabel.text = MENU.TRAINING_DESCRIPTION;
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.COUNTER_SCALE);
            this.createButon.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.showCreateTraining);
            App.utils.focusHandler.setFocus(this.createButon);
            addEventListener(net.wg.gui.events.TrainingEvent.OPEN_TRAINING_ROOM, this.onOpenRoom);
            App.gameInputMgr.setKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN, this.handleEscape, true);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                x = this._myWidth - _originalWidth >> 1;
                y = -SUB_VIEW_MARGIN;
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this.provider) 
            {
                this.listTitle.htmlText = MENU.TRAINING_LISTTITLE;
                this.listTitle.htmlText = this.listTitle.htmlText + (" [<font color=\"#FFFFFF\">" + this.provider.length + "</font>]");
                this.roomsLabel.htmlText = MENU.TRAINING_ROOMSLABEL;
                this.roomsLabel.htmlText = this.roomsLabel.htmlText + (" <font color=\"#FFFFFF\">" + this.provider.length + "</font>");
                this.playersLabel.htmlText = MENU.TRAINING_PLAYERSLABEL;
                this.playersLabel.htmlText = this.playersLabel.htmlText + (" <font color=\"#FFFFFF\">" + this.totalPlayers + "</font>");
            }
            return;
        }

        protected override function onDispose():void
        {
            App.gameInputMgr.clearKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN);
            this.createButon.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.showCreateTraining);
            removeEventListener(net.wg.gui.events.TrainingEvent.OPEN_TRAINING_ROOM, this.onOpenRoom);
            this.list.dispose();
            this.list = null;
            this.battleIcon.dispose();
            this.battleIcon = null;
            this.battleIconBig.dispose();
            this.battleIconBig = null;
            this.createButon.dispose();
            this.createButon = null;
            this.titleField = null;
            this.descriptionLabel = null;
            this.listTitle = null;
            this.ownerTitle = null;
            this.playersTitle = null;
            this.roomsLabel = null;
            this.playersLabel = null;
            if (this.provider) 
            {
                this.provider.splice(0, this.provider.length);
                this.provider = null;
            }
            super.onDispose();
            return;
        }

        public function as_setList(arg1:Array, arg2:Number):void
        {
            this.provider = arg1;
            this.totalPlayers = arg2;
            this.list.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        internal function onOpenRoom(arg1:net.wg.gui.events.TrainingEvent):void
        {
            joinTrainingRequestS(arg1.initObj.id);
            return;
        }

        internal function showCreateTraining(arg1:scaleform.clik.events.ButtonEvent):void
        {
            createTrainingRequestS();
            return;
        }

        internal function handleEscape(arg1:scaleform.clik.events.InputEvent):void
        {
            onEscapeS();
            return;
        }

        internal static const SUB_VIEW_MARGIN:Number=120;

        public var list:net.wg.gui.components.controls.WgScrollingList;

        public var battleIcon:net.wg.gui.components.icons.BattleTypeIcon;

        public var battleIconBig:net.wg.gui.components.icons.BattleTypeIcon;

        public var createButon:net.wg.gui.components.controls.SoundButtonEx;

        public var titleField:flash.text.TextField;

        public var descriptionLabel:flash.text.TextField;

        public var listTitle:flash.text.TextField;

        public var ownerTitle:flash.text.TextField;

        public var playersTitle:flash.text.TextField;

        public var roomsLabel:flash.text.TextField;

        public var playersLabel:flash.text.TextField;

        internal var provider:Array;

        internal var totalPlayers:Number=0;

        internal var _myWidth:Number=0;
    }
}
