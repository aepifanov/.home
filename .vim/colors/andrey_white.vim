" Vim color file
" Maintainer:   Andrey Epifanov
" Last Change:  2010 Oct 4

" First remove all existing highlighting.

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "andrey_white"

hi Normal       ctermbg=Black       ctermfg=Black
hi NonText                          ctermfg=Black
hi ErrorMsg     ctermbg=Red         ctermfg=White
hi Visual       ctermbg=Black       
hi Cursor       ctermbg=Black       ctermfg=Black
hi Directory                        ctermfg=Blue     
hi LineNr                           ctermfg=Black
hi MoreMsg                          ctermfg=Red
hi Question                         ctermfg=Green    
hi Search       ctermbg=Blue        ctermfg=White
hi SpecialKey                       ctermfg=DarkBlue     
hi Title                            ctermfg=Magenta  
hi WarningMsg                       ctermfg=Red      
hi WildMenu                         ctermfg=Black         
hi Folded                           ctermfg=Blue      
hi FoldColumn                       ctermfg=DarkBlue      
hi DiffAdd      ctermbg=Green                                         
hi DiffChange   ctermbg=Yellow                                        
hi DiffDelete   ctermbg=Red         ctermfg=White 
hi DiffText     ctermbg=Red         
hi MatchParen   ctermbg=Red         ctermfg=White
hi IncSearch    ctermbg=Red         ctermfg=White
hi CLibFunc                         ctermfg=Blue
hi CLibFuncFail                     ctermfg=Red
hi Constant                         ctermfg=DarkGreen       
hi Special                          ctermfg=Red
hi Statement                        ctermfg=Blue
hi String                           ctermfg=Magenta
hi Comment                          ctermfg=DarkGrey
hi Identifier                       ctermfg=Blue
hi Include                          ctermfg=DarkGreen
hi PreProc                          ctermfg=DarkGreen
hi Operator                         ctermfg=Blue
hi Define                           ctermfg=DarkGreen
hi Type                             ctermfg=DarkCyan
hi Structure                        ctermfg=DarkGreen
hi Todo         ctermbg=Red         ctermfg=White
hi Label                            ctermfg=DarkMagenta
