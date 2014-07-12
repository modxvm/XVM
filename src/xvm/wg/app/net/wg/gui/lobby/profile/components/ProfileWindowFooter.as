package net.wg.gui.lobby.profile.components
{
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextFieldAutoSize;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;
    
    public class ProfileWindowFooter extends UserDateFooter
    {
        
        public function ProfileWindowFooter() {
            super();
        }
        
        private static var LAYOUT_INVALID:String = "layInv";
        
        private static function cutText(param1:TextField, param2:String) : String {
            var _loc4_:* = 0;
            param1.htmlText = param2;
            var _loc3_:* = -1;
            try
            {
                _loc3_ = param1.getLineLength(1);
            }
            catch(e:Error)
            {
            }
            if(_loc3_ != -1)
            {
                _loc4_ = param1.getLineLength(0) + param1.getLineLength(1) / 2;
                param2 = param2.substr(0,_loc4_);
                processCutText(param1,param2);
            }
            return param1.htmlText;
        }
        
        private static function processCutText(param1:TextField, param2:String) : void {
            var _loc3_:String = null;
            if(param1.getLineLength(1) != -1)
            {
                _loc3_ = param2.substr(0,param2.length - 1);
                _loc3_ = _loc3_ + "...";
                param1.htmlText = _loc3_;
                if(param1.getLineLength(1) != -1)
                {
                    processCutText(param1,_loc3_.substr(0,_loc3_.length - 3));
                }
            }
        }
        
        private var _sidesGap:uint = 10;
        
        public var txtClanInfo:TextField;
        
        public var txtClanJoin:TextField;
        
        public var background:MovieClip;
        
        public var loader:UILoaderAlt;
        
        private var clanText:String = "";
        
        override protected function configUI() : void {
            super.configUI();
            textDates.autoSize = TextFieldAutoSize.LEFT;
            this.txtClanJoin.selectable = this.txtClanInfo.selectable = textDates.selectable = false;
            this.txtClanInfo.addEventListener(MouseEvent.MOUSE_OVER,this.leftTextMouseOverHandler,false,0,true);
            this.txtClanInfo.addEventListener(MouseEvent.MOUSE_OUT,this.leftTextMouseOutHandler,false,0,true);
        }
        
        override protected function draw() : void {
            var _loc1_:uint = 0;
            var _loc2_:* = false;
            super.draw();
            if(isInvalid(LAYOUT_INVALID))
            {
                textDates.x = this.width - this._sidesGap - textDates.width;
                _loc1_ = 200;
                this.background.x = -_loc1_;
                this.background.width = this.width + 2 * _loc1_;
                _loc2_ = (initData) && !(initData.clanName == Values.EMPTY_STR);
                if(_loc2_)
                {
                    this.loader.x = this._sidesGap;
                    this.txtClanInfo.x = this.txtClanJoin.x = this.loader.x + this.loader.width + this._sidesGap;
                }
                else
                {
                    this.txtClanInfo.x = this.txtClanJoin.x = this._sidesGap;
                }
            }
        }
        
        override protected function applyDataChanges() : void {
            var _loc2_:String = null;
            super.applyDataChanges();
            var _loc1_:* = !(initData.clanName == Values.EMPTY_STR);
            if(_loc1_)
            {
                this.loader.visible = true;
                this.loader.source = initData.clanEmblem;
                _loc2_ = "[" + initData.clanName + "] ";
                this.clanText = "<b>" + _loc2_ + "</b>" + initData.clanNameDescr + ". " + initData.clanPosition + ".";
                this.txtClanInfo.htmlText = cutText(this.txtClanInfo,this.clanText);
                this.txtClanJoin.htmlText = getDateWithDot(initData.clanJoinTime);
            }
            else
            {
                this.loader.visible = false;
                this.clanText = Values.EMPTY_STR;
                this.txtClanInfo.htmlText = this.clanText;
                this.txtClanJoin.htmlText = Values.EMPTY_STR;
            }
            invalidate(LAYOUT_INVALID);
        }
        
        override protected function getSeparator() : String {
            return "\n";
        }
        
        public function get sidesGap() : uint {
            return this._sidesGap;
        }
        
        public function set sidesGap(param1:uint) : void {
            this._sidesGap = param1;
            invalidate(LAYOUT_INVALID);
        }
        
        private function leftTextMouseOverHandler(param1:MouseEvent) : void {
            App.toolTipMgr.show(this.clanText);
        }
        
        private function leftTextMouseOutHandler(param1:MouseEvent) : void {
            App.toolTipMgr.hide();
        }
        
        override public function get height() : Number {
            return 48;
        }
        
        override protected function onDispose() : void {
            this.txtClanInfo.removeEventListener(MouseEvent.MOUSE_OVER,this.leftTextMouseOverHandler);
            this.txtClanInfo.removeEventListener(MouseEvent.MOUSE_OUT,this.leftTextMouseOutHandler);
            this.txtClanInfo = null;
            this.txtClanJoin = null;
            this.background = null;
            this.loader = null;
            super.onDispose();
        }
    }
}
