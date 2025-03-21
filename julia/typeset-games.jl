using Hyperscript, Printf, Latexify

@tags table td tr 

v_maxmin(u) = maximum(minimum(u, dims=2))
v_minmax(u) = minimum(maximum(u, dims=1))

function game1(S1, S2, u; caption="", minmax=false)
    strategy(s) = @sprintf("\$\\mathsf{%s}\$", s)
    n = size(S1, 1)
    m = size(S2, 1)
    
    # Create header row cells
    header_cells = [td(strategy(S2[j])) for j in 1:m]

    if minmax
        push!(header_cells, td("\$\\min_{s_2 \\in \\ALPHABET S_2} u(s_1, s_2)\$"))
    end
    
    # Create data rows
    data_rows = []
    for i in 1:n
        row_cells = [td(strategy(S1[i]))]
        for j in 1:m
            push!(row_cells, td(latexify(u[i,j])))
        end
        if minmax
            push!(row_cells, td(latexify(minimum(u[i,:]))))
        end
        push!(data_rows, tr(row_cells))
    end

    if minmax
        row_cells = [td("\$\\max_{s_1 \\in \\ALPHABET S_1} u(s_1, s_2)\$")]
        for j in 1:m 
            push!(row_cells, td(latexify(maximum(u[:,j]))))
        end
        final = latexify(v_maxmin(u)) * ", " * latexify(v_minmax(u))
        push!(row_cells, td(final))
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
    class = minmax ? "game1min" : "game1"
    doc = table(class=class,
                dataQuartoDisableProcessing="true",
                align="center",
                table_elements)
    
    return doc
end

function game(S1, S2, u1, u2; caption="")
    strategy(s) = @sprintf("\$\\mathsf{%s}\$", s)
    n = size(S1, 1)
    m = size(S2, 1)
    
    # Create header row cells
    header_cells = [td(colspan="2", strategy(S2[j])) for j in 1:m]
    
    # Create data rows
    data_rows = []
    for i in 1:n
        row_cells = [td(strategy(S1[i]))]
        for j in 1:m
            push!(row_cells, td(latexify(u1[i,j])))
            push!(row_cells, td(latexify(u2[i,j])))
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

function game3(S1, S2, u1, u2, u3; caption="")
    strategy(s) = @sprintf("\$\\mathsf{%s}\$", s)
    n = size(S1, 1)
    m = size(S2, 1)
    
    # Create header row cells
    header_cells = [td(colspan="3", strategy(S2[j])) for j in 1:m]
    
    # Create data rows
    data_rows = []
    for i in 1:n
        row_cells = [td(strategy(S1[i]))]
        for j in 1:m
            push!(row_cells, td(latexify(u1[i,j])))
            push!(row_cells, td(latexify(u2[i,j])))
            push!(row_cells, td(latexify(u3[i,j])))
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
    doc = table(class="game3",
                dataQuartoDisableProcessing="true",
                align="center",
                table_elements)
    
    return doc
end
