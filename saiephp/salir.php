<?php
	$_SESSION['MM_Username'] = NULL;
	$_SESSION['PrevUrl'] = NULL;
	unset($_SESSION['MM_Username']);
	unset($_SESSION['PrevUrl']);

	session_start();
	session_unset();
	session_destroy();

	$logoutGoTo = "index.php";
	if ($logoutGoTo) {
		header("Location: $logoutGoTo");
		exit;
	}
?>