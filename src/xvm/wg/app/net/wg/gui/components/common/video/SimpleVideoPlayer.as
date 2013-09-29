package net.wg.gui.components.common.video 
{
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import scaleform.clik.core.*;
    
    public class SimpleVideoPlayer extends scaleform.clik.core.UIComponent
    {
        public function SimpleVideoPlayer()
        {
            this._status = net.wg.gui.components.common.video.PlayerStatus.STOP;
            super();
            return;
        }

        public function set source(arg1:String):void
        {
            if (this._source != arg1) 
            {
                this._source = arg1;
                invalidate(VIDEO_SOURCE_INVALID);
            }
            return;
        }

        public function get source():String
        {
            return this._source;
        }

        public function set audioTrack(arg1:Number):void
        {
            this._audioTrack = arg1;
            invalidate(SELECTED_AUDIO_TRACK_INVALID);
            return;
        }

        public function get audioTrack():Number
        {
            return this._audioTrack;
        }

        public function set subtitleTrack(arg1:Number):void
        {
            this._subtitleTrack = arg1;
            invalidate(SELECTED_SUBTITLE_TRACK_INVALID);
            return;
        }

        public function pausePlayback():void
        {
            if (this._status == net.wg.gui.components.common.video.PlayerStatus.PLAYING) 
            {
                this.setPause();
            }
            return;
        }

        public function get subtitleTrack():Number
        {
            return this._subtitleTrack;
        }

        public function get status():uint
        {
            return this._status;
        }

        public function seek(arg1:Number):void
        {
            dispatchEvent(new flash.events.Event(net.wg.gui.components.common.video.VideoPlayerEvent.SEEK_START));
            this.nsStream.seek(arg1);
            return;
        }

        internal function setPlay():void
        {
            this.nsStream.resume();
            this.setStatus(net.wg.gui.components.common.video.PlayerStatus.PLAYING);
            return;
        }

        internal function setPause():void
        {
            this.nsStream.pause();
            this.setStatus(net.wg.gui.components.common.video.PlayerStatus.PAUSE);
            return;
        }

        public function togglePlayback():void
        {
            if (this._status != net.wg.gui.components.common.video.PlayerStatus.PLAYING) 
            {
                if (this._status == net.wg.gui.components.common.video.PlayerStatus.PAUSE) 
                {
                    this.setPlay();
                }
            }
            else 
            {
                this.setPause();
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.ncConnection = new flash.net.NetConnection();
            this.ncConnection.addEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netStatusHandler, false, 0, true);
            this.ncConnection.connect(null);
            this.nsStream = new flash.net.NetStream(this.ncConnection);
            this.nsStream.addEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netStatusHandler, false, 0, true);
            this.nsStream.client = {"onMetaData":this.onMetaDataHandler, "onSubtitle":this.onSubtitleHandler};
            this.nsStream.bufferTime = BUFFER_TIME;
            this.video.attachNetStream(this.nsStream);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(VIDEO_SOURCE_INVALID)) 
            {
                this.applyVideoLoading();
            }
            if (isInvalid(SOUND_LEVEL_INVALID)) 
            {
                if (this.nsStream) 
                {
                    this.nsStream.soundTransform = new flash.media.SoundTransform(this._volume);
                }
            }
            if (isInvalid(SELECTED_SUBTITLE_TRACK_INVALID)) 
            {
                if (this.nsStream.hasOwnProperty(SUBTITLE_TRACK_PROP_NAME)) 
                {
                    if (this._subtitleTotalTracks >= this._subtitleTrack) 
                    {
                        this.nsStream[SUBTITLE_TRACK_PROP_NAME] = this._subtitleTrack;
                    }
                    else 
                    {
                        this.nsStream[SUBTITLE_TRACK_PROP_NAME] = 0;
                    }
                }
            }
            if (isInvalid(SELECTED_AUDIO_TRACK_INVALID)) 
            {
                if (this.nsStream.hasOwnProperty(AUDIO_TRACK_PROP_NAME)) 
                {
                    if (this._audioTotalTracks > this._audioTrack) 
                    {
                        this.nsStream[AUDIO_TRACK_PROP_NAME] = this._audioTrack;
                    }
                    else 
                    {
                        this.nsStream[AUDIO_TRACK_PROP_NAME] = 0;
                    }
                }
            }
            return;
        }

        internal function applyVideoLoading():void
        {
            if (!(this._source == null) || !(this._source == "")) 
            {
                this.setStatus(net.wg.gui.components.common.video.PlayerStatus.LOADING);
                this.setSubtitle("");
                this.nsStream.play(this._source);
                invalidate(SOUND_LEVEL_INVALID);
            }
            return;
        }

        protected function setStatus(arg1:uint):void
        {
            if (this._status != arg1) 
            {
                this._status = arg1;
                dispatchEvent(new net.wg.gui.components.common.video.VideoPlayerStatusEvent(net.wg.gui.components.common.video.VideoPlayerStatusEvent.STATUS_CHANGED));
            }
            return;
        }

        internal function onMetaDataHandler(arg1:Object):void
        {
            this._metaData = arg1;
            if (this.nsStream.hasOwnProperty(SUBTITLE_TRACK_PROP_NAME)) 
            {
                this._subtitleTotalTracks = arg1.subtitleTracksCount;
                invalidate(SELECTED_SUBTITLE_TRACK_INVALID);
            }
            if (this.nsStream.hasOwnProperty(AUDIO_TRACK_PROP_NAME)) 
            {
                this._audioTotalTracks = arg1.audioTracksCount;
                invalidate(SELECTED_AUDIO_TRACK_INVALID);
            }
            dispatchEvent(new flash.events.Event(net.wg.gui.components.common.video.VideoPlayerEvent.META_DATA_CHANGED));
            return;
        }

        internal function onSubtitleHandler(arg1:String):void
        {
            this.setSubtitle(arg1);
            return;
        }

        internal function setSubtitle(arg1:String):void
        {
            this._currentSubtitle = arg1;
            dispatchEvent(new flash.events.Event(net.wg.gui.components.common.video.VideoPlayerEvent.SUBTITLE_CHANGED));
            return;
        }

        protected function netStatusHandler(arg1:flash.events.NetStatusEvent):void
        {
            var loc3:*=null;
            var loc1:*=arg1.info;
            var loc2:*=loc1.code;
            var loc4:*=loc2;
            switch (loc4) 
            {
                case net.wg.gui.components.common.video.NetStreamStatusCode.START:
                {
                    this.setStatus(net.wg.gui.components.common.video.PlayerStatus.PLAYING);
                    App.utils.scheduler.scheduleTask(invalidate, 50, SOUND_LEVEL_INVALID);
                    break;
                }
                case net.wg.gui.components.common.video.NetStreamStatusCode.SEEK_NOTIFY:
                {
                    dispatchEvent(new flash.events.Event(net.wg.gui.components.common.video.VideoPlayerEvent.SEEK_COMPLETE));
                    break;
                }
                case net.wg.gui.components.common.video.NetStreamStatusCode.STOP:
                {
                    this.onPlaybackStopped();
                    break;
                }
                default:
                {
                    if (loc1.level == net.wg.gui.components.common.video.NetStreamStatusLevel.ERROR) 
                    {
                        this.setStatus(net.wg.gui.components.common.video.PlayerStatus.STOP);
                        (loc3 = new net.wg.gui.components.common.video.VideoPlayerStatusEvent(net.wg.gui.components.common.video.VideoPlayerStatusEvent.ERROR)).errorCode = loc2;
                        dispatchEvent(loc3);
                    }
                }
            }
            return;
        }

        public function runPlayback():void
        {
            invalidate(VIDEO_SOURCE_INVALID);
            return;
        }

        public function stopPlayback():void
        {
            this.nsStream.close();
            return;
        }

        internal function onPlaybackStopped():void
        {
            if (this._status == net.wg.gui.components.common.video.PlayerStatus.PLAYING || this._status == net.wg.gui.components.common.video.PlayerStatus.PAUSE) 
            {
                this.setStatus(net.wg.gui.components.common.video.PlayerStatus.STOP);
            }
            dispatchEvent(new net.wg.gui.components.common.video.VideoPlayerEvent(net.wg.gui.components.common.video.VideoPlayerEvent.PLAYBACK_STOPPED));
            return;
        }

        public function resumePlayback():void
        {
            if (this._status == net.wg.gui.components.common.video.PlayerStatus.PAUSE) 
            {
                this.setPlay();
            }
            return;
        }

        public function get volume():Number
        {
            return this._volume;
        }

        public function set volume(arg1:Number):void
        {
            if (this._volume != arg1) 
            {
                this._volume = arg1;
                invalidate(SOUND_LEVEL_INVALID);
                dispatchEvent(new flash.events.Event(net.wg.gui.components.common.video.VideoPlayerEvent.VOLUME_CHANGED));
            }
            return;
        }

        public function get metaData():Object
        {
            return this._metaData;
        }

        public function get currentTime():Number
        {
            if (this.nsStream) 
            {
                return this.nsStream.time;
            }
            return NaN;
        }

        public function get currentSubtitle():String
        {
            return this._currentSubtitle;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.ncConnection) 
            {
                this.ncConnection.removeEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netStatusHandler);
                this.ncConnection.close();
            }
            if (this.nsStream) 
            {
                this.nsStream.removeEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netStatusHandler);
                this.nsStream.close();
            }
            this.ncConnection = null;
            this.nsStream = null;
            if (this.video) 
            {
                this.video.clear();
                if (this.video.parent) 
                {
                    this.video.parent.removeChild(this.video);
                }
                this.video = null;
            }
            return;
        }

        internal static const BUFFER_TIME:uint=8;

        internal static const VIDEO_SOURCE_INVALID:String="loadVideo";

        internal static const SELECTED_SUBTITLE_TRACK_INVALID:String="selSubTitleInv";

        internal static const SELECTED_AUDIO_TRACK_INVALID:String="selAudioInv";

        internal static const SOUND_LEVEL_INVALID:String="soundLvlChanged";

        internal static const AUDIO_TRACK_PROP_NAME:String="audioTrack";

        internal static const SUBTITLE_TRACK_PROP_NAME:String="subtitleTrack";

        internal var _audioTotalTracks:int=-1;

        internal var _subtitleTotalTracks:int=-1;

        internal var _subtitleTrack:int=0;

        internal var _currentSubtitle:String="";

        internal var _metaData:Object;

        internal var _volume:Number=0;

        internal var _status:uint;

        internal var _source:String="";

        internal var ncConnection:flash.net.NetConnection;

        internal var nsStream:flash.net.NetStream;

        public var video:flash.media.Video;

        internal var _audioTrack:int=0;
    }
}
