package net.wg.gui.lobby.tankman 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class SkillItemViewMini extends scaleform.clik.core.UIComponent
    {
        public function SkillItemViewMini()
        {
            super();
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            this._text = arg1;
            this.textField.htmlText = this._text;
            return;
        }

        public function get level():Number
        {
            return this._level;
        }

        public function set level(arg1:Number):void
        {
            this._level = arg1;
            this.text = isNaN(this._level) ? "" : this._level.toString() + LEVEL_POSTFIX;
            return;
        }

        public function get count():int
        {
            return this._count;
        }

        public function set count(arg1:int):void
        {
            this._count = arg1;
            this.text = this._count.toString() + COUNT_POSTFIX;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            if (this._type == arg1) 
                return;
            this._type = arg1;
            this.updateType();
            return;
        }

        protected function updateType():void
        {
            if (this._type == TYPE_CURRENT_NEW_SKILL || this._type == TYPE_NEW_SKILL || this._type == TYPE_NEW_SKILLS) 
                this.iconSource = null;
            gotoAndPlay(this._type);
            return;
        }

        public function get iconSource():String
        {
            return this.icon.source;
        }

        public function set iconSource(arg1:String):void
        {
            this.icon.source = arg1;
            this.icon.visible = Boolean(arg1);
            return;
        }

        public static const TYPE_SKILL:String="skill";

        public static const TYPE_NEW_SKILL:String="new_skill";

        public static const TYPE_SKILLS:String="skills";

        public static const TYPE_NEW_SKILLS:String="new_skills";

        public static const TYPE_CURRENT_SKILL:String="current_skill";

        public static const TYPE_CURRENT_NEW_SKILL:String="current_new_skill";

        public static const LEVEL_POSTFIX:String="%";

        public static const COUNT_POSTFIX:String=" x 100%";

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        public var textField:flash.text.TextField;

        internal var _text:String="";

        internal var _level:Number=0;

        internal var _count:int=0;

        internal var _type:String;
    }
}
