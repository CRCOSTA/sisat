 $(document).ready(function() {
		
		// Reverse it for hide:
		$('[data-toggle=collapse]').on('click', function() {
			var $this=$(this), icon = $this.children()[0],
			target = target = $this.attr('data-target')
	        || (href = $this.attr('href')) && href.replace(/.*(?=#[^\s]+$)/, ''); //strip for ie7
			if($(target).hasClass('in')){
				$(icon).removeClass('icon-minus').addClass('icon-plus');
					
			}else{  
				$(icon).removeClass('icon-plus').addClass('icon-minus');
			}
		});
 });
 