import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import reportWebVitals from './reportWebVitals';

import './index.css';

import { ChakraProvider } from '@chakra-ui/react';
import { SWRConfig } from 'swr';

import fetcher from './utils/fetcher';

ReactDOM.render(
  <React.StrictMode>
    <ChakraProvider>
      <SWRConfig value={{ fetcher }}>
        <App />
      </SWRConfig>
    </ChakraProvider>
  </React.StrictMode>,
  document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
