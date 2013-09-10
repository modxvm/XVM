package net.wg.gui.lobby.hangar 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.data.*;
    import scaleform.clik.interfaces.*;
    
    public class Params extends net.wg.infrastructure.base.meta.impl.ParamsMeta implements net.wg.infrastructure.base.meta.IParamsMeta, net.wg.infrastructure.interfaces.IHelpLayoutComponent
    {
        public function Params()
        {
            super();
            this.paramsListeners = new net.wg.gui.lobby.hangar.ParamsListener();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            mouseChildren = false;
            mouseEnabled = false;
            return;
        }

        public function as_setValues(arg1:Array):void
        {
            this.list.visible = Boolean(arg1.length);
            this.list.dataProvider = this.setupDataProvider(arg1);
            var loc1:*=28;
            this.list.bg.height = loc1 * arg1.length;
            return;
        }

        internal function setupDataProvider(arg1:Array):scaleform.clik.interfaces.IDataProvider
        {
            var loc2:*=null;
            var loc1:*=new scaleform.clik.data.DataProvider();
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc2 in loc4) 
            {
                loc1.push(new net.wg.gui.lobby.hangar.ParamsVO(loc2));
            }
            return loc1;
        }

        public function as_highlightParams(arg1:String):void
        {
            var loc3:*=null;
            var loc1:*=this.list.dataProvider;
            var loc2:*=loc1.length;
            var loc4:*=0;
            var loc5:*=loc1;
            for each (loc3 in loc5) 
            {
                loc3.selected = this.paramsListeners.getParams(arg1).indexOf(loc3.text) > -1;
            }
            this.list.invalidateData();
            return;
        }

        public function showHelpLayout():void
        {
            var loc1:*=App.utils.helpLayout;
            var loc2:*=loc1.getProps(_width, _height, net.wg.data.constants.Directions.LEFT, LOBBY_HELP.HANGAR_VEHICLE_PARAMETERS, 0, 0);
            this._helpLayout = loc1.create(root, loc2, this);
            return;
        }

        public function closeHelpLayout():void
        {
            var loc1:*=App.utils.helpLayout;
            loc1.destroy(this._helpLayout);
            return;
        }

        protected override function onDispose():void
        {
            this.list.dispose();
            this.paramsListeners.dispose();
            this.paramsListeners = null;
            if (this._helpLayout) 
            {
                this.closeHelpLayout();
                this._helpLayout = null;
            }
            super.onDispose();
            return;
        }

        internal var paramsListeners:net.wg.gui.lobby.hangar.ParamsListener=null;

        public var list:net.wg.gui.components.controls.WgScrollingList;

        internal var _helpLayout:flash.display.DisplayObject;
    }
}
