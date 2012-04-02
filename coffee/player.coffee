class Player
  constructor: (@playlist) ->
    @track_number = 0
    @current = new Audio(@playlist[@track_number])

  addToPlaylist: (file) ->
    @playlist.push file

  #(re)set playlist
  setPlaylist: (@playlist = []) ->

  start: -> 
    @current.play()

  pause: ->
    @current.pause() if @current.paused is false      

  next: (callback) ->
    # pause current track
    @pause()

    # restart playlist or move to next track
    if @track_number is (@playlist.length - 1)
      @track_number = 0
    else
      @track_number++

    # define filename
    filename = @playlist[@track_number]

    # set track source
    @current.src = filename

    # start
    @start()
    console.log "Changed track to: " + filename    

  setVolume: (volume) ->
    console.log "Volume change to: #{volume} "
    @current.volume = volume

# songplayer with specific label
class @SongPlayer extends Player
  setLabel: (filename) ->
    firstSlashPos = filename.indexOf("/") + 1
    lastDotPos = filename.lastIndexOf(".")
    filename_human = filename.substring(firstSlashPos, lastDotPos)
    $(".current-song").html filename_human
  next: (callback) ->
    super
    @setLabel @playlist[@track_number]  

# commandplayer with new implementation of next for returning duration in a callback
class @CommandPlayer extends Player
  next: (callback) ->
    # pause current track
    @pause()

    # restart playlist or move to next track
    if @track_number is (@playlist.length - 1)
      @track_number = 0
    else
      @track_number++

    # define filename
    filename = @playlist[@track_number]

    # set track source
    @current.src = filename

    # preloading: wait for duration
    preload = setInterval (=>
      if @current.duration > 0
        clearInterval(preload)

        # return duration of command to Club()
        callback(@current.duration)

        # start next song
        @start()
    ), 1

class @CheersPlayer extends Player