vim9script

def SyncIndentStyle(): list<any> # [use_tabs: bool, tabstop: number]
	if !!&l:buftype | return [] | endif
	const max_line = min([line('$'), 256])
	var line_index = 0
	var indent = ''
	while !indent && line_index <= max_line
		line_index += 1
		const line = getline(line_index)
		indent = matchstr(line, '.*\S\&^(  \|\t)\+')
	endwhile
	const use_tabs = indent[0] != ' '
	const tabstop = use_tabs ? &g:tabstop : strlen(indent)
	&l:expandtab = !use_tabs
	&l:tabstop = tabstop
	return [use_tabs, tabstop]
enddef

def FixWhitespace(): void
	const settings = SyncIndentStyle()
	if !settings | return | endif
	const [use_tabs, tabstop] = settings
	const space_indent = repeat(' ', tabstop)
	const indent = use_tabs ? '\t' : space_indent
	const view = winsaveview()
	silent execute ':%s/\s\+$//e'
	silent execute ':%s/'
		.. '\(\t\|' .. space_indent .. '\)'
		.. '\(^\s*\)\@<='
		.. '/' .. indent .. '/ge'
	if use_tabs
		silent execute ':%s/ \(^\s*\)\@<=\(\s\)\@=//ge'
	endif
	winrestview(view)
enddef

silent! autocmd_delete([{ group: 'VimWhitespaceControl' }])
autocmd_add([{
	group: 'VimWhitespaceControl',
	event: 'BufRead',
	pattern: '*',
	cmd: 'SyncIndentStyle()',
}, {
	group: 'VimWhitespaceControl',
	event: 'BufWrite',
	pattern: '*',
	cmd: 'FixWhitespace()',
}])
