import useSWR from 'swr';
import { Heading, Box } from '@chakra-ui/react';

import easyFetch from './utils/easyFetch';
import { useEffect } from 'react';

function App() {
  const { data, error } = useSWR('/');

  useEffect(() => {
    (async () => {
      const response = await easyFetch('/', { hello: 'world' });
      console.log(response);
    })();
  }, []);

  console.log(data, error);

  return (
    <div className='App'>
      <Box w='100%' px={{ base: 8, lg: '15%' }} py={4}>
        <Heading py={3}>Smart Pulse-Oximeter</Heading>
      </Box>
    </div>
  );
}

export default App;
