package net.wg.gui.components.common.video
{
    import scaleform.clik.core.UIComponent;
    import flash.media.Video;
    import flash.net.NetStream;
    import flash.net.NetConnection;
    import flash.events.NetStatusEvent;
    import flash.media.SoundTransform;
    import flash.events.Event;
    
    public class SimpleVideoPlayer extends UIComponent
    {
        
        public function SimpleVideoPlayer()
        {
            this._status = PlayerStatus.STOP;
            super();
        }
        
        private static var BUFFER_TIME:uint = 8;
        
        private static var VIDEO_SOURCE_INVALID:String = "loadVideo";
        
        private static var SELECTED_SUBTITLE_TRACK_INVALID:String = "selSubTitleInv";
        
        private static var SELECTED_AUDIO_TRACK_INVALID:String = "selAudioInv";
        
        private static var SOUND_LEVEL_INVALID:String = "soundLvlChanged";
        
        private static var AUDIO_TRACK_PROP_NAME:String = "audioTrack";
        
        private static var SUBTITLE_TRACK_PROP_NAME:String = "subtitleTrack";
        
        public var video:Video;
        
        private var nsStream:NetStream;
        
        private var ncConnection:NetConnection;
        
        private var _source:String = "";
        
        private var _status:uint;
        
        private var _volume:Number = 0;
        
        private var _metaData:Object;
        
        private var _currentSubtitle:String = "";
        
        private var _subtitleTrack:int = 0;
        
        private var _subtitleTotalTracks:int = -1;
        
        private var _audioTotalTracks:int = -1;
        
        private var _audioTrack:int = 0;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.ncConnection = new NetConnection();
            this.ncConnection.addEventListener(NetStatusEvent.NET_STATUS,this.netStatusHandler,false,0,true);
            this.ncConnection.connect(null);
            this.nsStream = new NetStream(this.ncConnection);
            this.nsStream.addEventListener(NetStatusEvent.NET_STATUS,this.netStatusHandler,false,0,true);
            this.nsStream.client = {"onMetaData":this.onMetaDataHandler,
            "onSubtitle":this.onSubtitleHandler
        };
        this.nsStream.bufferTime = BUFFER_TIME;
        this.video.attachNetStream(this.nsStream);
    }
    
    override protected function draw() : void
    {
        super.draw();
        if(isInvalid(VIDEO_SOURCE_INVALID))
        {
            this.applyVideoLoading();
        }
        if(isInvalid(SOUND_LEVEL_INVALID))
        {
            if(this.nsStream)
            {
                this.nsStream.soundTransform = new SoundTransform(this._volume);
            }
        }
        if(isInvalid(SELECTED_SUBTITLE_TRACK_INVALID))
        {
            if(this.nsStream.hasOwnProperty(SUBTITLE_TRACK_PROP_NAME))
            {
                if(this._subtitleTotalTracks >= this._subtitleTrack)
                {
                    this.nsStream[SUBTITLE_TRACK_PROP_NAME] = this._subtitleTrack;
                }
                else
                {
                    this.nsStream[SUBTITLE_TRACK_PROP_NAME] = 0;
                }
            }
        }
        if(isInvalid(SELECTED_AUDIO_TRACK_INVALID))
        {
            if(this.nsStream.hasOwnProperty(AUDIO_TRACK_PROP_NAME))
            {
                if(this._audioTotalTracks > this._audioTrack)
                {
                    this.nsStream[AUDIO_TRACK_PROP_NAME] = this._audioTrack;
                }
                else
                {
                    this.nsStream[AUDIO_TRACK_PROP_NAME] = 0;
                }
            }
        }
    }
    
    private function applyVideoLoading() : void
    {
        if(!(this._source == null) || !(this._source == ""))
        {
            this.setStatus(PlayerStatus.LOADING);
            this.setSubtitle("");
            this.nsStream.play(this._source);
            invalidate(SOUND_LEVEL_INVALID);
        }
    }
    
    protected function setStatus(param1:uint) : void
    {
        if(this._status != param1)
        {
            this._status = param1;
            dispatchEvent(new VideoPlayerStatusEvent(VideoPlayerStatusEvent.STATUS_CHANGED));
        }
    }
    
    private function onMetaDataHandler(param1:Object) : void
    {
        this._metaData = param1;
        if(this.nsStream.hasOwnProperty(SUBTITLE_TRACK_PROP_NAME))
        {
            this._subtitleTotalTracks = param1.subtitleTracksCount;
            invalidate(SELECTED_SUBTITLE_TRACK_INVALID);
        }
        if(this.nsStream.hasOwnProperty(AUDIO_TRACK_PROP_NAME))
        {
            this._audioTotalTracks = param1.audioTracksCount;
            invalidate(SELECTED_AUDIO_TRACK_INVALID);
        }
        dispatchEvent(new Event(VideoPlayerEvent.META_DATA_CHANGED));
    }
    
    private function onSubtitleHandler(param1:String) : void
    {
        this.setSubtitle(param1);
    }
    
    private function setSubtitle(param1:String) : void
    {
        this._currentSubtitle = param1;
        dispatchEvent(new Event(VideoPlayerEvent.SUBTITLE_CHANGED));
    }
    
    protected function netStatusHandler(param1:NetStatusEvent) : void
    {
        var _loc4_:VideoPlayerStatusEvent = null;
        var _loc2_:Object = param1.info;
        var _loc3_:String = _loc2_.code;
        switch(_loc3_)
        {
            case NetStreamStatusCode.START:
                this.setStatus(PlayerStatus.PLAYING);
                App.utils.scheduler.scheduleTask(invalidate,50,SOUND_LEVEL_INVALID);
                break;
            case NetStreamStatusCode.SEEK_NOTIFY:
                dispatchEvent(new Event(VideoPlayerEvent.SEEK_COMPLETE));
                break;
            case NetStreamStatusCode.STOP:
                this.onPlaybackStopped();
                break;
            default:
                if(_loc2_.level == NetStreamStatusLevel.ERROR)
                {
                    this.setStatus(PlayerStatus.STOP);
                    _loc4_ = new VideoPlayerStatusEvent(VideoPlayerStatusEvent.ERROR);
                    _loc4_.errorCode = _loc3_;
                    dispatchEvent(_loc4_);
                }
        }
    }
    
    public function runPlayback() : void
    {
        invalidate(VIDEO_SOURCE_INVALID);
    }
    
    public function stopPlayback() : void
    {
        this.nsStream.close();
    }
    
    private function onPlaybackStopped() : void
    {
        if(this._status == PlayerStatus.PLAYING || this._status == PlayerStatus.PAUSE)
        {
            this.setStatus(PlayerStatus.STOP);
        }
        dispatchEvent(new VideoPlayerEvent(VideoPlayerEvent.PLAYBACK_STOPPED));
    }
    
    public function resumePlayback() : void
    {
        if(this._status == PlayerStatus.PAUSE)
        {
            this.setPlay();
        }
    }
    
    public function pausePlayback() : void
    {
        if(this._status == PlayerStatus.PLAYING)
        {
            this.setPause();
        }
    }
    
    public function togglePlayback() : void
    {
        if(this._status == PlayerStatus.PLAYING)
        {
            this.setPause();
        }
        else if(this._status == PlayerStatus.PAUSE)
        {
            this.setPlay();
        }
        
    }
    
    private function setPause() : void
    {
        this.nsStream.pause();
        this.setStatus(PlayerStatus.PAUSE);
    }
    
    private function setPlay() : void
    {
        this.nsStream.resume();
        this.setStatus(PlayerStatus.PLAYING);
    }
    
    public function seek(param1:Number) : void
    {
        dispatchEvent(new Event(VideoPlayerEvent.SEEK_START));
        this.nsStream.seek(param1);
    }
    
    public function get status() : uint
    {
        return this._status;
    }
    
    public function get subtitleTrack() : Number
    {
        return this._subtitleTrack;
    }
    
    public function set subtitleTrack(param1:Number) : void
    {
        this._subtitleTrack = param1;
        invalidate(SELECTED_SUBTITLE_TRACK_INVALID);
    }
    
    public function get audioTrack() : Number
    {
        return this._audioTrack;
    }
    
    public function set audioTrack(param1:Number) : void
    {
        this._audioTrack = param1;
        invalidate(SELECTED_AUDIO_TRACK_INVALID);
    }
    
    public function get source() : String
    {
        return this._source;
    }
    
    public function set source(param1:String) : void
    {
        if(this._source != param1)
        {
            this._source = param1;
            invalidate(VIDEO_SOURCE_INVALID);
        }
    }
    
    public function get volume() : Number
    {
        return this._volume;
    }
    
    public function set volume(param1:Number) : void
    {
        if(this._volume != param1)
        {
            this._volume = param1;
            invalidate(SOUND_LEVEL_INVALID);
            dispatchEvent(new Event(VideoPlayerEvent.VOLUME_CHANGED));
        }
    }
    
    /*public function get metaData() : Object
    {
        return this._metaData;
    }*/
    
    public function get currentTime() : Number
    {
        if(this.nsStream)
        {
            return this.nsStream.time;
        }
        return NaN;
    }
    
    public function get currentSubtitle() : String
    {
        return this._currentSubtitle;
    }
    
    override protected function onDispose() : void
    {
        super.onDispose();
        App.utils.scheduler.cancelTask(invalidate);
        if(this.ncConnection)
        {
            this.ncConnection.removeEventListener(NetStatusEvent.NET_STATUS,this.netStatusHandler);
            this.ncConnection.close();
        }
        if(this.nsStream)
        {
            this.nsStream.removeEventListener(NetStatusEvent.NET_STATUS,this.netStatusHandler);
            this.nsStream.close();
        }
        this.ncConnection = null;
        this.nsStream = null;
        if(this.video)
        {
            this.video.clear();
            if(this.video.parent)
            {
                this.video.parent.removeChild(this.video);
            }
            this.video = null;
        }
    }
}
}
