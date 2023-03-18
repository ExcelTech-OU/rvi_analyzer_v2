import { CssBaseline, ThemeProvider } from '@mui/material'
import React from 'react'
import ReactDOM from 'react-dom/client'
import { Provider } from 'react-redux'
import { BrowserRouter, Route, Routes } from 'react-router-dom'
import App from './App'


import { store } from './store/store'
import { theme } from './theme'
import Login from './views/auth/login/login'
import Dashboard from './views/dashboard/dashboard'
import Devices from './views/device/view/DeviceList'
import QuestionList from './views/question/QuestionList'
import SessionList from './views/session/SessionList'
import UserList from './views/user/view/UserList'

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Provider store={store}>
        <BrowserRouter>
          <App>
            <Routes>
              <Route path="/devices" element={<Devices />} />
              <Route path="/users" element={<UserList />} />
              <Route path="/questions" element={<QuestionList />} />
              <Route path="/sessions/:type?/:id?" element={<SessionList />} />
              <Route path="/login" element={<Login />} />
              <Route path='*' element={<Dashboard />} />
            </Routes>
          </App>
        </BrowserRouter>
      </Provider>
    </ThemeProvider>
  </React.StrictMode>,
)
