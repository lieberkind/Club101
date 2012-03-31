<?php
function readFolder($type){
	if($type == "commands"){
		$files = scandir("commands/");
	}else{
		$files = scandir("songs/");
	}
	$key_parent_dir = array_search("..", $files);
	$key_current_dir = array_search(".", $files);		
	unset($files[$key_current_dir]);
	unset($files[$key_parent_dir]);		
	shuffle($files);
	
	return json_encode($files);
}
?>