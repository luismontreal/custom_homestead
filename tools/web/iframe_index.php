<?php
$installed_sites_file = '/home/vagrant/.vagrant/install_sites';
$installed_sites = array();
if (file_exists($installed_sites_file)) {
	$installed_sites = file($installed_sites_file);
} 

?>
<html>
<head>

	<title>Small Tubes</title>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script> 
	
</head>
<body>

<div class="container">
	  <div class="jumbotron" style="position: relative">
		<div style="clear:both" class="alert alert-success" role="alert">
			Your server is currently running.
		</div>
		
		<?php if (count($installed_sites) == 0) { ?>
		<div class="alert alert-warning" role="alert">
			You currently have no sites installed.
		</div>
	  <?php } ?>
	  <ul>
	  <?php
	  foreach ($installed_sites as $site) {
	    $site = trim($site);
		echo '<li><a href="http://' . $site . ' " target="_blank">http://' . $site .'</a></li>';
	  }
	  ?>
	  </ul>
	  
	  </div>	  
</div>

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

</body>
</html>
