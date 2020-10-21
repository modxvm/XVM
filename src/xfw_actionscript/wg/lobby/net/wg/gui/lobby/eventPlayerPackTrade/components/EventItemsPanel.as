package net.wg.gui.lobby.eventPlayerPackTrade.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.events.UILoaderEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.eventItemPackTrade.data.ItemVO;
    import net.wg.data.constants.Values;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventItemsPanel extends Sprite implements IDisposable
    {

        private static const ITEM1_OFFSET:int = 125;

        private static const ITEM2_OFFSET:int = 375;

        private static const ITEM3_OFFSET:int = 625;

        public var item1:UILoaderAlt = null;

        public var description1TF:TextField = null;

        public var value1TF:TextField = null;

        public var item2:UILoaderAlt = null;

        public var description2TF:TextField = null;

        public var value2TF:TextField = null;

        public var item3:UILoaderAlt = null;

        public var description3TF:TextField = null;

        public var value3TF:TextField = null;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _tooltip1:String = "";

        private var _specialAlias1:String = "";

        private var _specialArgs1:Array = null;

        private var _tooltip2:String = "";

        private var _specialAlias2:String = "";

        private var _specialArgs2:Array = null;

        private var _tooltip3:String = "";

        private var _specialAlias3:String = "";

        private var _specialArgs3:Array = null;

        public function EventItemsPanel()
        {
            super();
        }

        public function configUI() : void
        {
            this._toolTipMgr = App.toolTipMgr;
            if(this.item1 != null)
            {
                this.item1.addEventListener(UILoaderEvent.COMPLETE,this.onItem1CompleteHandler);
                this.item1.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
                this.item1.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            }
            if(this.item2 != null)
            {
                this.item2.addEventListener(UILoaderEvent.COMPLETE,this.onItem2CompleteHandler);
                this.item2.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
                this.item2.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            }
            if(this.item3 != null)
            {
                this.item3.addEventListener(UILoaderEvent.COMPLETE,this.onItem3CompleteHandler);
                this.item3.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
                this.item3.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            }
        }

        public function dispose() : void
        {
            if(this.item1 != null)
            {
                this.item1.removeEventListener(UILoaderEvent.COMPLETE,this.onItem1CompleteHandler);
                this.item1.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
                this.item1.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
                this.item1.dispose();
                this.item1 = null;
            }
            this.description1TF = null;
            this.value1TF = null;
            if(this.item2 != null)
            {
                this.item2.removeEventListener(UILoaderEvent.COMPLETE,this.onItem2CompleteHandler);
                this.item2.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
                this.item2.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
                this.item2.dispose();
                this.item2 = null;
            }
            this.description2TF = null;
            this.value2TF = null;
            if(this.item3 != null)
            {
                this.item3.removeEventListener(UILoaderEvent.COMPLETE,this.onItem3CompleteHandler);
                this.item3.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
                this.item3.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
                this.item3.dispose();
                this.item3 = null;
            }
            this.description3TF = null;
            this.value3TF = null;
            this._toolTipMgr = null;
            this._specialArgs1 = null;
            this._specialArgs2 = null;
            this._specialArgs3 = null;
        }

        protected function getItem1Offset() : int
        {
            return ITEM1_OFFSET;
        }

        private function onItem1CompleteHandler(param1:UILoaderEvent) : void
        {
            this.item1.x = this.getItem1Offset() - (this.item1.width >> 1);
        }

        public function setItem1(param1:ItemVO) : void
        {
            this.item1.source = param1.name;
            this.item1.autoSize = false;
            this.description1TF.text = param1.description;
            if(this.value1TF != null)
            {
                this.value1TF.text = param1.value;
            }
            this._tooltip1 = param1.tooltip;
            this._specialAlias1 = param1.specialAlias;
            this._specialArgs1 = param1.specialArgs;
        }

        protected function getItem2Offset() : int
        {
            return ITEM2_OFFSET;
        }

        private function onItem2CompleteHandler(param1:UILoaderEvent) : void
        {
            this.item2.x = this.getItem2Offset() - (this.item2.width >> 1);
        }

        public function setItem2(param1:ItemVO) : void
        {
            this.item2.source = param1.name;
            this.item2.autoSize = false;
            this.description2TF.text = param1.description;
            if(this.value2TF != null)
            {
                this.value2TF.text = param1.value;
            }
            this._tooltip2 = param1.tooltip;
            this._specialAlias2 = param1.specialAlias;
            this._specialArgs2 = param1.specialArgs;
        }

        protected function getItem3Offset() : int
        {
            return ITEM3_OFFSET;
        }

        private function onItem3CompleteHandler(param1:UILoaderEvent) : void
        {
            this.item3.x = this.getItem3Offset() - (this.item3.width >> 1);
        }

        public function setItem3(param1:ItemVO) : void
        {
            this.item3.source = param1.name;
            this.item3.autoSize = false;
            this.description3TF.text = param1.description;
            if(this.value3TF != null)
            {
                this.value3TF.text = param1.value;
            }
            this._tooltip3 = param1.tooltip;
            this._specialAlias3 = param1.specialAlias;
            this._specialArgs3 = param1.specialArgs;
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:String = Values.EMPTY_STR;
            var _loc3_:String = Values.EMPTY_STR;
            var _loc4_:Array = null;
            if(param1.currentTarget == this.item1)
            {
                _loc2_ = this._tooltip1;
                _loc3_ = this._specialAlias1;
                _loc4_ = this._specialArgs1;
            }
            else if(param1.currentTarget == this.item2)
            {
                _loc2_ = this._tooltip2;
                _loc3_ = this._specialAlias2;
                _loc4_ = this._specialArgs2;
            }
            else if(param1.currentTarget == this.item3)
            {
                _loc2_ = this._tooltip3;
                _loc3_ = this._specialAlias3;
                _loc4_ = this._specialArgs3;
            }
            if(StringUtils.isNotEmpty(_loc2_))
            {
                this._toolTipMgr.showComplex(_loc2_);
            }
            else
            {
                this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[_loc3_,null].concat(_loc4_));
            }
        }

        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
