package net.wg.gui.lobby.messengerBar.carousel.data 
{
    import net.wg.data.daapi.base.*;
    
    public class ChannelListItemVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ChannelListItemVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get clientID():Number
        {
            return this._clientID;
        }

        public function set clientID(arg1:Number):void
        {
            this._clientID = arg1;
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            this._label = arg1;
            return;
        }

        public function get canClose():Boolean
        {
            return this._canClose;
        }

        public function set canClose(arg1:Boolean):void
        {
            this._canClose = arg1;
            return;
        }

        public function get isNotified():Boolean
        {
            return this._isNotified;
        }

        public function set isNotified(arg1:Boolean):void
        {
            this._isNotified = arg1;
            return;
        }

        public function get icon():String
        {
            return this._icon;
        }

        public function set icon(arg1:String):void
        {
            this._icon = arg1;
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            if (excluded.indexOf(arg1) > -1) 
                return false;
            return super.onDataWrite(arg1, arg2);
        }

        internal static const excluded:Array=["order"];

        internal var _clientID:Number=0;

        internal var _label:String="";

        internal var _canClose:Boolean=false;

        internal var _isNotified:Boolean=false;

        internal var _icon:String="";
    }
}
