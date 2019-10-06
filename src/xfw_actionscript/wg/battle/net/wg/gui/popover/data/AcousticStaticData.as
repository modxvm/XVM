package net.wg.gui.popover.data
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.constants.generated.ACOUSTICS;

    public class AcousticStaticData extends Object implements IDisposable
    {

        private var _data:Object = null;

        public function AcousticStaticData()
        {
            super();
            var _loc1_:AcousticTypeBlockData = new AcousticTypeBlockData(65,new <AcousticItemData>[new AcousticItemData(ACOUSTICS.SPEAKER_ID_LEFT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_LEFT,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_SIDES,true,42,136),new AcousticItemData(ACOUSTICS.SPEAKER_ID_RIGHT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_RIGHT,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_SIDES,true,251,136)]);
            var _loc2_:AcousticTypeBlockData = new AcousticTypeBlockData(94,new <AcousticItemData>[new AcousticItemData(ACOUSTICS.SPEAKER_ID_LEFT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_LEFT,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_SIDES,true,42,65),new AcousticItemData(ACOUSTICS.SPEAKER_ID_RIGHT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_RIGHT,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_SIDES,true,251,65)]);
            var _loc3_:AcousticTypeBlockData = new AcousticTypeBlockData(137,new <AcousticItemData>[new AcousticItemData(ACOUSTICS.SPEAKER_ID_LEFT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_LEFT,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_SIDES,true,42,61),new AcousticItemData(ACOUSTICS.SPEAKER_ID_SUB,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_SUB,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SUB,SETTINGS.SOUNDS_SPEAKERS_OPTIONALSUB,false,148,80),new AcousticItemData(ACOUSTICS.SPEAKER_ID_RIGHT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_RIGHT,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_SIDES,true,251,61)]);
            var _loc4_:AcousticTypeBlockData = new AcousticTypeBlockData(204,new <AcousticItemData>[new AcousticItemData(ACOUSTICS.SPEAKER_ID_LEFT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_LEFTSIDE,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_SIDES,true,42,276),new AcousticItemData(ACOUSTICS.SPEAKER_ID_LEFT_FRONT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_LEFTFRONT,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_FRONT,true,42,90),new AcousticItemData(ACOUSTICS.SPEAKER_ID_CENTER,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_CENTER,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_CENTER,true,150,60),new AcousticItemData(ACOUSTICS.SPEAKER_ID_SUB,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_SUB,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SUB,SETTINGS.SOUNDS_SPEAKERS_SUB,true,150,150),new AcousticItemData(ACOUSTICS.SPEAKER_ID_RIGHT_FRONT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_RIGHTFRONT,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_FRONT,true,253,90),new AcousticItemData(ACOUSTICS.SPEAKER_ID_RIGHT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_RIGHTSIDE,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_SIDES,true,253,276)]);
            var _loc5_:AcousticTypeBlockData = new AcousticTypeBlockData(223,new <AcousticItemData>[new AcousticItemData(ACOUSTICS.SPEAKER_ID_LEFT_BACK,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_LEFTBACK,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_BACK,true,42,356),new AcousticItemData(ACOUSTICS.SPEAKER_ID_LEFT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_LEFTSIDE,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_SIDELONG,true,42,223),new AcousticItemData(ACOUSTICS.SPEAKER_ID_LEFT_FRONT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_LEFTFRONT,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_FRONT,true,42,90),new AcousticItemData(ACOUSTICS.SPEAKER_ID_CENTER,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_CENTER,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_CENTER,true,150,60),new AcousticItemData(ACOUSTICS.SPEAKER_ID_SUB,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_SUB,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SUB,SETTINGS.SOUNDS_SPEAKERS_SUB,true,150,150),new AcousticItemData(ACOUSTICS.SPEAKER_ID_RIGHT_FRONT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_RIGHTFRONT,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_FRONT,true,253,90),new AcousticItemData(ACOUSTICS.SPEAKER_ID_RIGHT,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_RIGHTSIDE,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_SIDELONG,true,253,223),new AcousticItemData(ACOUSTICS.SPEAKER_ID_RIGHT_BACK,SETTINGS.SOUNDS_ACOUSTICTYPE_POPOVER_ITEM_RIGHTBACK,RES_ICONS.MAPS_ICONS_BUTTONS_SPEAKER_SMALL,SETTINGS.SOUNDS_SPEAKERS_BACK,true,253,356)]);
            this._data = {};
            this._data[ACOUSTICS.TYPE_HEADPHONES] = _loc1_;
            this._data[ACOUSTICS.TYPE_LAPTOP] = _loc2_;
            this._data[ACOUSTICS.TYPE_ACOUSTIC_20] = _loc3_;
            this._data[ACOUSTICS.TYPE_ACOUSTIC_51] = _loc4_;
            this._data[ACOUSTICS.TYPE_ACOUSTIC_71] = _loc5_;
        }

        public function getDataById(param1:String) : AcousticTypeBlockData
        {
            if(this._data.hasOwnProperty(param1))
            {
                return this._data[param1];
            }
            return null;
        }

        public final function dispose() : void
        {
            App.utils.data.cleanupDynamicObject(this._data);
            this._data = null;
        }
    }
}
