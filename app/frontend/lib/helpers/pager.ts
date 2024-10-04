export default function (params: URLSearchParams) {
  const before = params.get('before')
  const after = params.get('after')

  let first, last
  if (before === null) {
    first = 20
  } else {
    last = 20
  }

  return { before, after, first, last }
}
