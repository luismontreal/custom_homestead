<?php
set_time_limit(0);


?>
<html>
<head>

	<title>Small Tubes</title>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">

	<style>
		body {
		  padding-top: 40px;
		  padding-bottom: 40px;
		  
		}

		.form-signin {
		  max-width: 330px;
		  padding: 15px;
		  margin: 0 auto;
		}
		.form-signin .form-signin-heading,
		.form-signin .checkbox {
		  margin-bottom: 10px;
		}
		.form-signin .checkbox {
		  font-weight: normal;
		}
		.form-signin .form-control {
		  position: relative;
		  height: auto;
		  -webkit-box-sizing: border-box;
			 -moz-box-sizing: border-box;
				  box-sizing: border-box;
		  padding: 10px;
		  font-size: 16px;
		}
		.form-signin .form-control:focus {
		  z-index: 2;
		}
		.form-signin input[type="email"] {
		  margin-bottom: -1px;
		  border-bottom-right-radius: 0;
		  border-bottom-left-radius: 0;
		}
		.form-signin input[type="password"] {
		  margin-bottom: 10px;
		  border-top-left-radius: 0;
		  border-top-right-radius: 0;
		}
	</style>
	
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script> 
	
</head>
<body>
<div class="container">
<h1>Test Connections</h1>

<?php
if ($_SERVER['REQUEST_METHOD'] != 'POST') { 
	
	?>
	
	<form class="form-signin" method="POST">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="inputUsername" class="sr-only">Username</label>
        <input name="username" type="text" id="inputUsername" class="form-control" placeholder="Username" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input name="password" type="password" id="inputPassword" class="form-control" placeholder="Password" required>
        
        <button class="btn btn-lg btn-primary btn-block" type="submit">Test</button>
      </form>
	<?php 
	exit();
} ?>
<?php
$username = $_POST['username'];
$password = $_POST['password'];

if (empty($username) || empty($password)) {
	echo 'You must enter a your ldap login and password to proceed.';
	exit();
}

$errors = array();
$hosts_to_ping = array(
	'google.com',
	'phallus.na.manwin.local',
);
$i = 0;
foreach ($hosts_to_ping as $host) {
	
	exec('ping -c 5 ' . $host . ' 2>&1', $out, $return);

	$dns = dns_get_record($host, DNS_A);
	if (is_array($dns)) {
		$dns = current($dns);
	}
	echo '<h6>';
	if ($return > 0 ) {
		$error_string = '';
		foreach ($out as $o) {
			$error_string .= $o . '<br />';
		}
		$errors['ping'][] = "Error sending ping to: " . $host . " <br />" . $error_string;
		echo '<span class="label label-danger">Error</span><span> Sending ping to : ' . $host . '</span>';
		
	} else {
		if (!empty($out[8])) {
			preg_match('/(\d) packets transmitted, (\d) received,.*([0-9]+)% packet loss, time ([0-9]+)ms/', $out[8], $matches);
		}
		echo '<span class="label label-success">Success</span><span> Host: ' . $host . ' (' . $dns['ip'] . ') ';
		if (!empty($matches[4])) {
			echo $matches[4] .' ms response time';
		}
		echo '</span>';

	}
	echo '</h6>';
	unset($out);
}

$svn_repos_to_check = array(
	'svnoutside.mgcorp.co/keezmovies/',
	'svn.tubes.mgcorp.co/keezmovies/',
	'svn.tubes.mgcorp.co/mofosex.com/',
	'svn.tubes.mgcorp.co/PornMD/',
	'svn.tubes.mgcorp.co/extremetube.com/',
	'svn.tubes.mgcorp.co/services/',
);

foreach ($svn_repos_to_check as $host) {
	$cmd = '/usr/bin/svn info --username ' . $username . ' --password ' . $password . ' --non-interactive http://' . $host . ' 2>&1';
	
	exec($cmd, $out, $return);
	//var_dump($cmd, $return, $out);
	

	if ($return > 0 ) {
		$error_string = '';
		if (!empty($out[1])) {
			preg_match("/URL: (.*)/", $out[1], $matches);
		}

		foreach ($out as $o) {
			$error_string .= $o . '<br />';
		}
		
		$errors['svn'][] = "SVN error: " . $host . "<br />" . $error_string;
		echo '<h6><span class="label label-danger">Error</span><span> SVN : ' . $host . '</span></h6>';
		if (count($errors['svn']) > 2) {
		echo '<h6><span class="label label-danger">Error</span><span> SVN : 2 failures, skipping remaining tests.</span></h6>';
			break;
		}
	} else {
		echo '<h6><span class="label label-success">Success</span><span> SVN : ' . $host . '</span></h6>';
	}
	unset($out);
}

// git http://git.tubes-platform.na.manwin.local/curlbundle.git/

$mysql_connect = @mysqli_connect('phallus.na.manwin.local', 'extremetube', 'extremetube', 'extremetube');
if ($mysql_connect == false) {
	$errors['mysql'][] = "Error connecting to mysql: phallus.na.manwin.local";
	echo '<h6><span class="label label-danger">Error</span><span> Mysql : phallus.na.manwin.local</span></h6>';
} 

if (count($errors) > 0) {
	echo "<h2>Errors Detected</h2>";
	echo '<div class="alert alert-danger" role="alert">';
	echo '<strong>Errors Detected!</strong> ';
	foreach ($errors as $service => $service_errors) {
		foreach ($service_errors as $error) {
			echo "<p >$error</p>";
		}
	}
	echo '</div>';
} else {
	echo '<div class="alert alert-success" role="alert">
        <strong>Success!</strong> Everything seems to be working.
      </div>';
}


?>
</div>
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

</body>
</html>