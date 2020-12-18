export default function(location) {
  let search = location.search
  let params = new URLSearchParams(search)
  let before = params.get('before')
  let after = params.get('after')

  let first, last
  if (!!before) {
    last = 20
  } else {
    first = 20
  }

  return {before, after, first, last}
}
