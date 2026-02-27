
return {
    traverse = 'topdown',
    Div = function(div)
        if div.attributes['floatnote'] then
            local floatnote = div.attributes['floatnote']:gsub('%%', '\\%%')
            print(floatnote, '\n')
            local blocks = pandoc.List({})
            if div.attributes['tbl-cap'] then
                -- For tables: keep the div so pandoc creates the table float,
                -- then place floatnote before so it latches to that float
                blocks:insert(pandoc.RawBlock('latex', '\\floatnote{' .. floatnote .. '}'))
                div.attributes['floatnote'] = nil
                blocks:insert(div)
            else
                -- For figures: unwrap div; figure float comes directly from knitr output
                blocks:insert(pandoc.RawInline('latex', '\\floatnote{' .. floatnote .. '}'))
                blocks:extend(div.content)
            end
            return blocks
        end
        return div
    end
}
