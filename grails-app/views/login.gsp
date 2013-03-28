<!DOCTYPE html>
<html lang="en">
<head>
<title>SICA WEB - Login</title>
<link rel="stylesheet" href="${resource(dir:'css',file:'unicorn.login.css')}" />
<meta name="layout" content="main" />
<g:javascript library="jquery.validate" />

<script type="text/javascript">
$(document).ready(function(){
    $("#loginform").validate({
        rules:{
            login:"required",
            password:"required"
        },
        messages:{
            login:"Usu&aacute;rio inv&aacute;lido.",
            password:"Senha inv&aacute;lida."
        },
        errorClass: "help-inline",
		highlight:function(element, errorClass, validClass) {
			$(element).parents('.control-group').addClass('error');
			$(element).parents('.control-group')
		},
		unhighlight: function(element, errorClass, validClass) {
			$(element).parents('.control-group').removeClass('error');
			$(element).parents('.control-group').addClass('success');
		}
    });
});
</script>

</head>
<body>
	<div id="logo">
            <img src="/SISAT/images/logosisat.png" alt="">
        </div>
	<div id="loginbox">
	<g:form name="loginform" action="handleLogin" controller="base" class="form-vertical" >
			<p>Digite o login e a senha.</p>
			<div class="control-group">
				<div class="controls">
					<div class="input-prepend">
						<span class="add-on"><i class="icon-user"></i></span><input type="text" name="login" id="login" placeholder="Usu&aacute;rio" />
					</div>
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<div class="input-prepend">
						<span class="add-on"><i class="icon-lock"></i></span><input type="password" name="password" id="password" placeholder="Senha" />
					</div>
				</div>
			</div>
			<div class="form-actions">
				<span class="pull-right"><input type="submit" class="btn btn-inverse" value="Login" /></span>
			</div>
	</g:form>

	</div>


</body>
</html>
