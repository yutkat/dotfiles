augroup vimrc_graphql_ftdetect
  autocmd!
  autocmd BufRead,BufNewFile *.graphql,*.graphqls,*.gql setfiletype graphql
augroup END
