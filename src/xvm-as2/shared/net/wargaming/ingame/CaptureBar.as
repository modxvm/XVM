intrinsic class net.wargaming.ingame.CaptureBar extends MovieClip
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.TeamBasesPanel.CaptureBar;
    /////////////////////////////////////////////////////////////////

    var m_colorFeature:String;
    var m_stopCaptureInterval;
    var id:Number;
    var sortWeight;
    var stop_capture;
    var tweenTimeMotion;

    var m_bgMC:MovieClip;
    var barColors:MovieClip;
    var captureProgress:MovieClip;
    var m_rate;
    var m_points;
    var m_deltaPoint;
    var m_timeLeft;
    var m_vehiclesCount;
    var m_prevDeltaPoint;
    var m_title;
    var m_playersTF:TextField;
    var m_pointsTF:TextField;
    var m_timerTF:TextField;
    var m_titleTF:TextField;

    public function CaptureBar();
    function updateColors();
    function getColorFeature();
    function updateCaptureData(points, rate, timeLeft, vehiclesCount);
    function animProgress(val, rate);
    function initProgress(val);
    function stopCapture();
    function show_bar_anim(is_show);
    function flashBar(obj);
    function updateTitle(value);
    function get points();
    function configUI();
}
