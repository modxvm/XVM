package net.wg.gui.lobby.header.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import org.idmedia.as3commons.lang.Exception;

    public class HBC_AbstractVO extends DAAPIDataClass implements IHBC_VO
    {

        public static const TOOLTIP_NONE:String = "none";

        public static const TOOLTIP_COMPLEX:String = "complex";

        public static const TOOLTIP_SPECIAL:String = "special";

        protected var _tooltip:String = "";

        protected var _tooltipType:String = "none";

        public function HBC_AbstractVO(param1:Object = null)
        {
            super(param1);
        }

        public function get tooltip() : String
        {
            return this._tooltip;
        }

        public function set tooltip(param1:String) : void
        {
            this._tooltip = param1;
        }

        public function get tooltipType() : String
        {
            return this._tooltipType;
        }

        public function set tooltipType(param1:String) : void
        {
            switch(param1)
            {
                case TOOLTIP_NONE:
                case TOOLTIP_COMPLEX:
                case TOOLTIP_SPECIAL:
                    this._tooltipType = param1;
                    return;
                default:
                    throw new Exception("Unknown tooltip type provided \'" + param1 + "\'");
            }
        }
    }
}
