package net.wg.gui.lobby.profile.pages.technique 
{
    import flash.events.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.components.controls.*;
    
    public class ProfileTechniquePage extends net.wg.gui.lobby.profile.pages.technique.ProfileTechnique
    {
        public function ProfileTechniquePage()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.checkBoxExistence.addEventListener(flash.events.Event.SELECT, this.checkBoxSelectHandler, false, 0, true);
            this.checkBoxExistence.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.checkBoxMouseOverHandler, false, 0, true);
            this.checkBoxExistence.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.checkBoxMouseOutHandler, false, 0, true);
            return;
        }

        internal function checkBoxMouseOverHandler(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showComplex(PROFILE.SECTION_TECHNIQUE_CHECKBOXHANGARVEHICLES_TOOLTIP);
            return;
        }

        internal function checkBoxMouseOutHandler(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function checkBoxSelectHandler(arg1:flash.events.Event):void
        {
            if (currentDossier) 
                this.updateByDossier(currentDossier);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        public override function as_setInitData(arg1:Object):void
        {
            super.as_setInitData(arg1);
            this.checkBoxExistence.label = arg1.hangarVehiclesLabel;
            return;
        }

        protected override function updateByDossier(arg1:net.wg.data.gui_items.dossier.AccountDossier):void
        {
            if (this.checkBoxExistence.selected) 
                listComponent.dataProvider = arg1.getHangarVehiclesList();
            else 
                listComponent.dataProvider = arg1.getAllVehiclesList();
            return;
        }

        protected override function onDispose():void
        {
            this.checkBoxExistence.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.checkBoxMouseOverHandler);
            this.checkBoxExistence.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.checkBoxMouseOutHandler);
            super.onDispose();
            return;
        }

        public var checkBoxExistence:net.wg.gui.components.controls.CheckBox;
    }
}
