#!C:/Strawberry/perl/bin/perl.exe
use strict;
use warnings;
use feature qw(say);
use CGI;
my $cgi=new CGI;

my $about_aspring='ASpring은 C,C++,MFC,Perl 언어를 사용할때 가시성을 보다 좋게 하기 위한 주석을 자동으로 생성해 줍니다. 지원 언어 추가나 사이트에 대한 문의는 springnode@gmail.com 으로 메일 주시면 됩니다. 프로그래밍은 즐거운것 입니다!';
my $highlight_header='
<!--highlight-->
<link rel="stylesheet" href="3rdparty/highlight/styles/solarized-light.css">
<script src="3rdparty/highlight/highlight.pack.js"></script>
<script>hljs.initHighlightingOnLoad();</script>
';

my $joker_header='
<!-- Bootstrap core CSS -->
<link href="3rdparty/joker/css/bootstrap.min.css" rel="stylesheet">
<!-- Add custom CSS here -->
<link href="3rdparty/joker/css/style.css" rel="stylesheet">
<link href="3rdparty/joker/css/ekko-lightbox.css" rel="stylesheet">
<link href="3rdparty/joker/css/flexslider.css" rel="stylesheet">
<link href="3rdparty/joker/css/animate.min.css" rel="stylesheet">
<link href="3rdparty/joker/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="3rdparty/joker/css/bootstrap-theme.min.css" rel="stylesheet">
<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
';
my $joker_footer='
<script src="3rdparty/joker/js/jquery-1.10.2.js"></script>
<script src="3rdparty/joker/js/bootstrap.js"></script>
<script src="3rdparty/joker/js/jquery.sticky.js" ></script>
<script src="3rdparty/joker/js/jquery.nav.js"></script>
<script src="3rdparty/joker/js/jquery.scrollTo.js" ></script>
<script src="3rdparty/joker/js/jquery.flexslider.js" ></script>
<script type="text/javascript" src="3rdparty/joker/js/ekko-lightbox.js"></script>
<script src="3rdparty/joker/js/jquery.easing.1.3.js" ></script>
<script src="3rdparty/joker/js/jquery.shuffle.js" ></script>
<script src="3rdparty/joker/js/script.js"></script>
';
my $flatui_header='
<!--Flat UI Free-->
<link href="3rdparty/Flat-UI/dist/css/flat-ui.css" rel="stylesheet">
<!-- Loading Bootstrap -->
<link href="3rdparty/Flat-UI/dist/css/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
';
my $flatui_footer='
<script src="3rdparty/Flat-UI/dist/js/vendor/jquery.min.js"></script>
<script src="3rdparty/Flat-UI/dist/js/vendor/video.js"></script>
<script src="3rdparty/Flat-UI/dist/js/flat-ui.min.js"></script>
<script src="3rdparty/Flat-UI/docs/assets/js/application.js"></script>
';
my $clipboard_header='
<script src="3rdparty/clipboard/dist/clipboard.min.js"></script>
';
my $jquery='
<script src="3rdparty/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(":radio").radiocheck();
		$("#rd_c").click(function(){
                        $("#g_language").val($("#rd_c").val());
                        $("#cppviewer").css("display","block");
                        $("#hppviewer").css("display","block");
                        $("#perlviewer").css("display","none");
			$("#copyclp_hpp").css("display","block");
			$("#copyclp_cpp").css("display","block");
			$("#copyclp_perl").css("display","none");
                        update_code();
                });
		$("#rd_cpp").click(function(){
			$("#g_language").val($("#rd_cpp").val());
			$("#cppviewer").css("display","block");
			$("#hppviewer").css("display","block");
			$("#perlviewer").css("display","none");
			$("#copyclp_hpp").css("display","block");
			$("#copyclp_cpp").css("display","block");
			$("#copyclp_perl").css("display","none");
			update_code();
		});
		$("#rd_mfc").click(function(){
                        $("#g_language").val($("#rd_mfc").val());
			$("#cppviewer").css("display","block");
                        $("#hppviewer").css("display","block");
                        $("#perlviewer").css("display","none");
			$("#copyclp_hpp").css("display","block");
			$("#copyclp_cpp").css("display","block");
			$("#copyclp_perl").css("display","none");
			update_code();
                });
		$("#rd_perl").click(function(){
                        $("#g_language").val($("#rd_perl").val());
			$("#cppviewer").css("display","none");
			$("#hppviewer").css("display","none");
			$("#perlviewer").css("display","block");
			$("#copyclp_hpp").css("display","none");
			$("#copyclp_cpp").css("display","none");
			$("#copyclp_perl").css("display","block");
			update_code();
                });
		var update_code=function(){
			var language=$("#g_language").val();
                        var file=$("#ed_file").val();
                        var project=$("#ed_project").val();
                        var owner=$("#ed_owner").val();
                        var group=$("#ed_group").val();
                        $.ajax({
                                url:\'generate.pl\',
                                data:{
                                        "language":language
                                        ,"file":file
                                        ,"project":project
                                        ,"owner":owner
                                        ,"group":group
					,"type":"implement"
                                },
                                success : function(r){
					if(language == "cpp" || language == "mfc" || language == "c"){
                                        	$("#codeviewer_cpp").html(r);
					}
					if(language == "perl"){
						$("#codeviewer_perl").html(r);
					}
                                        $("pre code").each(function(i, e) {hljs.highlightBlock(e)});
                                },
                                error:function(a,b,c){
                                        alert("Ajax failed:"+c);
                                }
                        });
			if(language == "cpp" || language == "mfc" || language == "c"){
				$.ajax({
                                	url:\'generate.pl\',
                                	data:{
                                       		"language":language
	                                        ,"file":file
        	                                ,"project":project
                	                        ,"owner":owner
                        	                ,"group":group
                                	        ,"type":"header"
                                	},
	                                success : function(r){
        	                                $("#codeviewer_hpp").html(r);
                                	        $("pre code").each(function(i, e) {hljs.highlightBlock(e)});
                        	        },
                               	 	error:function(a,b,c){
                                        	alert("Ajax failed:"+c);
                                	}
                        	});
			}
		}
		$("#ed_file").keyup(update_code);
		$("#ed_project").keyup(update_code);
		$("#ed_owner").keyup(update_code);
		$("#ed_group").keyup(update_code);
		$("#vertical-slider").slider({
			change: function(event,ui){
				$("pre").css("font-size",ui.value);
			}
		});
		$("#vertical-slider").slider({
                  	min: 10
                });
		$("#vertical-slider").slider({
	                max: 30
	        });
		$("#vertical-slider").slider({
			value: 20
		});
		update_code();
		var clipboard=new Clipboard(\'.copy-button\');
	});

