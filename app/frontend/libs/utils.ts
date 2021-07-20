export const base64Decode = (value:string) => (
  atob(value.replace(/_/g, '/').replace(/-/g, '+'))
)
