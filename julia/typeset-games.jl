using Hyperscript, Printf

@tags table td tr 

function game1(S1, S2, u; caption="")
    strategy(s) = @sprintf("\$\\mathsf{%s}\$", s)
    ltx(s) = @sprintf("\$%s\$", s)
    n = size(S1, 1)
    m = size(S2, 1)
    
    # Create header row cells
    header_cells = [td(strategy(S2[j])) for j in 1:m]
    
    # Create data rows
    data_rows = []
    for i in 1:n
        row_cells = [td(strategy(S1[i]))]
        for j in 1:m
            push!(row_cells, td(ltx(u[i,j])))
        end
        push!(data_rows, tr(row_cells))
    end
    
    # Combine all elements
    table_elements = []
    if caption != ""
        push!(table_elements, Hyperscript.m("caption", caption))
    end
    push!(table_elements, tr([td(), header_cells...]))
    append!(table_elements, data_rows)
    
    # Create the final table
    doc = table(class="game1",
                dataQuartoDisableProcessing="true",
                align="center",
                table_elements)
    
    return doc
end

function game(S1, S2, u1, u2; caption="")
    strategy(s) = @sprintf("\$\\mathsf{%s}\$", s)
    ltx(s) = @sprintf("\$%s\$", s)
    n = size(S1, 1)
    m = size(S2, 1)
    
    # Create header row cells
    header_cells = [td(colspan="2", strategy(S2[j])) for j in 1:m]
    
    # Create data rows
    data_rows = []
    for i in 1:n
        row_cells = [td(strategy(S1[i]))]
        for j in 1:m
            push!(row_cells, td(ltx(u1[i,j])))
            push!(row_cells, td(ltx(u2[i,j])))
        end
        push!(data_rows, tr(row_cells))
    end
    
    # Combine all elements
    table_elements = []
    if caption != ""
        push!(table_elements, Hyperscript.m("caption", caption))
    end
    push!(table_elements, tr([td(), header_cells...]))
    append!(table_elements, data_rows)
    
    # Create the final table
    doc = table(class="game",
                dataQuartoDisableProcessing="true",
                align="center",
                table_elements)
    
    return doc
end
