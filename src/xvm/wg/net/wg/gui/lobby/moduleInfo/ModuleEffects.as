package net.wg.gui.lobby.moduleInfo 
{
    import flash.text.*;
    import net.wg.gui.components.tooltips.helpers.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    
    public class ModuleEffects extends scaleform.clik.core.UIComponent
    {
        public function ModuleEffects()
        {
            super();
            return;
        }

        public function setEffects(arg1:Object=null):void
        {
            if (arg1) 
            {
                this.effectsTF.multiline = true;
                this.effectsTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.effectsTF.multiline = true;
                this.effectsTF.htmlText = this.getEffectParams(arg1);
                height = this.effectsTF.y + this.effectsTF.textHeight + this._bottomMargin;
            }
            return;
        }

        public function get bottomMargin():Number
        {
            return this._bottomMargin;
        }

        public function set bottomMargin(arg1:Number):void
        {
            this._bottomMargin = arg1;
            return;
        }

        internal function getEffectParams(arg1:Object):String
        {
            var loc1:*="";
            var loc2:*=25;
            var loc3:*=App.utils.locale;
            if (arg1.effectOnUse && !(arg1.effectOnUse == "") && !(arg1.effectOnUse == undefined)) 
            {
                loc1 = loc1 + this.getEquipmentUsageBlock(loc3.makeString(TOOLTIPS.EQUIPMENT_ONUSE), loc3.makeString(arg1.effectOnUse), loc2);
                loc2 + 25;
            }
            if (!(arg1.effectAlways == "") && !(arg1.effectAlways == "") && !(arg1.effectAlways == undefined)) 
            {
                loc1 = loc1 + this.getEquipmentUsageBlock(loc3.makeString(TOOLTIPS.EQUIPMENT_ALWAYS), loc3.makeString(arg1.effectAlways), loc2);
                loc2 + 25;
            }
            if (loc1 != "") 
            {
                loc1 = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(App.utils.locale.makeString(TOOLTIPS.EQUIPMENT_EFFECT), "#cbad78", 14, "$TitleFont", true) + loc1;
            }
            if (!(arg1.effectRestriction == "") && !(arg1.effectRestriction == "") && !(arg1.effectRestriction == undefined)) 
            {
                loc1 = loc1 + ("<br/>" + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(App.utils.locale.makeString(arg1.effectRestriction), "#cbad78", 13, "$FieldFont") + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(" ", "#cbad78", 28, "$FieldFont"));
            }
            return loc1;
        }

        internal function getEquipmentUsageBlock(arg1:String, arg2:String, arg3:int=20):String
        {
            arg1 = arg1 != "" ? net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(arg1, "#c1ba9c", 13, "$FieldFont", true) + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(" ", "#c1ba9c", arg3, "$FieldFont") : "";
            arg2 = arg2 != "" ? net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(arg2, "#95907f", 12, "$FieldFont") : "";
            var loc1:*;
            return loc1 = "<br/>" + arg1 + "<br/>" + arg2;
        }

        public var effectsTF:flash.text.TextField=null;

        protected var _bottomMargin:Number=20;
    }
}
