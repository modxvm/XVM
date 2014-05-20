class com.xvm.XvmComponent
{
    private var invalidationIntervalID;

    public function invalidate(interval:Number)
    {
        if (!invalidationIntervalID)
            invalidationIntervalID = setInterval(this, "validateNow", (!interval || interval < 0) ? 1 : interval);
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
