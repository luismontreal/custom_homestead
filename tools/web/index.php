<html>
<head>

	<title>Local Dev</title>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script> 
	
</head>
<body>
<nav class="navbar navbar-inverse " >
  <div class="container ">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/">Local Dev</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <!-- <li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li> -->
        <li><a href="/php.php" target="iframe_a">PHP Info</a></li>
        <li><a href="/apcu.php" target="iframe_a">APCU</a></li>
        
<!--
        <li><a href="#">Link</a></li>
		
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dropdown <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            
			<li class="divider"></li>
            <li><a href="#">Separated link</a></li>
            <li class="divider"></li>
            <li><a href="#">One more separated link</a></li>
			
          </ul>
        </li>
-->		
		<li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">RedisAdmin <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
			<li><a href="/phpRedisAdmin/?overview&s=0" target="_blank">Extremetube</a></li>
			<li class="divider"></li>
			<li><a href="/phpRedisAdmin/?overview" target="_blank">Overview</a></li>			
          </ul>
        </li>
		
		<li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">phpMemcachedAdmin <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
			<li><a href="/phpMemcachedAdmin/index.php?server=127.0.0.1:11211" target="iframe_a">Extremetube</a></li>
          </ul>
        </li>

		<li><a href="/phpMyAdmin/" target="_blank">PHPMyAdmin</a></li>
		<li><a href="/readme.html" target="iframe_a">README</a></li>
		
      </ul>
 
      <ul class="nav navbar-nav navbar-right">
        <li><a href="/debug.php" target="iframe_a">Test Connections</a></li>
      </ul>
	  
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<div class="container">
	  
	  <iframe src="iframe_index.php" name="iframe_a" style="width: 100%; height: 1000px" frameborder="0">
	  </iframe>
</div>


<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

</body>
</html>
