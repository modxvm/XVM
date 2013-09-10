package net.wg.gui.lobby.profile.pages 
{
    import flash.geom.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.data.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    
    public class ProfileSection extends net.wg.infrastructure.base.meta.impl.ProfileSectionMeta implements net.wg.infrastructure.base.meta.IProfileSectionMeta, net.wg.gui.lobby.profile.components.IResizableContent
    {
        public function ProfileSection()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(net.wg.gui.lobby.profile.components.ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID) && this.currentDimension) 
            {
                this.applyResizing();
            }
            return;
        }

        protected function applyResizing():void
        {
            if (this.layoutManager) 
            {
                this.layoutManager.setDimension(this.currentDimension.x, this.currentDimension.y);
            }
            this.x = Math.round(this.currentDimension.x / 2 - this._centerOffset);
            return;
        }

        public function setViewSize(arg1:Number, arg2:Number):void
        {
            if (!this.currentDimension) 
            {
                this.currentDimension = new flash.geom.Point();
            }
            this.currentDimension.x = arg1;
            this.currentDimension.y = arg2;
            invalidate(net.wg.gui.lobby.profile.components.ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
            return;
        }

        public function as_update(arg1:Object):void
        {
            return;
        }

        protected function updateByDossier(arg1:net.wg.data.gui_items.dossier.AccountDossier):void
        {
            return;
        }

        public function as_setInitData(arg1:Object):void
        {
            return;
        }

        protected function disposeLayoutManager():void
        {
            if (this.layoutManager) 
            {
                this.layoutManager.dispose();
                this.layoutManager = null;
            }
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.disposeLayoutManager();
            return;
        }

        public function update(arg1:Object):void
        {
            var loc1:*=net.wg.data.gui_items.dossier.AccountDossier(arg1);
            if (this.currentDossier != loc1) 
            {
                this.currentDossier = loc1;
                this.updateByDossier(loc1);
            }
            return;
        }

        public function set active(arg1:Boolean):void
        {
            this.isActive = arg1;
            setActiveS(arg1);
            return;
        }

        public function get active():Boolean
        {
            return this.isActive;
        }

        public function set centerOffset(arg1:int):void
        {
            this._centerOffset = arg1;
            invalidate(net.wg.gui.lobby.profile.components.ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
            return;
        }

        public function get centerOffset():int
        {
            return this._centerOffset;
        }

        public static function applyInitDataToTextField(arg1:String, arg2:Object, arg3:net.wg.gui.lobby.profile.components.LineDescrIconText):void
        {
            var loc1:*=arg2[arg1];
            arg3.description = loc1["description"];
            arg3.iconSource = loc1["icon"];
            return;
        }

        protected var currentDimension:flash.geom.Point;

        public var layoutManager:net.wg.gui.lobby.profile.data.SectionLayoutManager;

        internal var isActive:Boolean;

        protected var _centerOffset:int=0;

        protected var currentDossier:net.wg.data.gui_items.dossier.AccountDossier;
    }
}
