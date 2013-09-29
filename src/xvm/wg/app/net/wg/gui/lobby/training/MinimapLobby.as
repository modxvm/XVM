package net.wg.gui.lobby.training 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class MinimapLobby extends net.wg.infrastructure.base.meta.impl.MinimapLobbyMeta implements net.wg.infrastructure.base.meta.IMinimapLobbyMeta
    {
        public function MinimapLobby()
        {
            super();
            return;
        }

        public override function setMapS(arg1:Number):void
        {
            App.utils.asserter.assert(!isNaN(arg1), "arenaID" + net.wg.data.constants.Errors.CANT_NAN);
            super.setMapS(arg1);
            return;
        }

        public function as_clear():void
        {
            this.clearAll();
            return;
        }

        internal function clearAll():void
        {
            while (icons.numChildren > 0) 
            {
                icons.removeChildAt(0);
            }
            return;
        }

        public function as_changeMap(arg1:String):void
        {
            this.map.visible = true;
            this.map.source = arg1;
            return;
        }

        public function as_addPoint(arg1:Number, arg2:Number, arg3:String, arg4:String, arg5:String):void
        {
            var loc1:*={"x":arg1, "y":arg2, "scaleX":1.5, "scaleY":-1.5};
            var loc2:*=App.utils.classFactory.getComponent(net.wg.data.constants.Linkages.MINIMAP_ENTRY, net.wg.infrastructure.interfaces.IMinimapEntry, loc1);
            icons.addChild(loc2 as flash.display.DisplayObject);
            loc2.init("points", arg3, arg4, arg5);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            icons.mask = iconsMask;
            return;
        }

        protected override function onDispose():void
        {
            icons.mask = null;
            this.map.dispose();
            this.map = null;
            this.clearAll();
            super.onDispose();
            return;
        }

        internal static const MINIMAP_SIZE:Number=300;

        public var scope:String="inRoom";

        public var map:net.wg.gui.components.controls.UILoaderAlt;
    }
}
