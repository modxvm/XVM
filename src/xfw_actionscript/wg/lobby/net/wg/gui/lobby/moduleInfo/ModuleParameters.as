package net.wg.gui.lobby.moduleInfo
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import net.wg.utils.ICounterManager;
    import flash.text.TextFieldAutoSize;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.utils.ICounterProps;
    import net.wg.data.constants.Values;
    import scaleform.gfx.TextFieldEx;
    import net.wg.infrastructure.managers.counter.CounterProps;
    import flash.text.TextFormatAlign;
    import net.wg.data.constants.Linkages;
    import net.wg.infrastructure.managers.counter.CounterManager;

    public class ModuleParameters extends UIComponentEx
    {

        private static const HEADER_TEXT_INV:String = "headerTextInv";

        private static const COUNTER_OFFSET_X:int = -9;

        private static const COUNTER_OFFSET_Y:int = -7;

        private static const COUNTER_STEP:int = 21;

        public var header:TextField;

        public var paramValue:TextField;

        public var paramType:TextField;

        private var _bottomMargin:Number;

        private var _headerText:String = "";

        private var _counterManager:ICounterManager;

        public function ModuleParameters()
        {
            this._counterManager = App.utils.counterManager;
            super();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.paramType.multiline = true;
            this.paramType.wordWrap = true;
            this.paramType.autoSize = TextFieldAutoSize.LEFT;
            this.paramValue.multiline = true;
            this.paramValue.wordWrap = true;
            this.paramValue.autoSize = TextFieldAutoSize.RIGHT;
        }

        override protected function onBeforeDispose() : void
        {
            this._counterManager.removeCounter(this);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.header = null;
            this.paramValue = null;
            this.paramType = null;
            this._counterManager = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(!StringUtils.isEmpty(this._headerText) && isInvalid(HEADER_TEXT_INV))
            {
                this.header.htmlText = this._headerText;
            }
        }

        public function setParameters(param1:Array = null) : void
        {
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:Object = null;
            var _loc6_:ICounterProps = null;
            this.paramValue.htmlText = Values.EMPTY_STR;
            this.paramType.htmlText = Values.EMPTY_STR;
            var _loc2_:int = param1.length;
            if(_loc2_ > 0)
            {
                _loc3_ = 0;
                for each(_loc5_ in param1)
                {
                    _loc4_ = this.paramType.numLines;
                    TextFieldEx.appendHtml(this.paramType,_loc5_.type);
                    TextFieldEx.appendHtml(this.paramValue,_loc5_.value);
                    if(this.paramType.numLines - _loc4_ > 1)
                    {
                        TextFieldEx.appendHtml(this.paramValue,"\n");
                    }
                    if(_loc5_.highlight)
                    {
                        _loc6_ = new CounterProps(COUNTER_OFFSET_X,this.paramValue.y + COUNTER_OFFSET_Y + COUNTER_STEP * _loc3_,TextFormatAlign.LEFT,true,Linkages.COUNTER_LINE_BIG_UI);
                        this._counterManager.setCounter(this,CounterManager.COUNTER_EMPTY,null,_loc6_);
                    }
                    _loc3_++;
                }
            }
            height = this.paramValue.y + this.paramValue.height + this._bottomMargin;
        }

        public function get bottomMargin() : Number
        {
            return this._bottomMargin;
        }

        public function set bottomMargin(param1:Number) : void
        {
            this._bottomMargin = param1;
        }

        public function get headerText() : String
        {
            return this._headerText;
        }

        public function set headerText(param1:String) : void
        {
            this._headerText = param1;
            invalidate(HEADER_TEXT_INV);
        }
    }
}
