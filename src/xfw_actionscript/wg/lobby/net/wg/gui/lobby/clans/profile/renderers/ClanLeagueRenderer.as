package net.wg.gui.lobby.clans.profile.renderers
{
    import net.wg.infrastructure.base.UIComponentEx;
    import scaleform.clik.interfaces.IListItemRenderer;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
    import net.wg.infrastructure.interfaces.IImage;
    import flash.text.TextField;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.clans.profile.VOs.LeagueItemRendererVO;
    import scaleform.clik.core.UIComponent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.geom.Point;
    import scaleform.clik.data.ListData;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.generated.TEXT_ALIGN;
    import flash.text.TextFieldAutoSize;

    public class ClanLeagueRenderer extends UIComponentEx implements IListItemRenderer, IUpdatable, IScrollerItemRenderer
    {

        private static const LABEL_PADDING:int = 2;

        public var img:IImage;

        public var txtLabel:TextField;

        private var _toolTipMgr:ITooltipMgr;

        private var _rendererWidth:Number = 0;

        private var _rendererHeight:Number = 0;

        private var _hasSize:Boolean = false;

        private var _data:LeagueItemRendererVO;

        private var _index:uint = 0;

        private var _owner:UIComponent;

        public function ClanLeagueRenderer()
        {
            super();
            this._toolTipMgr = App.toolTipMgr;
            this.txtLabel.autoSize = TextFieldAutoSize.CENTER;
        }

        override public function setSize(param1:Number, param2:Number) : void
        {
            this._rendererWidth = param1;
            this._rendererHeight = param2;
            this._hasSize = true;
            invalidateSize();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.txtLabel.mouseEnabled = false;
            this.img.addEventListener(Event.CHANGE,this.onImgChangeHandler);
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this._data)
                {
                    this.txtLabel.htmlText = this._data.label;
                    this.img.scaleX = this.img.scaleY = 1;
                    this.img.source = this._data.imgSource;
                    this.updateTextFieldLayout();
                    invalidateSize();
                    this.txtLabel.visible = this.img.visible = true;
                }
                else
                {
                    this.txtLabel.visible = this.img.visible = false;
                }
            }
            if(this._data && isInvalid(InvalidationType.SIZE))
            {
                if(this._hasSize)
                {
                    if(this.img.width > this._rendererWidth || this.img.height > this._rendererHeight)
                    {
                        _loc1_ = this._rendererWidth / this.img.width;
                        _loc2_ = this._rendererHeight / this.img.height;
                        this.img.scaleX = this.img.scaleY = _loc1_ > _loc2_?_loc2_:_loc1_;
                    }
                    this.img.x = this._rendererWidth - this.img.width >> 1;
                    this.img.y = this._rendererHeight - this.img.height >> 1;
                }
                this.updateTextFieldLayout();
            }
        }

        public function getData() : Object
        {
            return this._data;
        }

        public function setData(param1:Object) : void
        {
            this._data = LeagueItemRendererVO(param1);
            invalidateData();
        }

        public function measureSize(param1:Point = null) : Point
        {
            return null;
        }

        public function setListData(param1:ListData) : void
        {
        }

        public function update(param1:Object) : void
        {
            this.setData(param1);
        }

        override protected function onDispose() : void
        {
            this.img.removeEventListener(Event.CHANGE,this.onImgChangeHandler);
            this.img.dispose();
            this.img = null;
            this.txtLabel = null;
            this._owner = null;
            this._data = null;
            this._toolTipMgr = null;
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            super.onDispose();
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            if(StringUtils.isNotEmpty(this._data.tooltip))
            {
                this._toolTipMgr.showComplex(this._data.tooltip);
            }
        }

        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onImgChangeHandler(param1:Event) : void
        {
            invalidateSize();
        }

        private function updateTextFieldLayout() : void
        {
            if(this._data.align == TEXT_ALIGN.RIGHT)
            {
                this.txtLabel.x = this.img.x + this.img.width - this.txtLabel.width ^ 0;
            }
            else if(this._data.align == TEXT_ALIGN.LEFT)
            {
                this.txtLabel.x = this.img.x - this.txtLabel.width;
            }
            else
            {
                this.txtLabel.x = this.img.x + (this.img.width - this.txtLabel.width >> 1) ^ 0;
            }
            this.txtLabel.y = this.img.y + this.img.height - this.txtLabel.textHeight + LABEL_PADDING;
        }

        override public function get width() : Number
        {
            return this._rendererWidth;
        }

        override public function set width(param1:Number) : void
        {
            this.setSize(param1,this._rendererHeight);
        }

        override public function get height() : Number
        {
            return this._rendererHeight;
        }

        override public function set height(param1:Number) : void
        {
            this.setSize(this._rendererWidth,param1);
        }

        public function get index() : uint
        {
            return this._index;
        }

        public function set index(param1:uint) : void
        {
            this._index = param1;
        }

        public function get owner() : UIComponent
        {
            return this._owner;
        }

        public function set owner(param1:UIComponent) : void
        {
            this._owner = param1;
        }

        public function get selected() : Boolean
        {
            return false;
        }

        public function set selected(param1:Boolean) : void
        {
        }

        public function get selectable() : Boolean
        {
            return false;
        }

        public function set selectable(param1:Boolean) : void
        {
        }

        public function get data() : Object
        {
            return this._data;
        }

        public function set data(param1:Object) : void
        {
            this.setData(param1);
        }

        public function set tooltipDecorator(param1:ITooltipMgr) : void
        {
            this._toolTipMgr = param1;
        }

        public function set isViewPortEnabled(param1:Boolean) : void
        {
        }
    }
}
