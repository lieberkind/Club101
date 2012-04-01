(function() {

  this.Club = (function() {

    function Club(songs, commands) {
      var _this = this;
      this.commandProbability = 0.3;
      this.clubNumber = 0;
      this.setTimerSeconds(60);
      this.paused = true;
      this.songPlayer = new SongPlayer('songs/', songs);
      this.commandPlayer = new CommandPlayer('commands/', commands);
      $('.controls').click(function() {
        return _this.toggleControls();
      });
      setInterval((function() {
        if (_this.paused) return false;
        _this.decrementSecond();
        if (_this.timerSeconds === 0) {
          _this.songPlayer.next();
          _this.setTimerSeconds(60);
          _this.setCommand();
          _this.incrementClubNumber();
        }
        if (_this.timerSeconds === _this.commandSecond && _this.commandSecond > 0) {
          _this.songPlayer.setVolume(0.2);
          return _this.commandPlayer.next(function(duration) {
            console.log("Duration from screen: " + duration);
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
      progressBarWidth = (this.timerSeconds / 60) * 100;
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
      this.paused = false;
      return this.songPlayer.start();
    };

    Club.prototype.pause = function() {
      this.paused = true;
      return this.songPlayer.pause();
    };

    Club.prototype.toggleControls = function() {
      $('.controls *').toggle();
      if (this.paused === true) {
        return this.resume();
      } else {
        return this.pause();
      }
    };

    return Club;

  })();

}).call(this);
