
return {
    traverse = 'topdown',
    Div = function(div)
        if div.attributes['floatnote'] then
            local floatnote = div.attributes['floatnote']
            print(floatnote, '\n')
            local blocks = pandoc.List({})
            -- floatnote latches to next float, so place before
            blocks:insert(pandoc.RawInline('latex', '\\floatnote{' .. floatnote .. '}'))
            blocks:extend(div.content)
            return blocks
        end
        return div
    end
}
