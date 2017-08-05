#!/usr/bin/perl
use strict;
use warnings;
use feature qw(say);
use CGI;
my $cgi=new CGI;



#http://designmodo.github.io/Flat-UI/docs/components.html
print $cgi->header(-charset=>"UTF-8");
print <<EOF
<html>
	<head>
		<title>ASpring</title>
		<!--prism-->
		<link href="3rdparty/prism/prism.css" rel="stylesheet" />
	 <!-- Loading Bootstrap -->
    <link href="3rdparty/Flat-UI/dist/css/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<!--Flat UI Free-->
		<link href="3rdparty/Flat-UI/dist/css/flat-ui.css" rel="stylesheet">
	</head>
	<body>
		<p class="navbar-text">Signed in as Mark Otto</p>
		<div class="input-group">
			<span class="input-group-addon">name</span>
			<input type="text" class="form-control" placeholder="kimbom" />
		</div>
		<div class="input-group">
			<input type="text" class="form-control" placeholder="Append" />
			<span class="input-group-addon">@</span>
		</div>
<label class="checkbox" for="checkbox1">
            <input type="checkbox" value="" id="checkbox1" data-toggle="checkbox">
            Unchecked
          </label>
          <label class="checkbox" for="checkbox2">
            <input type="checkbox" checked="checked" value="" id="checkbox2" data-toggle="checkbox" checked="">
            Checked
          </label>
          <label class="checkbox" for="checkbox3">
            <input type="checkbox" value="" id="checkbox3" data-toggle="checkbox" disabled="">
            Disabled unchecked
          </label>


		<pre>
			<code class="language-cpp">
				#include&ltiostream&gt
				int main(){
					std::cout &lt&lt "hello, world" &lt&lt std::endl;
					return 0;
				}
			</code>
		</pre>

		<script src="3rdparty/prism/prism.js"></script>
		<script src="3rdparty/Flat-UI/dist/js/vendor/jquery.min.js"></script>
    <script src="3rdparty/Flat-UI/dist/js/vendor/video.js"></script>
    <script src="3rdparty/Flat-UI/dist/js/flat-ui.min.js"></script>
    <script src="3rdparty/Flat-UI/docs/assets/js/application.js"></script>
	</body>
</html>
EOF
;
