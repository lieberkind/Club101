class @Club  
  constructor: (songs, commands) ->
    @commandProbability = 0.3 # higher means more often commands
    @clubNumber = 0 # the club to start from
    @setTimerSeconds 60 # number of seconds per club
    @paused = true # pause from beginning

    # create song player
    @songPlayer = new SongPlayer('songs/', songs);

    # create command player
    @commandPlayer = new CommandPlayer('commands/', commands);
    
    # bind events
    $('.controls').click => @toggleControls()

    # countdown every second
    setInterval (=>
      
      return false if @paused

      # decrement second by one and update UI accordingly
      @decrementSecond()

      #if @timerSeconds is 3
        # skåål

      # end of song; change to next
      if @timerSeconds is 0
        @songPlayer.next()
        @setTimerSeconds 60
        @setCommand()
        @incrementClubNumber()
      
      # play command depending on probability
      if @timerSeconds is @commandSecond && @commandSecond > 0
        # decrease volume for song
        @songPlayer.setVolume 0.2

        # play command
        @commandPlayer.next( (duration) =>
          console.log "Duration from screen: " + duration
          # increase volume for song again and pause command
          setTimeout ( =>
            @songPlayer.setVolume 1
            @commandPlayer.pause()
          ), duration*1000
        )
    ), 1000

  setSecond: (second) ->
    @timerSeconds = second

  decrementSecond: ->
    # calculations
    @timerSeconds--
    progressBarWidth = (@timerSeconds / 60) * 100    
    
    # UI
    $(".timer-seconds").html @timerSeconds    
    $(".progress-bar-inside").css "width", progressBarWidth + "%"    

  incrementClubNumber: ->
    @clubNumber++
    $(".club-number span").html @clubNumber

  setTimerSeconds: (@timerSeconds) ->

  setCommand: ->
    commandProbabilityScore = Math.random()

    if commandProbabilityScore < @commandProbability
      @commandSecond = Math.floor(37 * Math.random()) + 13
      console.log "Command will be played at " + @commandSecond
    else
      @commandSecond = 0
      console.log "Command will NOT be played"

  resume: ->
    @paused = false
    @songPlayer.start()

  pause: ->    
    @paused = true
    @songPlayer.pause()

  toggleControls: ->
    $('.controls *').toggle();

    if @paused is true
      @resume()
    else
      @pause()