</script>
';



#http://designmodo.github.io/Flat-UI/docs/components.html
print $cgi->header(-charset=>"UTF-8");
print <<EOF
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>ASpring</title>
    $flatui_header
    $clipboard_header
    $highlight_header
    $joker_header
    $jquery
  </head>

  <body>
    <input id="g_language" type="hidden" value="cpp"/>

    <div id="boxWrapp">
      <!-- Full Page Image Header Area -->
      <div id="about" class="header">
        <div class="maskHeader"></div>
        <div class="main-caption">
        <div class="logo">
          <img src="3rdparty/joker/img/BLOGO-white.png" alt="logo" />
        </div>
        <div id="flex-head" class="_flexslider">
          <ul class="slides">
            <li>
              <h1>ASpring</h1>
              <h2>template generator</h2>
            </li>
          </ul>
        </div>

        <a href="#aboutMore" class="btn btnAbout btn-clear border-color color-primary btn-lg linear">Go</a>
      </div>
    </div>

    <!-- /Full Page Image Header Area -->


    <!-- content -->
    <div id="aboutMore" class="page">
      <div class="container">
        <div class="row">
          <div class="col-md-10  col-md-offset-1">
            <div class="build title-page">
              <h2 class="text-center">About ASpring</h2>
              <div class="line-title bg-primary"></div>
           </div>
          </div><!-- end col -->
       </div><!-- end row -->

       <div class="row">
         <div class="col-md-12">
	   <div class="build main-about">
	     <div class="row">
	       <div class="col-md-3">
	         <div class="main-avatar text-center">
	           <div class="avatar img-thumbnail img-circle">
	             <img src="3rdparty/joker/img/_kimbom2013.png" alt="avatar" />
	           </div>
	         </div>
	       </div>
	       <div class="col-md-9">
	        <div class="about-content">
                 <p>$about_aspring</p>
						<a href="https://github.com/springkim/ASpring" class="btn btn-clear btn-lg border-color linear hire" >Github</a>
					</div>
				       </div>
				   </div>


				</div>
            </div><!-- end col -->





        </div><!-- end row -->
      </div>
      </div>

    <!-- /Intro -->

    <!-- Portfolio -->
    <div id="work" class="page clearfix">
      <div class="container">
       <div class="row">
         <div class="col-md-10  col-md-offset-1">
           <div class="build title-page">
             <h2 class="text-center">Programming language comment generator</h2>
               <div class="line-title bg-primary"></div>
           </div>
         </div>
       </div>
       <div class="col-md-12">
         <div class="folio-content clearfix">
           <div class="row">
             <div class="col-md-6">
               <input type="text" placeholder="File name" class="form-control" id="ed_file" maxlength="64"/>
               <input type="text" placeholder="Project name" class="form-control" id="ed_project" maxlength="64"/>
               <input type="text" placeholder="Owner name" class="form-control" id="ed_owner" maxlength="64"/>
               <input type="text" placeholder="Group name" class="form-control" id="ed_group" maxlength="64"/>
            </div>
            <div class="col-md-4">
             <label class="radio">
                <input type="radio" name="rd_language" id="rd_c" value="c" data-toggle="radio">
                  C
              </label>
	     <label class="radio">
                <input type="radio" name="rd_language" id="rd_cpp" value="cpp" data-toggle="radio" checked="">
                  C++
              </label>
              <label class="radio">
                <input type="radio" name="rd_language" id="rd_mfc" value="mfc" data-toggle="radio">
                  MFC
              </label>
              <label class="radio">
                <input type="radio" name="rd_language" id="rd_perl" value="perl" data-toggle="radio">
                  Perl
              </label>

           </div>
		<div class="col-md-1">

		<div id="vertical-slider" style="height: 150px;"></div>
	   </div>
         </div>
	<button class="btn btn-hg btn-primary copy-button" id="copyclp_hpp" data-clipboard-action="copy" data-clipboard-target="#hppviewer">
	   Copy C/C++ header to clipboard
	</button>
         <pre id="hppviewer" style="border:0px;padding:0px;background-color:transparent;font-size:20px;text-align:left">
           <code class="cpp" id="codeviewer_hpp">

           </code>
         </pre>



	<button class="btn btn-hg btn-primary copy-button" id="copyclp_cpp" data-clipboard-action="copy" data-clipboard-target="#cppviewer">
	  Copy C/C++ code to clipboard
	</button>
	<pre id="cppviewer" style="border:0px;padding:0px;background-color:transparent;font-size:20px;text-align:left">
           <code class="cpp" id="codeviewer_cpp">

           </code>
         </pre>




	<button class="btn btn-hg btn-primary copy-button" id="copyclp_perl" style="display:none" data-clipboard-action="copy" data-clipboard-target="#perlviewer">
	   Copy script to clipboard
	</button>
	<pre id="perlviewer" style="display:none;border:0px;padding:0px;background-color:transparent;font-size:20px;text-align:left">
           <code class="perl" id="codeviewer_perl">

           </code>
         </pre>

       </div>
     </div>
   </div>
 </div>
</div>


    <!-- Footer ########################################################################################################################################### -->
    <footer class="bg-black">
      <div class="container">
        <div class="row">
			<div class="col-md-6 ">
				<div class="cp-right">
					<p>&copy; 2017 <a href="http://kimbom.co.kr" class="color-primary linear">kimbom</a>. All Rights Reserved. springnode&#64gmail.com</p>

				</div><!-- end build -->
			</div><!-- end col -->

			<div class="col-md-6 text-right">
			<ul class="list-inline">
			<li><a href="https://github.com/springkim" class="socIcon color-primary linear"><i class="fa fa-github fa-2x"></i></a></li>
			<li><a href="http://cviplab.sogang.ac.kr/" class="socIcon color-primary linear"><i class="fa fa-info-circle fa-2x"></i></a></li>
			<li><a href="http://kimbom.co.kr" class="socIcon color-primary linear"><i class="fa fa-archive fa-2x"></i></a></li>
			</ul>

			</div>
        </div>
      </div>
    </footer>
    <!-- /Footer -->

    <!-- JavaScript -->
    $joker_footer
    $flatui_footer
  </div>
  </body>

</html>
EOF
;
