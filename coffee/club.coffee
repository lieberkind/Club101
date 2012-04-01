class @Club  
  constructor: (songs, commands, cheers) ->
    @commandProbability = 0.3 # higher means more often commands
    @clubNumber = 0 # the club to start from
    @setTimerSeconds 60 # number of seconds per club
    @paused = true # pause from beginning

    # setup players
    @songPlayer = new SongPlayer('songs/', songs);
    @commandPlayer = new CommandPlayer('commands/', commands);
    @cheersPlayer = new CheersPlayer('cheers/', cheers);
    
    # bind events
    $( ".controls" )
    .button
      text: false 
      icons:
        primary: "ui-icon-play"
    .click => @toggleControls()


    # countdown every second
    setInterval (=>
      
      return false if @paused

      # decrement second by one and update UI accordingly
      @decrementSecond()

      # say cheers!
      @cheersPlayer.next() if @timerSeconds is 1        

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
    if @paused is true
      $( ".controls" ).button
        icons:
          primary: "ui-icon-pause"
      @resume()
    else
      $( ".controls" ).button
        icons:
          primary: "ui-icon-play"
      @pause()