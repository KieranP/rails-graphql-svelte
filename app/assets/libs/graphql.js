export default async function request(query, variables = {}) {
  const endpoint = import.meta.env.SNOWPACK_PUBLIC_API_ENDPOINT

  return fetch(endpoint, {
    method: 'POST',
    credentials: 'include',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    body: JSON.stringify({ query, variables })
  }).then(r => r.json())
}
