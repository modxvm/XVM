package xvm.comments.UI
{
    import com.xvm.*;

    public dynamic class UI_UserRosterItemRenderer extends UserRosterItemRendererUI
    {
        public function UI_UserRosterItemRenderer()
        {
            //Logger.add("UI_UserRosterItemRenderer");
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
        }

        override protected function draw():void
        {
            try
            {
                //Logger.add("draw");
                var dataDirty:Boolean = isInvalid("update_data") && data;

                super.draw();
                if (_baseDisposed)
                    return;

                if (dataDirty)
                {
/*                    if (dataVO == null)
                        return;

                    var id:Number = dataVO.compactDescr;
                    var dossier:AccountDossier = Dossier.getAccountDossier();
                    if (dossier != null)
                    {
                        var vdata:VehicleDossierCut = dossier.getVehicleDossierCut(id);
                        vdata.elite = dataVO.elite ? "elite" : null;
                        ExtraFields.updateVehicleExtraFields(extraFields, vdata);
                    }*/
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        // PRIVATE

    }
}
