<?php
	include("lib.php");

	// get list of files
	$commands = readFolder("commands");	
	$songs = readFolder("songs");
	$cheers = readFolder("cheers");
?>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" href="stylesheets/screen.css">
	<link rel="stylesheet" href="stylesheets/ui-darkness/jquery-ui-1.8.18.custom.css">	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="js/jquery-ui-1.8.18.custom.min.js"></script>
	<script src="js/player.js"></script>	
	<script src="js/club.js"></script>
	<script src="js/screen.js"></script>	
	<script type="text/javascript">
		var club;
		$(document).ready(function() {
			club = new Club(<?php echo $songs ?>, <?php echo $commands ?>, <?php echo $cheers ?>);
		});	
	</script>
</head>
<body class="bp">
	<div class="container">

		<h1 class="title">Club 101</h1>
		<p class="sub-title">En club sejere</p>		

		<div class="progress-bar">
			<p class="controls"></p>
			<div class="progress-bar-inside"></div>
			<p class="timer-seconds">60</p>
			<input type="file" class="songUpload" multiple="multiple" />
		</div>

		<div class="club-number">Club #<span>0</span></div>
		<div class="current-song">Introsang</div>
	</div>
</body>
</html>