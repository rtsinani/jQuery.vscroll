class VScroll
	constructor: (el, options) ->
		@_jcontainer		= $(el).scrollTop(0)
		@_options 			= options or {}
		@_create()
		
	_styles:
		scroll				: 'vscroll_scroll'
		scrollWrap		: 'vscroll_scroll_wrap'
		
	_create: ->	
		@_createHtml()
		@_size()
		$.extend @_options, 
			orientation		: 'vertical'
			min						: 0
			max						: @_scrollHeight
			value					: @_scrollHeight
			slide					: (e, ui) => @_sliding(e, ui)
		@_jscroll.slider(@_options)
		
	_createHtml: ->	
		@_jscrollWrap		= $('<div></div>')
		@_jscroll 			= $('<div></div>')
		@_jscrollWrap.addClass 	@_styles.scrollWrap
		@_jscroll.addClass			@_styles.scroll
		@_jscroll.appendTo @_jscrollWrap
		@_jscrollWrap.appendTo('body')
		position = @_jcontainer.offset()
		@_jscrollWrap.css
			top			: position.top
			left		: @_jcontainer.width() + position.left - 10
		@_jscrollWrap.show()
		
	_sliding: (e, ui) ->
		@_jcontainer.scrollTop @_scrollHeight - ui.value
		
	_size: ->
		@_scrollHeight = @_jcontainer.height() - 18 unless @_hscrollHeight?
		@_jscrollWrap.height @_scrollHeight + 18
		@_jscroll.height(@_scrollHeight)
		
		
$.fn.vscroll = (options) ->
	new VScroll(@, options)
		
		