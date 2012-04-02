(function() {

  this.Club = (function() {

    function Club(songs, commands, cheers) {
      var _this = this;
      this.commandProbability = 0.3;
      this.secondsPerClub = 60;
      this.clubNumber = 0;
      this.setTimerSeconds(this.secondsPerClub);
      this.songPlayer = new SongPlayer(songs);
      this.commandPlayer = new CommandPlayer(commands);
      this.cheersPlayer = new CheersPlayer(cheers);
      $(".controls").button({
        text: false,
        icons: {
          primary: "ui-icon-play"
        }
      }).click(function() {
        return _this.toggleControls();
      });
      $(".songUpload").change(function() {
        var file, files, _i, _len, _results;
        console.log("uploaded");
        _this.songPlayer.setPlaylist();
        files = $(".songUpload")[0].files;
        if (window.webkitURL) window.URL = window.webkitURL;
        _results = [];
        for (_i = 0, _len = files.length; _i < _len; _i++) {
          file = files[_i];
          _results.push(_this.songPlayer.addToPlaylist(window.URL.createObjectURL(file)));
        }
        return _results;
      });
      setInterval((function() {
        if (_this.songPlayer.current.paused) return false;
        if (_this.clubNumber > 100) {
          $(".controls").button("disable");
          _this.pause();
          alert("Er du fuld nu?");
        }
        _this.decrementSecond();
        if (_this.timerSeconds === 1) _this.cheersPlayer.next();
        if (_this.timerSeconds === 0) {
          _this.songPlayer.next();
          _this.setTimerSeconds(_this.secondsPerClub);
          _this.setCommand();
          _this.incrementClubNumber();
        }
        if (_this.timerSeconds === _this.commandSecond && _this.commandSecond > 0) {
          _this.songPlayer.setVolume(0.2);
          return _this.commandPlayer.next(function(duration) {
            return setTimeout((function() {
              _this.songPlayer.setVolume(1);
              return _this.commandPlayer.pause();
            }), duration * 1000);
          });
        }
      }), 1000);
    }

    Club.prototype.setSecond = function(second) {
      return this.timerSeconds = second;
    };

    Club.prototype.decrementSecond = function() {
      var progressBarWidth;
      this.timerSeconds--;
      progressBarWidth = (this.timerSeconds / this.secondsPerClub) * 100;
      $(".timer-seconds").html(this.timerSeconds);
      return $(".progress-bar-inside").css("width", progressBarWidth + "%");
    };

    Club.prototype.incrementClubNumber = function() {
      this.clubNumber++;
      return $(".club-number span").html(this.clubNumber);
    };

    Club.prototype.setTimerSeconds = function(timerSeconds) {
      this.timerSeconds = timerSeconds;
    };

    Club.prototype.setCommand = function() {
      var commandProbabilityScore;
      commandProbabilityScore = Math.random();
      if (commandProbabilityScore < this.commandProbability) {
        this.commandSecond = Math.floor(37 * Math.random()) + 13;
        return console.log("Command will be played at " + this.commandSecond);
      } else {
        this.commandSecond = 0;
        return console.log("Command will NOT be played");
      }
    };

    Club.prototype.resume = function() {
      $(".controls").button({
        icons: {
          primary: "ui-icon-pause"
        }
      });
      return this.songPlayer.start();
    };

    Club.prototype.pause = function() {
      $(".controls").button({
        icons: {
          primary: "ui-icon-play"
        }
      });
      return this.songPlayer.pause();
    };

    Club.prototype.toggleControls = function() {
      if (this.songPlayer.current.paused === true) {
        return this.resume();
      } else {
        return this.pause();
      }
    };

    return Club;

  })();

}).call(this);
