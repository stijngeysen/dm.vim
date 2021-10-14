" Vim syntax file
" Language:     DM datamodel Grammar File
" Author:       Stijn Geysen <stijn.geysen@luminex.be>
" Date:         Oktober 15, 2021
" File Types:   dm
" Version:      1
" Notes:
"

" Setup
if version >= 600
  if exists("b:current_syntax")
    finish
  endif
else
  syntax clear
endif

setlocal iskeyword=-,_,@,48-57
setlocal isfname=-,_,@,48-57

" Case-sensitive
syn case match

" Documentation
syn region dmTitle start="/// " end="$"
syn region dmComment start="// " end="$"

syn region dmExample matchgroup=dmMatch start="example: \"*" end="\"*$"

" Keywords
syn keyword dmKeyword volatile nextgroup=dmKeyword,dmType skipwhite skipempty
syn keyword dmKeyword read\-only nextgroup=dmKeyword,dmType skipwhite skipempty
syn keyword dmKeyword status nextgroup=dmKeyword,dmType skipwhite skipempty

" Handlers
syn region dmCommit matchgroup=dmMatch start="\(instance \)\=commit with \"" end="\""
syn region dmRead matchgroup=dmMatch start="\(instance \)\=read with \"" end="\""
syn region dmValidate matchgroup=dmMatch start="\(instance \)\=validate with \"" end="\""
syn region dmDefault matchgroup=dmMatch start="\(instance \)\=default with \"" end="\""
syn region dmExecute matchgroup=dmMatch start="\(instance \)\=execute with \"" end="\""

hi def link dmCommit            dmHandler
hi def link dmRead              dmHandler
hi def link dmValidate          dmHandler
hi def link dmDefault           dmHandler
hi def link dmExecute           dmHandler

" Field names
syn match dmObjectName "\w*\ {"he=e-2
syn match dmObjectName "\w*,"he=e-1
syn match dmObjectName "\w*\[\]"he=e-2

" Multiobjects
syn region dmMultiObjectName matchgroup=dmObjectName start="\w*\[" end="\]" contains=dmMultiObjectKey transparent keepend
syn region dmMultiObjectKey matchgroup=dmMatch start="key\s*=\s*\"" end="\"\]" contained

" Types
syn keyword dmType rpc object String bool u64 i64 u32 i32 u16 i16 u8 i8 nextgroup=dmObjectName skipwhite skipempty

" Now we can link them with predefined groups.
hi def link dmTitle             SpecialComment
hi def link dmComment           Comment
hi def link dmExample           Keyword
hi def link dmKeyword           StorageClass
hi def link dmType              Type
hi def link dmObjectName        Constant
hi def link dmMultiObjectKey    Identifier
hi def link dmMatch             Statement
hi def link dmHandler           String

" Mark the buffer as highlighted.
let b:current_syntax = "dm"
