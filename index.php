<?php
	include("lib.php");

	// get list of files
	$commands = readFolder("commands");	
	$songs = readFolder("songs");
?>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" href="stylesheets/screen.css">
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="screen.js"></script>
	<script type="text/javascript">

		$(document).ready(function() {
			startCountDown(<?php echo $songs ?>, <?php echo $commands ?>);
			pissList.init();

		});	
	</script>
</head>
<body class="bp">
	<div class="container">

		<h1 class="title">Club 101</h1>
		<p class="sub-title">En club sejere</p>

		<div class="progress-bar">
			<div class="progress-bar-inside"></div>
			<p class="timer-seconds">53</p>
		</div>

		<div class="club-number">Club #<span>0</span></div>
		<div class="current-song">Introsang</div>

	</div>
</body>
</html>