export default function (params: { [x: string]: any }) {
  let before = params['before']
  let after = params['after']

  let first, last
  if (!!before) {
    last = 20
  } else {
    first = 20
  }

  return { before, after, first, last }
}
