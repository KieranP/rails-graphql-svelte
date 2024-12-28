export const base64Decode = (value: string | undefined): string => {
  if (value === undefined) return ''
  return atob(value.replace(/_/g, '/').replace(/-/g, '+'))
}
