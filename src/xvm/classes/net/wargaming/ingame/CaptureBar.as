intrinsic class net.wargaming.ingame.CaptureBar
{
    var m_bgMC, m_barMC, m_points, setProgress, m_timerTF, m_title, m_titleTF, __get__points;
    
    public function CaptureBar();
    function updateProgress(points);
    function stopCapture();
}