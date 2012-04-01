(function() {
  var Player,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Player = (function() {

    function Player(folder, playlist) {
      this.folder = folder;
      this.playlist = playlist;
      this.track_number = 0;
      this.current = new Audio(this.folder + this.playlist[this.track_number]);
    }

    Player.prototype.start = function() {
      return this.current.play();
    };

    Player.prototype.pause = function() {
      if (this.current.paused === false) return this.current.pause();
    };

    Player.prototype.next = function(callback) {
      var filename;
      this.pause();
      if (this.track_number === (this.playlist.length - 1)) {
        this.track_number = 0;
      } else {
        this.track_number++;
      }
      filename = this.playlist[this.track_number];
      this.current.src = this.folder + filename;
      this.start();
      return console.log("Changed track to: " + filename);
    };

    Player.prototype.setVolume = function(volume) {
      console.log("Volume change to: " + volume + " ");
      return this.current.volume = volume;
    };

    return Player;

  })();

  this.SongPlayer = (function(_super) {

    __extends(SongPlayer, _super);

    function SongPlayer() {
      SongPlayer.__super__.constructor.apply(this, arguments);
    }

    SongPlayer.prototype.setLabel = function(filename) {
      var filename_human;
      filename_human = filename.substring(0, filename.length - 4);
      return $(".current-song").html(filename_human);
    };

    SongPlayer.prototype.next = function(callback) {
      SongPlayer.__super__.next.apply(this, arguments);
      return this.setLabel(this.playlist[this.track_number]);
    };

    return SongPlayer;

  })(Player);

  this.CommandPlayer = (function(_super) {

    __extends(CommandPlayer, _super);

    function CommandPlayer() {
      CommandPlayer.__super__.constructor.apply(this, arguments);
    }

    CommandPlayer.prototype.next = function(callback) {
      var filename, preload,
        _this = this;
      this.pause();
      if (this.track_number === (this.playlist.length - 1)) {
        this.track_number = 0;
      } else {
        this.track_number++;
      }
      filename = this.playlist[this.track_number];
      this.current.src = this.folder + filename;
      return preload = setInterval((function() {
        if (_this.current.duration > 0) {
          clearInterval(preload);
          callback(_this.current.duration);
          return _this.start();
        }
      }), 1);
    };

    return CommandPlayer;

  })(Player);

  this.CheersPlayer = (function(_super) {

    __extends(CheersPlayer, _super);

    function CheersPlayer() {
      CheersPlayer.__super__.constructor.apply(this, arguments);
    }

    return CheersPlayer;

  })(Player);

}).call(this);
