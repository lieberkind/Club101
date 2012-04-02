<?php
function readFolder($folder){
	$files = scandir($folder ."/");

	// remove ".." and "."
	$key_parent_dir = array_search("..", $files);
	$key_current_dir = array_search(".", $files);		
	unset($files[$key_current_dir]);
	unset($files[$key_parent_dir]);

	// add folder names in front:
	foreach ($files as $i => $file) { 

	    $files[$i] = $folder . "/" . $file; 
	}	

	// randomixe
	shuffle($files);
	
	// output in json
	return json_encode($files);
}
?>