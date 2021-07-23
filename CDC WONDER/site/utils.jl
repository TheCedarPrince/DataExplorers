using Weave

function hfun_bar(vname)
    val = Meta.parse(vname[1])
    return round(sqrt(val), digits = 2)
end

function hfun_m1fill(vname)
    var = vname[1]
    return pagevar("index", var)
end

function lx_baz(com, _)
    # keep this first line
    brace_content = Franklin.content(com.braces[1]) # input string
    # do whatever you want here
    return uppercase(brace_content)
end

function hfun_weave2html(document)
    f_name = tempname(pwd()) * ".html"
    weave(first(document), out_path = f_name)
    text = read(f_name, String)
    final =
        "<!DOCTYPE html>\n<HTML lang = \"en\">" * split(text, "</HEAD>")[2] |>
        x ->
            replace(x, r"<span class='hljl-.*?>" => "") |>
            x ->
                replace(x, "</span>" => "") |>
                x ->
                    replace(
                        x,
                        "<pre class='hljl'>\n" => "<pre><code class = \"language-julia\">",
                    ) |> x -> replace(x, "</pre>" => "</code></pre>")
    rm(f_name)
    return final
end


