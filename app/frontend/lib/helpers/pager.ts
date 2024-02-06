export default function (params: URLSearchParams) {
  const before = params.get('before')
  const after = params.get('after')

  let first, last
  if (before !== null) {
    last = 20
  } else {
    first = 20
  }

  return { before, after, first, last }
}
