using Hyperscript, Printf

@tags table td tr 

function game1(S1, S2, u; caption="")
  strategy(s) = @sprintf("\$\\mathsf{%s}\$", s)
  ltx(s) = @sprintf("\$%s\$", s)

  n = size(S1, 1)
  m = size(S2, 1)
  doc = table.game1(dataQuartoDisableProcessing="true", 
              align="center",
              caption == "" ? () : Hyperscript.m("caption", caption),  
    tr( td(), [td(strategy(S2[j])) for j in 1:m] ),
[ tr( td(strategy(S1[i])), [td(ltx(u[i,j])) for j in 1:m]) for i in 1:n]
  )
  return doc
end


