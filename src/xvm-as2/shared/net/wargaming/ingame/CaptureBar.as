intrinsic class net.wargaming.ingame.CaptureBar
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.TeamBasesPanel.CaptureBar;
    /////////////////////////////////////////////////////////////////

    var m_bgMC;
    var captureProgress;
    var m_colorFeature;
    var m_points, setProgress, m_timerTF:TextField, m_title, m_titleTF:TextField, __get__points;

    public function CaptureBar();
    function updateProgress(points);
    function stopCapture();
    function updateTitle(value);
    function configUI();
}
