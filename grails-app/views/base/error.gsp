<!DOCTYPE html>
<html lang="en">
<head>
<title>SICA WEB - Erro</title>
<meta name="layout" content="main" />
<link rel="stylesheet" href="${resource(dir:'css',file:'unicorn.main.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'unicorn.login.css')}" />


<script type="text/javascript">
$(document).ready(function(){
    $("#btn-back").click(function(){

		history.back();

        });
});
</script>

</head>
<body>
<div class="container-fluid">
<div class="row-fluid">
	<div class="widget-box">
		<div class="widget-title">
			<span class="icon"> <i class="icon-exclamation-sign"></i>
			</span>
			<h5>Notifica&ccedil;&otilde;es</h5>
		</div>
		<div class="widget-content">

			<div class="alert alert-error alert-block">
				<h4 class="alert-heading">Erro!</h4>
				${flash.message}
			</div>
			<button class="btn btn-inverse" id="btn-back"><i class="icon-chevron-left icon-white"></i> Voltar</button>
		</div>
	</div>
	</div>
</div>
</body>
</html>
