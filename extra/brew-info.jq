def filter_deps:
  .[] | if .installed[].installed_on_request then . else empty end
;

def get_options:
  .installed[].used_options | join (" ")
;

def head_option:
  if (.installed[].version | test("^HEAD-")) then "--HEAD" else "" end
;

def from_source_option:
  if (.versions.bottle) and (.installed[].poured_from_bottle | not) then "-s" else "" end
;

def parts:
  [.name, get_options, head_option, from_source_option]
;

def raw_line:
  [parts[] | select(. != "")] | join(" ")
;

filter_deps | raw_line
