package net.wg.gui.lobby.training
{
    import net.wg.infrastructure.base.meta.impl.TrainingFormMeta;
    import net.wg.infrastructure.base.meta.ITrainingFormMeta;
    import net.wg.gui.components.controls.WgScrollingList;
    import scaleform.clik.interfaces.IScrollBar;
    import net.wg.gui.components.icons.BattleTypeIcon;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.events.TrainingEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.InteractiveObject;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.InputEvent;
    
    public class TrainingForm extends TrainingFormMeta implements ITrainingFormMeta
    {
        
        public function TrainingForm()
        {
            this.provider = [];
            super();
        }
        
        private static var SUB_VIEW_MARGIN:Number = 120;
        
        public var list:WgScrollingList;
        
        public var sb:IScrollBar;
        
        public var battleIcon:BattleTypeIcon;
        
        public var battleIconBig:BattleTypeIcon;
        
        public var createButon:SoundButtonEx;
        
        public var titleField:TextField;
        
        public var descriptionLabel:TextField;
        
        public var listTitle:TextField;
        
        public var ownerTitle:TextField;
        
        public var playersTitle:TextField;
        
        public var roomsLabel:TextField;
        
        public var playersLabel:TextField;
        
        private var provider:Array;
        
        private var totalPlayers:Number = 0;
        
        private var _myWidth:Number = 0;
        
        override public function updateStage(param1:Number, param2:Number) : void
        {
            this.setViewSize(param1,param2);
        }
        
        override public final function setViewSize(param1:Number, param2:Number) : void
        {
            this._myWidth = param1;
            invalidateSize();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.updateStage(App.appWidth,App.appHeight);
            this.ownerTitle.text = MENU.TRAINING_OWNERTITLE;
            this.playersTitle.text = MENU.TRAINING_PLAYERSTITLE;
            this.titleField.text = MENU.TRAINING_TITLE;
            this.descriptionLabel.text = MENU.TRAINING_DESCRIPTION;
            constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
            this.createButon.addEventListener(ButtonEvent.CLICK,this.showCreateTraining);
            addEventListener(TrainingEvent.OPEN_TRAINING_ROOM,this.onOpenRoom);
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                x = this._myWidth - _originalWidth >> 1;
                y = -SUB_VIEW_MARGIN;
            }
            if((isInvalid(InvalidationType.DATA)) && (this.provider))
            {
                this.listTitle.htmlText = MENU.TRAINING_LISTTITLE;
                this.listTitle.htmlText = this.listTitle.htmlText + (" [<font color=\"#FFFFFF\">" + this.provider.length + "</font>]");
                this.roomsLabel.htmlText = MENU.TRAINING_ROOMSLABEL;
                this.roomsLabel.htmlText = this.roomsLabel.htmlText + (" <font color=\"#FFFFFF\">" + this.provider.length + "</font>");
                this.playersLabel.htmlText = MENU.TRAINING_PLAYERSLABEL;
                this.playersLabel.htmlText = this.playersLabel.htmlText + (" <font color=\"#FFFFFF\">" + this.totalPlayers + "</font>");
            }
        }
        
        override protected function onDispose() : void
        {
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
            this.createButon.removeEventListener(ButtonEvent.CLICK,this.showCreateTraining);
            removeEventListener(TrainingEvent.OPEN_TRAINING_ROOM,this.onOpenRoom);
            this.sb.dispose();
            this.sb = null;
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
            if(this.provider)
            {
                this.provider.splice(0,this.provider.length);
                this.provider = null;
            }
            super.onDispose();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.createButon);
        }
        
        public function as_setList(param1:Array, param2:Number) : void
        {
            this.provider = param1;
            this.totalPlayers = param2;
            this.list.dataProvider = new DataProvider(param1);
            invalidate(InvalidationType.DATA);
        }
        
        private function onOpenRoom(param1:TrainingEvent) : void
        {
            joinTrainingRequestS(param1.initObj.id);
        }
        
        private function showCreateTraining(param1:ButtonEvent) : void
        {
            createTrainingRequestS();
        }
        
        private function handleEscape(param1:InputEvent) : void
        {
            onEscapeS();
        }
    }
}
