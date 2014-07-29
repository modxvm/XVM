package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.utils.ICommons;
    import org.idmedia.as3commons.util.Map;
    import org.idmedia.as3commons.util.HashMap;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObjectContainer;
    import flash.utils.getQualifiedClassName;
    import net.wg.data.constants.KeyProps;
    import net.wg.data.constants.KeysMap;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.text.TextField;
    import flash.display.Sprite;
    import flash.filters.ColorMatrixFilter;
    import net.wg.infrastructure.interfaces.IUserProps;
    import flash.text.TextFormat;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.utils.IAssertable;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.NullPointerException;
    import net.wg.infrastructure.exceptions.ArgumentException;
    import flash.events.MouseEvent;
    import scaleform.gfx.MouseEventEx;
    import flash.events.IEventDispatcher;
    import flash.display.InteractiveObject;
    import flash.text.TextLineMetrics;
    
    public class Commons extends Object implements ICommons
    {
        
        public function Commons()
        {
            super();
        }
        
        private static var IMG_TAG_OPEN:String = "<IMG SRC=\"img://gui/maps/icons/library/igr_32x13.png\" width=\"32\" height=\"13\" vspace=\"";
        
        private static var IMG_TAG_CLOSE:String = "\"/>";
        
        private static var IMG_TAG_OPEN_BASIC:String = "<IMG SRC=\"img://gui/maps/icons/library/basic_small.png\" width=\"26\" height=\"16\" vspace=\"";
        
        private static var IMG_TAG_OPEN_PREMIUM:String = "<IMG SRC=\"img://gui/maps/icons/library/premium_small.png\" width=\"34\" height=\"16\" vspace=\"";
        
        private static var CLAN_TAG_OPEN:String = "[";
        
        private static var CLAN_TAG_CLOSE:String = "]";
        
        private static var CUT_SYMBOLS_STR:String = "..";
        
        private static var s_found:Array = [];
        
        public function createMap(param1:Array) : Map
        {
            this.assertEvenArray(param1);
            var _loc2_:Map = new HashMap();
            var _loc3_:Number = 0;
            while(_loc3_ < param1.length)
            {
                if(_loc3_ % 2 == 1 && _loc3_ > 0)
                {
                    _loc2_.put(param1[_loc3_ - 1],param1[_loc3_]);
                }
                _loc3_++;
            }
            return _loc2_;
        }
        
        public function createMappedArray(param1:Array) : Array
        {
            var _loc4_:Object = null;
            this.assertEvenArray(param1);
            var _loc2_:Array = [];
            var _loc3_:Number = 0;
            while(_loc3_ < param1.length)
            {
                if(_loc3_ % 2 == 1 && _loc3_ > 0)
                {
                    _loc4_ = {};
                    _loc4_[param1[_loc3_ - 1]] = param1[_loc3_];
                    _loc2_.push(_loc4_);
                }
                _loc3_++;
            }
            return _loc2_;
        }
        
        public function cleanupDynamicObject(param1:Object) : Object
        {
            var _loc3_:* = undefined;
            var _loc2_:Array = [];
            for(_loc3_ in param1)
            {
                _loc2_.push(_loc3_);
            }
            for each(_loc3_ in _loc2_)
            {
                delete param1[_loc3_];
                true;
            }
            _loc2_.splice(0,_loc2_.length);
            return null;
        }
        
        public function releaseReferences(param1:Object, param2:Boolean = true) : void
        {
            var _loc3_:String = null;
            var _loc4_:Object = null;
            var _loc5_:DisplayObject = null;
            if(param1 == null)
            {
                param1 = App.stage;
            }
            if(s_found.indexOf(param1) == -1)
            {
                s_found.push(param1);
                for(_loc3_ in param1)
                {
                    _loc4_ = param1[_loc3_];
                    if(this.canToDestroying(_loc4_))
                    {
                        this.releaseReferences(_loc4_,false);
                        if(_loc4_ is IDisposable)
                        {
                            IDisposable(_loc4_).dispose();
                        }
                        delete param1[_loc3_];
                        true;
                    }
                }
                if(param1 is DisplayObjectContainer)
                {
                    while(DisplayObjectContainer(param1).numChildren > 0)
                    {
                        _loc5_ = DisplayObjectContainer(param1).getChildAt(0);
                        if(this.canToDestroying(_loc5_))
                        {
                            this.releaseReferences(_loc5_,false);
                            if(_loc4_ is IDisposable)
                            {
                                IDisposable(_loc4_).dispose();
                            }
                        }
                        DisplayObjectContainer(param1).removeChild(_loc5_);
                    }
                }
            }
            if(param2)
            {
                if(s_found.length > 1)
                {
                    DebugUtils.LOG_DEBUG("try to release: " + param1 + " " + getQualifiedClassName(param1) + " has been released. Collected: " + s_found.length + " objects.");
                }
                s_found.splice(0);
            }
        }
        
        public function keyToString(param1:Number) : KeyProps
        {
            var _loc2_:KeyProps = new KeyProps();
            var _loc3_:String = String.fromCharCode(param1);
            if(KeysMap.mapping.hasOwnProperty(param1.toString()))
            {
                if(KeysMap.mapping[param1].hasOwnProperty("to_show"))
                {
                    _loc2_.keyName = KeysMap.mapping[param1].to_show;
                }
                else
                {
                    _loc2_.keyName = App.utils.toUpperOrLowerCase(_loc3_,true);
                }
                if(KeysMap.mapping[param1].hasOwnProperty("command"))
                {
                    _loc2_.keyCommand = KeysMap.mapping[param1].command;
                }
                else
                {
                    _loc2_.keyCommand = App.utils.toUpperOrLowerCase(_loc3_,true);
                }
            }
            else
            {
                _loc2_.keyName = App.utils.toUpperOrLowerCase(_loc3_,true);
                _loc2_.keyCommand = App.utils.toUpperOrLowerCase(_loc3_,true);
            }
            return _loc2_;
        }
        
        public function cutBitmapFromBitmapData(param1:BitmapData, param2:Rectangle) : Bitmap
        {
            var _loc3_:BitmapData = new BitmapData(param2.width,param2.height,true,13421772);
            _loc3_.copyPixels(param1,new Rectangle(param2.x,param2.y,param2.width,param2.height),new Point(0,0));
            var _loc4_:Bitmap = new Bitmap(_loc3_,"auto",true);
            return _loc4_;
        }
        
        public function cloneObject(param1:Object) : *
        {
            var _loc2_:* = undefined;
            var _loc3_:String = null;
            if(param1 is Object)
            {
                _loc2_ = param1 is Array?[]:{};
                for(_loc3_ in param1)
                {
                    _loc2_[_loc3_] = param1[_loc3_] is Object && !(param1[_loc3_] is Number) && !(param1[_loc3_] is Boolean) && !(param1[_loc3_] is String)?this.cloneObject(param1[_loc3_]):param1[_loc3_];
                }
                return _loc2_;
            }
            return undefined;
        }
        
        public function addBlankLines(param1:String, param2:TextField, param3:Vector.<TextField>) : void
        {
            var _loc6_:TextField = null;
            var _loc7_:* = 0;
            var _loc4_:String = param2.htmlText;
            param2.htmlText = param1;
            var _loc5_:int = Math.round(param2.textHeight / param2.getLineMetrics(0).height);
            for each(_loc6_ in param3)
            {
                _loc7_ = 1;
                while(_loc7_ < _loc5_)
                {
                    _loc6_.htmlText = _loc6_.htmlText + "\n";
                    _loc7_++;
                }
            }
            param2.htmlText = _loc4_;
        }
        
        public function setSaturation(param1:Sprite, param2:Number) : void
        {
            var object:Sprite = param1;
            var amount:Number = param2;
            var interpolateArrays:Function = function(param1:Array, param2:Array, param3:Number):Object
            {
                var _loc4_:Array = param1.length >= param2.length?param1.slice():param2.slice();
                var _loc5_:uint = _loc4_.length;
                while(_loc5_--)
                {
                    _loc4_[_loc5_] = param1[_loc5_] + (param2[_loc5_] - param1[_loc5_]) * param3;
                }
                return _loc4_;
            };
            amount = amount / 100;
            var colorFilter:ColorMatrixFilter = new ColorMatrixFilter();
            var redIdentity:Array = [1,0,0,0,0];
            var greenIdentity:Array = [0,1,0,0,0];
            var blueIdentity:Array = [0,0,1,0,0];
            var alphaIdentity:Array = [0,0,0,1,0];
            var grayluma:Array = [0.3,0.59,0.11,0,0];
            var colmatrix:Array = new Array();
            colmatrix = colmatrix.concat(interpolateArrays(grayluma,redIdentity,amount));
            colmatrix = colmatrix.concat(interpolateArrays(grayluma,greenIdentity,amount));
            colmatrix = colmatrix.concat(interpolateArrays(grayluma,blueIdentity,amount));
            colmatrix = colmatrix.concat(alphaIdentity);
            colorFilter.matrix = colmatrix;
            object.filters = [colorFilter];
        }
        
        public function getUserProps(param1:String, param2:String = null, param3:String = null, param4:int = 0) : IUserProps
        {
            return new UserProps(param1,param2,param3,param4);
        }
        
        public function formatPlayerName(param1:TextField, param2:IUserProps) : Boolean
        {
            var _loc10_:* = 0;
            var _loc3_:TextFormat = param1.getTextFormat();
            var _loc4_:Object = _loc3_.size;
            var _loc5_:String = _loc3_.font;
            var _loc6_:String = _loc3_.align;
            var _loc7_:String = (param2.igrType == 2?IMG_TAG_OPEN_PREMIUM:IMG_TAG_OPEN_BASIC) + param2.igrVspace + IMG_TAG_CLOSE;
            var _loc8_:String = param2.prefix + param2.userName + (param2.clanAbbrev?CLAN_TAG_OPEN + param2.clanAbbrev + CLAN_TAG_CLOSE:Values.EMPTY_STR) + (param2.region?Values.SPACE_STR + param2.region:Values.EMPTY_STR) + (param2.igrType > 0?Values.SPACE_STR + _loc7_:Values.EMPTY_STR) + param2.suffix;
            var _loc9_:* = false;
            this.applyTextProps(param1,_loc8_,_loc3_,_loc4_,_loc5_,_loc6_);
            if(param1.width < param1.textWidth + 4)
            {
                _loc9_ = true;
                _loc8_ = param2.prefix + param2.userName + (param2.clanAbbrev?CUT_SYMBOLS_STR:Values.EMPTY_STR) + (param2.region?Values.SPACE_STR + param2.region:Values.EMPTY_STR) + (param2.igrType > 0?Values.SPACE_STR + _loc7_:Values.EMPTY_STR) + param2.suffix;
                this.applyTextProps(param1,_loc8_,_loc3_,_loc4_,_loc5_,_loc6_);
                _loc10_ = param2.userName.length - 1;
                while(param1.width < param1.textWidth + 4 && _loc10_ > 0)
                {
                    _loc8_ = param2.prefix + param2.userName.substr(0,_loc10_) + CUT_SYMBOLS_STR + (param2.region?Values.SPACE_STR + param2.region:Values.EMPTY_STR) + (param2.igrType > 0?Values.SPACE_STR + _loc7_:Values.EMPTY_STR) + param2.suffix;
                    this.applyTextProps(param1,_loc8_,_loc3_,_loc4_,_loc5_,_loc6_);
                    _loc10_--;
                }
            }
            if(!isNaN(param2.rgb))
            {
                param1.textColor = param2.rgb;
            }
            return _loc9_;
        }
        
        private function applyTextProps(param1:TextField, param2:String, param3:TextFormat, param4:Object, param5:String, param6:String) : void
        {
            param1.htmlText = param2;
            param3.size = param4;
            param3.font = param5;
            param3.align = param6;
            param1.setTextFormat(param3);
        }
        
        public function getFullPlayerName(param1:IUserProps) : String
        {
            var _loc2_:String = (param1.igrType == 2?IMG_TAG_OPEN_PREMIUM:IMG_TAG_OPEN_BASIC) + param1.igrVspace + IMG_TAG_CLOSE;
            return param1.prefix + param1.userName + (param1.clanAbbrev?CLAN_TAG_OPEN + param1.clanAbbrev + CLAN_TAG_CLOSE:Values.EMPTY_STR) + (param1.region?Values.SPACE_STR + param1.region:Values.EMPTY_STR) + (param1.igrType > 0?Values.SPACE_STR + _loc2_:Values.EMPTY_STR) + param1.suffix;
        }
        
        private function canToDestroying(param1:Object) : Boolean
        {
            if(param1)
            {
                return param1 is IDAAPIModule && !IDAAPIModule(param1).disposed || !(param1 is IDAAPIModule);
            }
            return false;
        }
        
        private function assertEvenArray(param1:Array) : void
        {
            var _loc2_:* = "pureHash must be have even quantity of elements";
            var _loc3_:IAssertable = App.utils.asserter;
            _loc3_.assertNotNull(param1,"pureHash" + Errors.CANT_NULL,NullPointerException);
            _loc3_.assert(param1.length % 2 == 0,_loc2_,ArgumentException);
            _loc3_.assert(param1.length > 0,"pureHash can`t be empty",ArgumentException);
        }
        
        public function isLeftButton(param1:MouseEvent) : Boolean
        {
            if(param1 is MouseEventEx)
            {
                return MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON;
            }
            return true;
        }
        
        public function isRightButton(param1:MouseEvent) : Boolean
        {
            if(param1 is MouseEventEx)
            {
                return MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON;
            }
            return false;
        }
        
        public function addMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function) : void
        {
            var _loc4_:IEventDispatcher = null;
            for each(_loc4_ in param1)
            {
                _loc4_.addEventListener(param2,param3);
            }
        }
        
        public function removeMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function) : void
        {
            var _loc4_:IEventDispatcher = null;
            for each(_loc4_ in param1)
            {
                _loc4_.removeEventListener(param2,param3);
            }
        }
        
        public function initTabIndex(param1:Array) : void
        {
            var _loc2_:Number = 0;
            while(_loc2_ < param1.length)
            {
                InteractiveObject(param1[_loc2_]).tabIndex = _loc2_ + 1;
                _loc2_++;
            }
        }
        
        public function moveIconToEndOfText(param1:DisplayObject, param2:TextField, param3:int = 0, param4:int = 0) : void
        {
            var _loc11_:TextLineMetrics = null;
            var _loc5_:* = 2;
            var _loc6_:int = param2.numLines;
            var _loc7_:* = -1;
            var _loc8_:int = _loc6_ - 1;
            while(_loc8_ >= 0)
            {
                if(param2.getLineText(_loc8_))
                {
                    _loc7_ = _loc8_;
                    break;
                }
                _loc8_--;
            }
            var _loc9_:int = Math.round(param2.x + param3);
            var _loc10_:int = Math.round(param2.y + param4);
            if(_loc7_ > -1)
            {
                _loc11_ = param2.getLineMetrics(_loc7_);
                _loc9_ = Math.round(param2.x + _loc11_.x + _loc11_.width + param3);
                _loc10_ = Math.round(param2.y + param2.textHeight + _loc5_ - (_loc11_.height - _loc11_.leading) / 2 - param1.height / 2 + param4);
            }
            param1.x = _loc9_;
            param1.y = _loc10_;
        }
    }
}
import net.wg.infrastructure.interfaces.IUserProps;

