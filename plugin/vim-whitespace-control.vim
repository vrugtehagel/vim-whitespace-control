vim9script

def AutoSettings(): void
	if !!&l:buftype | return | endif
	const max_line = min([line('$'), 256])
	var line_index = 0
	var indent = ''
	while !indent && line_index <= max_line
		line_index += 1
		const line = getline(line_index)
		indent = matchstr(line, '.*\S\&^\s\+')
	endwhile
	const use_tabs = indent[0] != ' '
	&l:expandtab = !use_tabs
	&l:tabstop = use_tabs ? &g:tabstop : strlen(indent)
enddef

def FixWhitespace(): void
	if !!&l:buftype | return | endif
	const view = winsaveview()
	silent execute ':%s/\s\+$//e'
	edit! %:p
	winrestview(view)
enddef

silent! autocmd_delete([{ group: 'VimWhitespaceControl' }])
autocmd_add([{
	group: 'VimWhitespaceControl',
	event: ['BufWritePost', 'BufRead'],
	pattern: '*',
	cmd: 'AutoSettings()',
}, {
	group: 'VimWhitespaceControl',
	event: ['BufWritePost'],
	pattern: '*',
	cmd: 'FixWhitespace()',
}])
