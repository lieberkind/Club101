class @Club  
  constructor: (songs, commands, cheers) ->
    # options
    @commandProbability = 0.3 # higher means more often commands
    @secondsPerClub = 60 # number of seconds per club

    # initial setup
    @clubNumber = 0 # the club to start from    
    @setTimerSeconds @secondsPerClub

    # setup players
    @songPlayer = new SongPlayer(songs);
    @commandPlayer = new CommandPlayer(commands);
    @cheersPlayer = new CheersPlayer(cheers);
    
    # bind functions to DOM events
    @domBind()

    # countdown every second
    setInterval (=>
      
      return false if @songPlayer.current.paused

      if @clubNumber > 100
        $( ".controls" ).button "disable"
        @pause()
        alert "Er du fuld nu?"

      # decrement second by one and update UI accordingly
      @decrementSecond()

      # say cheers!
      @cheersPlayer.next() if @timerSeconds is 1        

      # end of song; change to next
      if @timerSeconds is 0
        @songPlayer.next()
        @setTimerSeconds @secondsPerClub
        @setCommand()
        @incrementClubNumber()
      
      # play command depending on probability
      if @timerSeconds is @commandSecond && @commandSecond > 0
        # decrease volume for song
        @songPlayer.setVolume 0.2

        # play command
        @commandPlayer.next( (duration) =>
          
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
    progressBarWidth = (@timerSeconds / @secondsPerClub) * 100    
    
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
    $( ".controls" ).button
      icons:
        primary: "ui-icon-pause"

    @songPlayer.start()

  pause: ->    
    $( ".controls" ).button
      icons:
        primary: "ui-icon-play"

    @songPlayer.pause()

  toggleControls: ->          
    if @songPlayer.current.paused is true
      @resume()
    else      
      @pause()

  domBind: ->
    # music controller: jQueryUI button style
    $( ".controls" ).button
      text: false 
      icons:
        primary: "ui-icon-play"
    .click => @toggleControls()

    # add local files to playlist
    $(".songUpload").change =>
      $(".songUpload").fadeOut();
      console.log("uploaded")

      # reset playlist
      @songPlayer.setPlaylist()

      # add local songs to playlist
      files = $(".songUpload")[0].files      
      window.URL = window.webkitURL if (window.webkitURL)
      @songPlayer.addToPlaylist window.URL.createObjectURL(file) for file in files       