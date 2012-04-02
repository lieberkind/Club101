window.URL = window.webkitURL if (window.webkitURL)
@songs = [];


@start = ->
	@current = new Audio(songs[0]);
	@current.play();

@stop = ->
	@current.stop();