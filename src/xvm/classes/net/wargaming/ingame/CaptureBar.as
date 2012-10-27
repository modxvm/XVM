intrinsic class net.wargaming.ingame.CaptureBar
{
    var m_bgMC, m_barMC, m_points, setProgress, m_timerTF:TextField, m_title, m_titleTF:TextField, __get__points;
    
    public function CaptureBar();
    function updateProgress(points);
    function stopCapture();
}