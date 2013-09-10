package net.wg.gui.lobby.profile.pages.technique 
{
    import flash.events.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.profile.data.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    
    public class ProfileTechnique extends net.wg.infrastructure.base.meta.impl.ProfileTechniqueMeta implements net.wg.infrastructure.base.meta.IProfileTechniqueMeta
    {
        public function ProfileTechnique()
        {
            super();
            this.listComponent.addEventListener(net.wg.gui.lobby.profile.pages.technique.TechniqueListComponent.DATA_CHANGED, this.listDataChangeHandler, false, 0, true);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            layoutManager = new net.wg.gui.lobby.profile.data.SectionLayoutManager(525, 740);
            layoutManager.registerComponents(this.listComponent, this.stackComponent);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        internal function listDataChangeHandler(arg1:flash.events.Event):void
        {
            var loc1:*=this.listComponent.selectedItem;
            if (loc1) 
            {
                this.stackComponent.setData(loc1);
                dispatchEvent(new net.wg.gui.lobby.profile.pages.technique.TechniquePageEvent(net.wg.gui.lobby.profile.pages.technique.TechniquePageEvent.DATA_STATUS_CHANGED, true, true));
                requestDataS({"userName":currentDossier.id, "vehicleId":loc1.id});
            }
            return;
        }

        protected override function onDispose():void
        {
            if (this.listComponent) 
            {
                this.listComponent.removeEventListener(net.wg.gui.lobby.profile.pages.technique.TechniqueListComponent.DATA_CHANGED, this.listDataChangeHandler);
                this.listComponent.dispose();
                this.listComponent = null;
            }
            if (this.stackComponent) 
            {
                this.stackComponent.dispose();
                this.stackComponent = null;
            }
            super.onDispose();
            return;
        }

        protected override function applyResizing():void
        {
            if (layoutManager) 
                layoutManager.setDimension(currentDimension.x, currentDimension.y);
            this.x = Math.round(currentDimension.x / 2 - centerOffset);
            this.listComponent.setViewSize(currentDimension.x, currentDimension.y - this.listComponent.y);
            this.stackComponent.setViewSize(Math.min(currentDimension.x, net.wg.gui.lobby.profile.ProfileConstants.MIN_APP_WIDTH) - this.stackComponent.x, currentDimension.y - this.stackComponent.y);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(CURRENT_DIMENSION_INVALID) && currentDimension) 
                this.applyResizing();
            return;
        }

        public override function as_update(arg1:Object):void
        {
            this.stackComponent.updateTankData(new net.wg.data.gui_items.dossier.VehicleDossier(arg1.vehicleId, arg1.userName));
            dispatchEvent(new net.wg.gui.lobby.profile.pages.technique.TechniquePageEvent(net.wg.gui.lobby.profile.pages.technique.TechniquePageEvent.DATA_STATUS_CHANGED, false, true));
            return;
        }

        internal static const CURRENT_DIMENSION_INVALID:String="cdInv";

        public var listComponent:net.wg.gui.lobby.profile.pages.technique.TechniqueListComponent;

        public var stackComponent:net.wg.gui.lobby.profile.pages.technique.TechniqueStackComponent;
    }
}
