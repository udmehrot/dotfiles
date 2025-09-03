    ;; Inject JavaScript/JSX into MDX
    (jsx_element
      (jsx_opening_element
        (jsx_identifier) @injection.content
        (#set! injection.language "jsx")))

    (jsx_self_closing_element
      (jsx_identifier) @injection.content
      (#set! injection.language "jsx"))

    (jsx_text
      (jsx_expression
        (javascript) @injection.content
        (#set! injection.language "javascript")))