class UserProps extends Object implements IUserProps
{
    
    function UserProps(param1:String, param2:String, param3:String, param4:int)
    {
        super();
        this._userName = param1;
        this._clanAbbrev = param2;
        this._region = param3;
        this._igrType = param4;
    }
    
    private var _userName:String;
    
    private var _clanAbbrev:String;
    
    private var _region:String;
    
    private var _igrType:int = 0;
    
    private var _prefix:String = "";
    
    private var _suffix:String = "";
    
    private var _igrVspace:int = -4;
    
    private var _rgb:Number = NaN;
    
    public function get userName() : String
    {
        return this._userName;
    }
    
    public function set userName(param1:String) : void
    {
        this._userName = param1;
    }
    
    public function get clanAbbrev() : String
    {
        return this._clanAbbrev;
    }
    
    public function set clanAbbrev(param1:String) : void
    {
        this._clanAbbrev = param1;
    }
    
    public function get region() : String
    {
        return this._region;
    }
    
    public function set region(param1:String) : void
    {
        this._region = param1;
    }
    
    public function get igrType() : int
    {
        return this._igrType;
    }
    
    public function set igrType(param1:int) : void
    {
        this._igrType = param1;
    }
    
    public function get prefix() : String
    {
        return this._prefix;
    }
    
    public function set prefix(param1:String) : void
    {
        this._prefix = param1;
    }
    
    public function get suffix() : String
    {
        return this._suffix;
    }
    
    public function set suffix(param1:String) : void
    {
        this._suffix = param1;
    }
    
    public function get igrVspace() : int
    {
        return this._igrVspace;
    }
    
    public function set igrVspace(param1:int) : void
    {
        this._igrVspace = param1;
    }
    
    public function get rgb() : Number
    {
        return this._rgb;
    }
    
    public function set rgb(param1:Number) : void
    {
        this._rgb = param1;
    }
}
