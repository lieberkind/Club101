(function() {

  if (window.webkitURL) window.URL = window.webkitURL;

  this.songs = [];

  this.start = function() {
    this.current = new Audio(songs[0]);
    return this.current.play();
  };

  this.stop = function() {
    return this.current.stop();
  };

}).call(this);
