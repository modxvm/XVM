import com.xvm.Wrapper;

class wot.wrapper.VehicleMarkersManager.VehicleMarkerProxy extends gfx.core.UIComponent
{
    private var m_team;

    function VehicleMarkerProxy()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
          "init",
          "update",
          "updateMarkerSettings",
          "setSpeaking",
          "setEntityName",
          "showExInfo",
          "showActionMarker",
          "updateState",
          "updateHealth",
          "settingsUpdate",
          "configUI",
          "onLoad",
          "validateNow",
          "setSize",
          "invalidate",
          "setMarkerState",
          "handleInput",
          "toString",
          "initSize",
          "draw",
          "changeFocus",
          "onMouseWheel",
          "scrollWheel"
        ];
        Wrapper.override(this, new wot.VehicleMarkersManager.VehicleMarkerProxy(this, super), OVERRIDE_FUNCTIONS);
    }

/*
    // override MovieClip
    // TODO: Check performance
    function onEnterFrame():Void
    {
        if (subject == null)
            return;

        var mc:MovieClip = MovieClip(subject);
        if (mc.onEnterFrame != null)
            mc.onEnterFrame();
    }

    // override MovieClip
    function gotoAndStop(frame:Object):Void
    {
        super.gotoAndStop(frame);

        if (Config.s_config.battle.useStandardMarkers == true)
        {
            // Fix marker position (team Killer for example)
            for (var childName in marker.marker)
            {
                marker.marker[childName]._x = 0;
                marker.marker[childName]._y = 16;
            }
            marker._x = 0;
            marker._y = -16;

            // Translate visual elements to subject
            //Logger.addObject(this);
            subject["marker"] = marker;
            subject["levelIcon"] = levelIcon;
            subject["iconLoader"] = iconLoader;
            iconLoader.addEventListener("complete", this, "_onCompleteLoad");
            subject["hp_mc"] = hp_mc;
            subject["actionMarker"] = actionMarker;
            subject["hitLbl"] = hitLbl;
            subject["hitExplosion"] = hitExplosion;
            subject["vNameField"] = vNameField;
            subject["pNameField"] = pNameField;
            subject["healthBar"] = healthBar;
            subject["bgShadow"] = bgShadow;
        }
        else
        {
            // Remove standard fields for XVM
            if (pNameField)
            {
                pNameField._visible = false;
//                pNameField.removeTextField();
//                delete pNameField;
            }

            if (vNameField)
            {
                vNameField._visible = false;
//                vNameField.removeTextField();
//                delete vNameField;
            }

            if (healthBar)
            {
                healthBar.stop();
                healthBar._visible = false;
//                healthBar.removeMovieClip();
//                delete healthBar;
            }

            if (hp_mc)
            {
                hp_mc.stop();
                hp_mc._visible = false;
//                hp_mc.removeMovieClip();
//                delete hp_mc;
            }

            if (hitLbl)
            {
                hitLbl.stop();
                hitLbl._visible = false;
//                hitLbl.removeMovieClip();
//                delete hitLbl;
            }

            if (hp_mc)
            {
                hp_mc.stop();
                hp_mc._visible = false;
//                hp_mc.removeMovieClip();
//                delete hp_mc;
            }
        }
    }

    public function get visible()  { return super.visible; }
    public function set visible(value)  { super.visible = subject.visible = value; }
    public function get disabled() { return super.disabled; }
    public function set disabled(value) { super.disabled = subject.disabled = value; }
    private function get exInfo()
    {
        if (Config.s_config.battle.useStandardMarkers == true && subject != null)
            return subject["exInfo"];
    }
    private function set exInfo(value)
    {
        if (Config.s_config.battle.useStandardMarkers == true && subject != null)
            subject["exInfo"] = value;
    }
    private function get markerSettings()
    {
        if (Config.s_config.battle.useStandardMarkers == true && subject != null)
            return subject["markerSettings"];
    }
    private function set markerSettings(value)
    {
        if (Config.s_config.battle.useStandardMarkers == true && subject != null)
            subject["markerSettings"] = value;
    }
    /**
     * TODO: not all is required, remove unused.
     * /

    public function get width(){
        //trace("*** get width()");
        return subject.width;
    }
    public function set width(value){
        //trace("*** set width()");
        subject.width = value;
    }

    public function get height(){
        //trace("*** get height()");
        return subject.height;
    }
    public function set height(value){
        //trace("*** set height()");
        subject.height = value;
    }

    public function get focused(){
        //trace("*** get focused()");
        return subject.focused;
    }
    public function set focused(value){
        //trace("*** set focused()");
        subject.focused = value;
    }

    public function get displayFocus(){
        //trace("*** get displayFocus()");
        return subject.displayFocus;
    }
    public function set displayFocus(value)
    {
        //trace("*** set displayFocus()");
        subject.displayFocus = value;
    }

*/
}
