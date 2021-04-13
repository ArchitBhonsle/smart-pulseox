export default function fetcher(...args) {
  args[0] = 'http://localhost:4000' + args[0];
  args[1] = {
    ...args[1],
    credentials: 'include',
  };

  return fetch(...args).then(res => res.json());
}
