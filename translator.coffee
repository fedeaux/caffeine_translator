_tk = (string, replace) ->
  for name, value of replace
    if ! is_string(value)
      delete replace[name]
    else
      string = string.replace('\$'+name, value)

  return string

@_t = (path, map = {}) ->
  curr = translations
  parts = path.split '.'

  not_found = false

  for part in parts
    if curr[part]?
      curr = curr[part]
    else
      not_found = true
      break

  if(not_found)
    if translations.common? and translations.common[parts.slice(-1)]?
      curr = translations.common[parts.slice(-1)]

    else
      return '<span> (translator) Not Found: '+path+'&nbsp&nbsp</span>'

  if(is_array(curr))
    return '<span> (translator) Incomplete Path: '+path+'&nbsp&nbsp</span>'

  if(map.length == 0)
    return curr

  return _tk curr, map
