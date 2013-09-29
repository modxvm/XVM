package net.wg.gui.lobby.hangar.crew 
{
    public class TextObject extends Object
    {
        public function TextObject()
        {
            super();
            return;
        }

        public function get roleHtml():String
        {
            return this._roleHtml;
        }

        public function set roleHtml(arg1:String):void
        {
            this._roleHtml = arg1;
            return;
        }

        public function get rank():String
        {
            return this._rank;
        }

        public function set rank(arg1:String):void
        {
            this._rank = arg1;
            return;
        }

        public function get nameTF():String
        {
            return this._nameTF;
        }

        public function set nameTF(arg1:String):void
        {
            this._nameTF = arg1;
            return;
        }

        public function get levelSpecializationMainHtml():String
        {
            return this._levelSpecializationMainHtml;
        }

        public function set levelSpecializationMainHtml(arg1:String):void
        {
            this._levelSpecializationMainHtml = arg1;
            return;
        }

        internal var _levelSpecializationMainHtml:String=null;

        internal var _nameTF:String=null;

        internal var _rank:String=null;

        internal var _roleHtml:String=null;
    }
}
