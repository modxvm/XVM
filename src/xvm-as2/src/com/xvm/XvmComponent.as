class com.xvm.XvmComponent
{
    private var invalidationIntervalID;

    public function invalidate()
    {
        if (!invalidationIntervalID)
            invalidationIntervalID = setInterval(this, "validateNow", 1);
    }

    public function validateNow()
    {
        clearInterval(invalidationIntervalID);
        delete invalidationIntervalID;
        draw();
    }

    // virtual
    public function draw()
    {
    }
}
