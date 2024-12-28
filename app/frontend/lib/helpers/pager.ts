export default function (params: URLSearchParams): {
  before: string | null
  after: string | null
  first: number | undefined
  last: number | undefined
} {
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
