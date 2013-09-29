package net.wg.gui.lobby.messengerBar.carousel 
{
    import net.wg.gui.lobby.messengerBar.carousel.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.interfaces.*;
    
    public class ChannelRenderer extends scaleform.clik.core.UIComponent implements scaleform.clik.interfaces.IListItemRenderer
    {
        public function ChannelRenderer()
        {
            super();
            visible = false;
            return;
        }

        public function get index():uint
        {
            return this._index;
        }

        public function set index(arg1:uint):void
        {
            this._index = arg1;
            return;
        }

        public function get owner():scaleform.clik.core.UIComponent
        {
            return this._owner;
        }

        public function set owner(arg1:scaleform.clik.core.UIComponent):void
        {
            this._owner = arg1;
            return;
        }

        public function get selectable():Boolean
        {
            return this._selectable;
        }

        public function set selectable(arg1:Boolean):void
        {
            this._selectable = arg1;
            return;
        }

        public function get selected():Boolean
        {
            return this.openButton.selected;
        }

        public function set selected(arg1:Boolean):void
        {
            this.openButton.selected = arg1;
            return;
        }

        public function setListData(arg1:scaleform.clik.data.ListData):void
        {
            this.index = arg1.index;
            this.selected = arg1.selected;
            this.openButton.label = arg1.label || "";
            return;
        }

        public function setData(arg1:Object):void
        {
            if (arg1) 
            {
                this.model = new net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO(arg1);
                invalidateData();
            }
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.model) 
            {
                this.model.dispose();
                this.model = null;
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this.model) 
            {
                this.openButton.label = this.model.label;
                this.openButton.blinking = this.model.isNotified;
                this.openButton.iconSource = this.model.icon;
                this.closeButton.visible = this.model.canClose;
            }
            visible = Boolean(this.model);
            return;
        }

        public var openButton:net.wg.gui.lobby.messengerBar.carousel.ChannelButton;

        public var closeButton:scaleform.clik.controls.Button;

        protected var _index:uint=0;

        protected var _selectable:Boolean=true;

        protected var _owner:scaleform.clik.core.UIComponent=null;

        protected var model:net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO;
    }
}
