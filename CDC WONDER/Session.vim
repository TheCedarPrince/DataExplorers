let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
let UltiSnipsRemoveSelectModeMappings =  1 
let EasyMotion_enter_jump_first =  0 
let VM_default_mappings =  1 
let EasyMotion_move_highlight =  1 
let VM_mouse_mappings =  0 
let NERDUsePlaceHolders = "1"
let WebDevIconsUnicodeDecorateFolderNodesExactMatches =  1 
let UltiSnipsJumpForwardTrigger = "<c-j>"
let EasyMotion_use_migemo =  0 
let EasyMotion_smartcase =  0 
let EasyMotion_off_screen_search =  1 
let DevIconsEnableFoldersOpenClose =  0 
let EasyMotion_use_upper =  0 
let EasyMotion_do_mapping =  1 
let WebDevIconsNerdTreeAfterGlyphPadding = " "
let DevIconsEnableFolderExtensionPatternMatching =  0 
let WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ""
let NERDMenuMode = "3"
let Taboo_tabs = ""
let WebDevIconsNerdTreeGitPluginForceVAlign =  1 
let WebDevIconsUnicodeDecorateFileNodes =  1 
let NERDCommentEmptyLines = "0"
let VM_highlight_matches = "underline"
let EasyMotion_disable_two_key_combo =  0 
let EasyMotion_force_csapprox =  0 
let EasyMotion_space_jump_first =  0 
let EasyMotion_prompt = "Search for {n} character(s): "
let NERDCommentWholeLinesInVMode = "0"
let EasyMotion_use_regexp =  1 
let JuliaFormatter_sysimage_path = "/home/cedarprince/.vim/addons/JuliaFormatter.vim/scripts/juliaformatter.so"
let NERDTreeUpdateOnCursorHold =  1 
let VM_persistent_registers =  0 
let WebDevIconsTabAirLineAfterGlyphPadding = ""
let NERDDefaultNesting = "1"
let DevIconsArtifactFixChar = " "
let DevIconsEnableDistro =  1 
let EasyMotion_show_prompt =  1 
let EasyMotion_add_search_history =  1 
let EasyMotion_do_shade =  1 
let UltiSnipsExpandTrigger = "<tab>"
let EasyMotion_grouping =  1 
let JuliaFormatter_log = "/home/cedarprince/.vim/addons/JuliaFormatter.vim/scripts/juliaformatter.log"
let WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ""
let WebDevIconsUnicodeDecorateFolderNodes =  1 
let NERDToggleCheckAllLines = "0"
let JuliaFormatter_root = "/home/cedarprince/.vim/addons/JuliaFormatter.vim"
let NERDTreeGitStatusUpdateOnCursorHold =  1 
let NERDSpaceDelims = "0"
let WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = ""
let NERDLPlace = "[>"
let DevIconsAppendArtifactFix =  0 
let NERDDefaultAlign = "none"
let NERDCreateDefaultMappings = "1"
let WebDevIconsNerdTreeBeforeGlyphPadding = " "
let EasyMotion_verbose =  1 
let WebDevIconsUnicodeGlyphDoubleWidth =  1 
let WebDevIconsUnicodeDecorateFolderNodesSymlinkSymbol = ""
let UltiSnipsJumpBackwardTrigger = "<c-k>"
let JuliaFormatter_loaded =  1 
let NERDRPlace = "<]"
let NERDRemoveExtraSpaces = "0"
let EasyMotion_cursor_highlight =  1 
let UltiSnipsEnableSnipMate =  1 
let UltiSnipsListSnippets = "<c-tab>"
let NERDRemoveAltComs = "1"
let EasyMotion_skipfoldedline =  1 
let NERDTrimTrailingWhitespace = "0"
let NERDBlockComIgnoreEmpty = "0"
let EasyMotion_startofline =  1 
let NERDDisableTabsInBlockComm = "0"
let VM_check_mappings =  1 
let EasyMotion_inc_highlight =  1 
let UltiSnipsEditSplit = "normal"
let DevIconsDefaultFolderOpenSymbol = ""
let NERDCompactSexyComs = "0"
let EasyMotion_keys = "asdghklqwertyuiopzxcvbnmfj;"
let NERDAllowAnyVisualDelims = "1"
let EasyMotion_loaded =  1 
let WebDevIconsTabAirLineBeforeGlyphPadding = " "
let DevIconsEnableFolderPatternMatching =  1 
let EasyMotion_landing_highlight =  0 
silent only
cd /home/src/Projects/DataExplorers/CDC\ WONDER
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 _research/exploration.jmd
argglobal
%argdel
$argadd _research/exploration.jmd
edit _research/exploration.jmd
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 35 - ((8 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
35
normal! 0
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOF
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
